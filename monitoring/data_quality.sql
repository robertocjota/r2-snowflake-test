create schema if not exists monitoring;

create table monitoring.data_quality_issues (
table_name varchar,
issue_type varchar,
record_count integer,
issue_timestamp timestamp_ntz
);

insert into monitoring.data_quality_issues
select 'staging.stg_applications', 'null_primary_key', count(*), current_timestamp
from staging.stg_applications
where application_id is null;

insert into monitoring.data_quality_issues
select 'staging.stg_disbursements', 'null_primary_key', count(*), current_timestamp
from staging.stg_disbursements
where disbursement_id is null;

insert into monitoring.data_quality_issues
select 'staging.stg_payments', 'null_primary_key', count(*), current_timestamp
from staging.stg_payments
where payment_id is null;
