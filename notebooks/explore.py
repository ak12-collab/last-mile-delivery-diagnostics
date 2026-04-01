import pandas as pd

df = pd.read_parquet('data/yellow_tripdata_2026-01.parquet')

print("Shape:", df.shape)
print("\nColumns:", df.columns.tolist())
print("\nDtypes:\n", df.dtypes)
print("\nSample row:")
print(df.head(2).to_string())
print("\nNulls:")
print(df.isnull().sum())