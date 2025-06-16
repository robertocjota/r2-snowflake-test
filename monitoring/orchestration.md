# orchestration and automation notes

Currently, the pipeline is designed for manual execution following script order from README.

For production, I would suggest:

1. Trigger file arrival detection (could use Snowflake event notifications or external orchestration tool like Airflow).
2. Sequentially run ingestion, staging, dimensions and facts loading.
3. Refresh reporting marts.
4. Run data quality tests and log results.
5. Notify success or failures via Slack, Email or Monitoring Dashboard.

At this time, I choose to avoid Streams and Tasks to keep the solution simple for the assessment timeline.
