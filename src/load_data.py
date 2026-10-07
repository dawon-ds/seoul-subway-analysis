import sqlite3
import pandas as pd
from pathlib import Path


# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent

CSV_PATH = (
    BASE_DIR
    / "data"
    / "서울교통공사_역별 일별 시간대별 승하차인원_20251231.csv"
)

DB_PATH = BASE_DIR / "database" / "subway.db"
SCHEMA_PATH = BASE_DIR / "sql" / "schema.sql"


# Load raw CSV data
df = pd.read_csv(CSV_PATH, encoding="cp949")

# Remove completely empty rows
df = df.dropna(how="all")

print("CSV loaded")
print("Rows:", len(df))


# Remove the unnecessary sequence column
df = df.drop(columns=["연번"])


# Rename columns for the database
df.columns = [
    "date",
    "line",
    "station_code",
    "station_name",
    "direction",
    "before_06",
    "hour_06_07",
    "hour_07_08",
    "hour_08_09",
    "hour_09_10",
    "hour_10_11",
    "hour_11_12",
    "hour_12_13",
    "hour_13_14",
    "hour_14_15",
    "hour_15_16",
    "hour_16_17",
    "hour_17_18",
    "hour_18_19",
    "hour_19_20",
    "hour_20_21",
    "hour_21_22",
    "hour_22_23",
    "hour_23_24",
    "after_24"
]


# Create the database directory
DB_PATH.parent.mkdir(parents=True, exist_ok=True)

# Connect to SQLite
conn = sqlite3.connect(DB_PATH)

try:
    # Create the database schema
    with open(SCHEMA_PATH, "r", encoding="utf-8") as f:
        conn.executescript(f.read())

    # Load data into SQLite
    df.to_sql(
        "subway_ridership",
        conn,
        if_exists="append",
        index=False
    )

    conn.commit()

    # Verify the number of inserted records
    count = conn.execute(
        "SELECT COUNT(*) FROM subway_ridership"
    ).fetchone()[0]

    print("Database created successfully.")
    print("Inserted rows:", count)

finally:
    conn.close()
