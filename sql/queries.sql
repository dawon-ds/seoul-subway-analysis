-- ============================================================
-- Seoul Subway Ridership Analysis
-- Dataset: Seoul Metro Daily Hourly Ridership Data (2025)
-- Database: SQLite
-- ============================================================


-- ============================================================
-- 1. Top 10 busiest stations
--    Total entries and exits grouped by station name
-- ============================================================

SELECT
    station_name,
    SUM(
        before_06 +
        hour_06_07 +
        hour_07_08 +
        hour_08_09 +
        hour_09_10 +
        hour_10_11 +
        hour_11_12 +
        hour_12_13 +
        hour_13_14 +
        hour_14_15 +
        hour_15_16 +
        hour_16_17 +
        hour_17_18 +
        hour_18_19 +
        hour_19_20 +
        hour_20_21 +
        hour_21_22 +
        hour_22_23 +
        hour_23_24 +
        after_24
    ) AS total_passengers
FROM subway_ridership
GROUP BY station_name
ORDER BY total_passengers DESC
LIMIT 10;


-- ============================================================
-- 2. Total entries and exits by subway line
-- ============================================================

SELECT
    line,
    SUM(
        before_06 +
        hour_06_07 +
        hour_07_08 +
        hour_08_09 +
        hour_09_10 +
        hour_10_11 +
        hour_11_12 +
        hour_12_13 +
        hour_13_14 +
        hour_14_15 +
        hour_15_16 +
        hour_16_17 +
        hour_17_18 +
        hour_18_19 +
        hour_19_20 +
        hour_20_21 +
        hour_21_22 +
        hour_22_23 +
        hour_23_24 +
        after_24
    ) AS total_passengers
FROM subway_ridership
GROUP BY line
ORDER BY total_passengers DESC;


-- ============================================================
-- 3. Ridership by time of day
-- ============================================================

SELECT
    SUM(before_06) AS before_06,
    SUM(hour_06_07) AS hour_06_07,
    SUM(hour_07_08) AS hour_07_08,
    SUM(hour_08_09) AS hour_08_09,
    SUM(hour_09_10) AS hour_09_10,
    SUM(hour_10_11) AS hour_10_11,
    SUM(hour_11_12) AS hour_11_12,
    SUM(hour_12_13) AS hour_12_13,
    SUM(hour_13_14) AS hour_13_14,
    SUM(hour_14_15) AS hour_14_15,
    SUM(hour_15_16) AS hour_15_16,
    SUM(hour_16_17) AS hour_16_17,
    SUM(hour_17_18) AS hour_17_18,
    SUM(hour_18_19) AS hour_18_19,
    SUM(hour_19_20) AS hour_19_20,
    SUM(hour_20_21) AS hour_20_21,
    SUM(hour_21_22) AS hour_21_22,
    SUM(hour_22_23) AS hour_22_23,
    SUM(hour_23_24) AS hour_23_24,
    SUM(after_24) AS after_24
FROM subway_ridership;


-- ============================================================
-- 4. Weekday vs weekend ridership
--    Includes number of days so daily averages can be compared
-- ============================================================

SELECT
    CASE
        WHEN strftime('%w', date) IN ('0', '6') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    COUNT(DISTINCT date) AS number_of_days,

    SUM(
        before_06 +
        hour_06_07 +
        hour_07_08 +
        hour_08_09 +
        hour_09_10 +
        hour_10_11 +
        hour_11_12 +
        hour_12_13 +
        hour_13_14 +
        hour_14_15 +
        hour_15_16 +
        hour_16_17 +
        hour_17_18 +
        hour_18_19 +
        hour_19_20 +
        hour_20_21 +
        hour_21_22 +
        hour_22_23 +
        hour_23_24 +
        after_24
    ) AS total_passengers

FROM subway_ridership
GROUP BY day_type;


-- ============================================================
-- 5. Boarding and alighting totals by station
-- ============================================================

SELECT
    station_name,

    SUM(
        CASE
            WHEN direction = '승차' THEN
                before_06 +
                hour_06_07 +
                hour_07_08 +
                hour_08_09 +
                hour_09_10 +
                hour_10_11 +
                hour_11_12 +
                hour_12_13 +
                hour_13_14 +
                hour_14_15 +
                hour_15_16 +
                hour_16_17 +
                hour_17_18 +
                hour_18_19 +
                hour_19_20 +
                hour_20_21 +
                hour_21_22 +
                hour_22_23 +
                hour_23_24 +
                after_24
            ELSE 0
        END
    ) AS boardings,

    SUM(
        CASE
            WHEN direction = '하차' THEN
                before_06 +
                hour_06_07 +
                hour_07_08 +
                hour_08_09 +
                hour_09_10 +
                hour_10_11 +
                hour_11_12 +
                hour_12_13 +
                hour_13_14 +
                hour_14_15 +
                hour_15_16 +
                hour_16_17 +
                hour_17_18 +
                hour_18_19 +
                hour_19_20 +
                hour_20_21 +
                hour_21_22 +
                hour_22_23 +
                hour_23_24 +
                after_24
            ELSE 0
        END
    ) AS alightings

FROM subway_ridership
GROUP BY station_name;


-- ============================================================
-- 6. Monthly ridership trend
-- ============================================================

SELECT
    strftime('%m', date) AS month,

    SUM(
        before_06 +
        hour_06_07 +
        hour_07_08 +
        hour_08_09 +
        hour_09_10 +
        hour_10_11 +
        hour_11_12 +
        hour_12_13 +
        hour_13_14 +
        hour_14_15 +
        hour_15_16 +
        hour_16_17 +
        hour_17_18 +
        hour_18_19 +
        hour_19_20 +
        hour_20_21 +
        hour_21_22 +
        hour_22_23 +
        hour_23_24 +
        after_24
    ) AS total_passengers

FROM subway_ridership
GROUP BY month
ORDER BY month;