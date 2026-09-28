import sqlite3
import pandas as pd
from pathlib import Path


# 프로젝트 경로
BASE_DIR = Path(__file__).resolve().parent.parent

CSV_PATH = (
    BASE_DIR
    / "data"
    / "서울교통공사_역별 일별 시간대별 승하차인원_20251231.csv"
)

DB_PATH = BASE_DIR / "database" / "subway.db"
SCHEMA_PATH = BASE_DIR / "sql" / "schema.sql"


# 1. CSV 불러오기
df = pd.read_csv(CSV_PATH, encoding="cp949")

# 완전히 비어 있는 행 제거
df = df.dropna(how="all")

print("CSV loaded")
print("Rows:", len(df))


# 2. 분석에 필요 없는 '연번' 컬럼 제거
df = df.drop(columns=["연번"])


# 3. DB에서 사용할 영문 컬럼명으로 변경
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


# 4. SQLite 연결
conn = sqlite3.connect(DB_PATH)

try:
    # schema.sql 실행
    with open(SCHEMA_PATH, "r", encoding="utf-8") as f:
        conn.executescript(f.read())

    # 5. 데이터 적재
    df.to_sql(
        "subway_ridership",
        conn,
        if_exists="append",
        index=False
    )

    conn.commit()

    # 6. 정상 적재 확인
    count = conn.execute(
        "SELECT COUNT(*) FROM subway_ridership"
    ).fetchone()[0]

    print("Database created successfully.")
    print("Inserted rows:", count)

finally:
    conn.close()