
# R2 Data Engineering Assessment - Snowflake Analytics Pipeline

## Overview

This project contains my solution for the Senior Analytics Engineer assessment for R2.  
The goal was to build an end-to-end Snowflake-based data pipeline to ingest, transform, and model SMB lending data to support BI and risk analytics.

I choose a layered architecture (Raw → Staging → Marts), applying dimensional modeling (Kimball), with strong focus on data quality, incremental processing, and Tableau-ready reporting views.

## Repository Structure

- `/sql/` → All Snowflake SQL scripts: setup, ingestion, staging, dimensions, facts, marts, and reports.
- `/docs/` → Design documentation, data dictionary and open questions for the product team.
- `/monitoring/` → Data quality checks and orchestration strategy.
- `/sample_data/` → Optional CSV samples for testing.

## Setup Instructions

1. Create a Snowflake database: `r2_analytics_assessment`
2. Run SQL scripts in this order:

```
01_setup.sql
02_ingestion.sql
03_staging.sql
04_dimensions.sql
05_facts.sql
06_marts.sql
07_reports.sql
```

3. Run data quality checks:

```
/monitoring/data_quality.sql
```

4. Connect Tableau or BI tool to the `marts` schema for reporting.

## Design Decisions and Trade-offs

### Why I chose Raw → Staging → Marts architecture (and not others)

I preferred a layered architecture instead of doing all transformations in one big step (ELT single-layer) or loading directly from files into final marts.

**Reasons:**

- **Traceability:** Having raw and staging layers allows tracking exactly what came from source and what was transformed.
- **Easier Debugging:** If something goes wrong, I can isolate the issue by checking each layer separately.
- **Scalability:** As data volume grows, this separation will help optimize parts of the pipeline without breaking others.
- **Data Quality Control:** Doing validation between raw and staging gives better control over bad data. If I had chosen a direct-load-to-marts approach, error tracing would be harder.

### Why I used SCD Type 2 for Merchants

I used Slowly Changing Dimension Type 2 for the `dim_merchants` table because in lending and risk analysis, historical profile changes matter.

**Alternatives considered:**

- Type 1: Would overwrite history (bad for risk trend analysis)
- Type 3: Limited to only latest change (too restrictive)

So SCD2 gives the best balance between history tracking and query performance.

### Why I did not use Streams, Tasks or dbt

I avoided Streams, Tasks, and dbt for now for three reasons:

1. Time constraints of the assessment
2. Clarity over complexity for code review
3. R2 requested Snowflake-native SQL as priority

But the current design allows easy future migration to more advanced orchestration (e.g., Airflow, dbt Cloud or Snowflake Tasks).

### Why I delivered Reporting Layer as SQL Views (and not Materialized Views)

I created SQL views for flexibility in Tableau analysis.  
Materialized Views would improve performance but would require more storage and periodic refresh logic.  
Given the assessment's scope, keeping it simple was the better trade-off.

In production with high data volume, Materialized Views or pre-aggregated summary tables would make sense.

## Data Quality Checks Included

Implemented validations for:

- Null primary keys
- Duplicates
- Referential integrity between staging and facts
- Domain-specific fields (like state codes, status values)

## Limitations

This delivery does not include CI/CD deployment scripts or automated scheduling/orchestration.  
However, the architecture was designed with modularity to easily add these features later.

## Contact

Roberto Costa Junior
