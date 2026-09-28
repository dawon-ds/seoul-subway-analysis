DROP TABLE IF EXISTS subway_ridership;

CREATE TABLE subway_ridership (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    line TEXT NOT NULL,
    station_code INTEGER NOT NULL,
    station_name TEXT NOT NULL,
    direction TEXT NOT NULL,

    before_06 INTEGER,
    hour_06_07 INTEGER,
    hour_07_08 INTEGER,
    hour_08_09 INTEGER,
    hour_09_10 INTEGER,
    hour_10_11 INTEGER,
    hour_11_12 INTEGER,
    hour_12_13 INTEGER,
    hour_13_14 INTEGER,
    hour_14_15 INTEGER,
    hour_15_16 INTEGER,
    hour_16_17 INTEGER,
    hour_17_18 INTEGER,
    hour_18_19 INTEGER,
    hour_19_20 INTEGER,
    hour_20_21 INTEGER,
    hour_21_22 INTEGER,
    hour_22_23 INTEGER,
    hour_23_24 INTEGER,
    after_24 INTEGER
);