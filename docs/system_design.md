

## data ingestion strategy

Files arrive daily in the inbox/ folder.  
I use Snowflake external stages with file formats to bulk load CSVs into the raw layer.

After successful loads, files are moved to processed/ folder to avoid reprocessing.

Errors during copy are logged in a error_log table and files remain for manual review.

## data architecture

The pipeline uses a 3-layer architecture:

- Raw: Exact replica from source files.
- Staging: Data cleaning, deduplication, type validation.
- Marts: Dimensional model for analytics and Tableau.

I choose this over ELT-in-one-step or single-layer models because it makes maintenance and troubleshooting easier.

## handling late_arriving data

The staging layer allows late data.  
Dimension (Merchants) is handled with SCD Type 2, and facts allow upserts.

## data quality validation

I included checks for:

- Null primary keys
- Duplicate IDs
- Referential integrity
- Domain validation (status codes, state codes)

Failures go to a data_quality_issues table.

## key assumptions

- Files might arrive without headers
- Some relationships can be missing at load time
- File order is not guaranteed
- Reprocessing of failed loads is manual for now

## open questions

- Should failed records stop the pipeline or just log errors?
- Expected retention for error logs and raw files?
- SLA for data availability after file arrival?
