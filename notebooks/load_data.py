import pandas as pd
from sqlalchemy import create_engine, text

# 1. Load parquet
df = pd.read_parquet('data/yellow_tripdata_2026-01.parquet')
print(f"Raw rows: {len(df):,}")

# 2. Keep only columns we need
df = df[[
    'tpep_pickup_datetime',
    'tpep_dropoff_datetime',
    'PULocationID',
    'DOLocationID',
    'trip_distance',
    'fare_amount',
    'congestion_surcharge'
]]

# 3. Clean data
df = df[
    (df['trip_distance'] > 0) &
    (df['fare_amount'] > 0) &
    (df['tpep_dropoff_datetime'] > df['tpep_pickup_datetime'])
].copy()

df = df.dropna(subset=[
    'tpep_pickup_datetime',
    'tpep_dropoff_datetime',
    'PULocationID',
    'DOLocationID'
])

df['duration_mins'] = (
    df['tpep_dropoff_datetime'] - df['tpep_pickup_datetime']
).dt.total_seconds() / 60

df = df[df['duration_mins'].between(1, 180)]
print(f"Clean rows: {len(df):,}")

# 4. Rename to delivery domain language
df = df.rename(columns={
    'tpep_pickup_datetime'  : 'dispatch_time',
    'tpep_dropoff_datetime' : 'delivery_time',
    'PULocationID'          : 'origin_zone',
    'DOLocationID'          : 'destination_zone',
    'trip_distance'         : 'distance_miles',
    'fare_amount'           : 'delivery_cost',
    'congestion_surcharge'  : 'congestion_charge'
})

# 5. Add derived fields
df['route_id'] = (
    df['origin_zone'].astype(str) + '_' +
    df['destination_zone'].astype(str)
)

df['expected_duration_mins'] = (
    df['distance_miles'] * 2 + 5
).round()

df['delay_mins'] = (
    df['duration_mins'] - df['expected_duration_mins']
).round(2)

df['sla_breach_flag'] = (df['delay_mins'] > 10).astype(int)

df['dispatch_hour'] = df['dispatch_time'].dt.hour

df['day_of_week'] = df['dispatch_time'].dt.day_name()

df['time_window'] = df['dispatch_hour'].apply(
    lambda h: 'peak' if (7 <= h <= 10 or 17 <= h <= 20) else 'off_peak'
)

df['day_type'] = df['day_of_week'].apply(
    lambda d: 'weekend' if d in ['Saturday','Sunday'] else 'weekday'
)

print(f"SLA breach rate: {df['sla_breach_flag'].mean()*100:.1f}%")
print(f"Avg delay: {df['delay_mins'].mean():.1f} mins")

# 6. Connect to MySQL
engine = create_engine(
    'mysql+pymysql://root:Akshay12%40@localhost/delivery_db',
    connect_args={'connect_timeout': 30}
)

# Create database
print("Database confirmed.")

# Reconnect to database
engine = create_engine(
    'mysql+pymysql://root:Akshay12%40@localhost/delivery_db'
)

# Load in chunks
print("Loading to MySQL - this takes 3-5 minutes...")
df.to_sql(
    name='raw_trips',
    con=engine,
    if_exists='replace',
    index=False,
    chunksize=10000
)

print(f"Done. {len(df):,} rows loaded into delivery_db.raw_trips")