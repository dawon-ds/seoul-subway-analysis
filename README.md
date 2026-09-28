# Seoul Subway Ridership Analysis

Analysis of Seoul Metro ridership data using SQLite, SQL, and Python.

The project builds a SQLite database from raw public transportation data and analyzes ridership patterns by station, subway line, time of day, weekday/weekend, and month.

## Tech Stack

- Python
- SQLite
- SQL
- pandas
- matplotlib
- Jupyter Notebook

## Data

Seoul Metro Daily Hourly Ridership Data (2025)  
Source: Seoul Open Data Plaza

The dataset contains daily boarding and alighting counts for Seoul Metro Lines 1–8, divided by station and hourly time period.

A total of 199,290 records were loaded into SQLite after removing empty rows.

Raw data is not included in this repository.

## Database

The raw CSV data is cleaned with pandas and loaded into a SQLite database using a predefined schema.

```text
CSV
 ↓
pandas
 ↓
SQLite
 ↓
SQL queries
 ↓
pandas
 ↓
Visualization
```

The database schema is defined in `sql/schema.sql`, and the data loading process is implemented in `src/load_data.py`.

## Analysis

### Ridership by Subway Line

Line 2 recorded the highest total number of entries and exits among Seoul Metro Lines 1–8.

![Ridership by Line](outputs/passengers_by_line.png)

### Ridership by Time of Day

Ridership shows two clear peaks during commuting hours, with the highest levels around 08:00–09:00 and 18:00–19:00.

![Ridership by Time](outputs/passengers_by_time.png)

### Weekday vs Weekend

Average daily ridership was approximately:

- Weekday: 9.81 million entries and exits
- Weekend: 6.56 million entries and exits

Weekday ridership was approximately 49.6% higher than weekend ridership.

![Weekday vs Weekend](outputs/weekday_vs_weekend.png)

### Monthly Ridership

Monthly ridership varied throughout 2025, with the highest total recorded in December.

![Monthly Ridership](outputs/monthly_passengers.png)

### Boarding and Alighting Differences

Stations with the largest differences between boarding and alighting volumes were identified using conditional aggregation in SQL.

![Boarding and Alighting](outputs/boarding_alighting_difference.png)

## SQL

The analysis uses SQL operations including:

- `GROUP BY`
- `SUM`
- `ORDER BY`
- `CASE WHEN`
- `COUNT(DISTINCT)`
- `strftime()`

Example:

```sql
SELECT
    line,
    SUM(
        before_06 +
        hour_06_07 +
        hour_07_08 +
        hour_08_09
    ) AS total_passengers
FROM subway_ridership
GROUP BY line
ORDER BY total_passengers DESC;
```

Full queries are available in `sql/queries.sql`.

## Project Structure

```text
seoul-subway-analysis/
├── outputs/
│   ├── boarding_alighting_difference.png
│   ├── monthly_passengers.png
│   ├── passengers_by_line.png
│   ├── passengers_by_time.png
│   └── weekday_vs_weekend.png
├── sql/
│   ├── queries.sql
│   └── schema.sql
├── src/
│   └── load_data.py
├── analysis.ipynb
├── README.md
├── requirements.txt
└── .gitignore
```

## Run

Install dependencies:

```bash
pip install -r requirements.txt
```

Place the original CSV file in the `data/` directory and create the SQLite database:

```bash
python src/load_data.py
```

Run `analysis.ipynb` to reproduce the analysis and visualizations.