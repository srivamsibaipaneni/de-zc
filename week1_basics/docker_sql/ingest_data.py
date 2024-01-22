import pandas as pd
from sqlalchemy import create_engine
import os

user = "root"
password = "root"
host = "pg-database"
port = 5432
db = "ny_taxi_db"
table_name = "yellow_taxi_data"
parquet_name = 'output.parquet'
url = "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2021-01.parquet"

os.system(f'wget {url} -O {parquet_name}')

engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
df = pd.read_parquet("/app/output.parquet")
df.to_csv("/app/y_data.csv")
df_iter = pd.read_csv("/app/y_data.csv", iterator=True, chunksize=10000)

df = next(df_iter)
df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)

df.head(0).to_sql(name = table_name, con=engine, if_exists='replace')

df.to_sql(name = table_name, con=engine, if_exists='append')
count = 1

while True:
    df = next(df_iter)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.to_sql(name = table_name, con=engine, if_exists='append')
    print(f'inserted chunk{count}')
    count = count+1


