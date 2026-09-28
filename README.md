# Seoul Subway Ridership Analysis

A data analysis project exploring **2025 Seoul Metro ridership patterns** using SQLite, SQL, and Python.

The project converts raw public transportation data into a structured SQLite database, performs SQL-based analysis, and visualizes the results with pandas and matplotlib.

## What I Did

- Built a SQLite database from **199,290 subway ridership records**
- Designed the database schema and loaded cleaned CSV data using Python
- Wrote SQL queries to analyze ridership by station, line, time, day type, and month
- Used conditional aggregation to compare boarding and alighting patterns
- Visualized SQL query results with pandas and matplotlib

## Tech Stack

`Python` · `SQLite` · `SQL` · `pandas` · `matplotlib` · `Jupyter Notebook`

## Key Findings

- **Line 2** recorded the highest total entries and exits among Lines 1–8.
- Ridership showed clear commuting peaks around **08:00–09:00** and **18:00–19:00**.
- Average weekday ridership was approximately **9.81M**, compared with **6.56M** on weekends.
- Average daily weekday ridership was approximately **49.6% higher** than weekend ridership.
- **December** recorded the highest monthly ridership in 2025.

## Analysis

### Ridership by Subway Line

![Ridership by Line](outputs/passengers_by_line.png)

### Ridership by Time of Day

![Ridership by Time](outputs/passengers_by_time.png)

### Weekday vs Weekend

![Weekday vs Weekend](outputs/weekday_vs_weekend.png)

### Monthly Ridership

![Monthly Ridership](outputs/monthly_passengers.png)

### Boarding vs Alighting Difference

Positive values indicate more boardings than alightings, while negative values indicate more alightings than boardings.

![Boarding and Alighting Difference](outputs/boarding_alighting_difference.png)

## Database & SQL

The analysis follows this workflow:

```text
Raw CSV
   ↓
Data Cleaning
   ↓
SQLite Database
   ↓
SQL Analysis
   ↓
pandas
   ↓
Visualization
```

The database schema is defined in [`sql/schema.sql`](sql/schema.sql), and the complete analysis queries are available in [`sql/queries.sql`](sql/queries.sql).

SQL techniques used include:

`GROUP BY` · `SUM` · `ORDER BY` · `CASE WHEN` · `COUNT(DISTINCT)` · `strftime()`

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

## Data

**Seoul Metro Daily Hourly Ridership Data (2025)**  
Source: Seoul Open Data Plaza

The dataset contains daily boarding and alighting counts for Seoul Metro Lines 1–8 by station and time period.

Raw data and the generated SQLite database are excluded from this repository.

## Run

Install the required packages:

```bash
pip install -r requirements.txt
```

Place the original CSV file in the `data/` directory and build the database:

```bash
python src/load_data.py
```

Then run `analysis.ipynb` to reproduce the analysis and visualizations.
