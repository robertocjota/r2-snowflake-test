create schema if not exists raw;

create table raw.merchants (
merchant_id varchar,
business_name varchar,
industry_code varchar,
state_code varchar,
annual_revenue number(12,2),
employees_count integer,
risk_score number(3,2),
onboarding_date date,
batch_date date,
load_timestamp timestamp_ntz
);

create table raw.applications (
application_id varchar,
merchant_id varchar,
application_date date,
requested_amount number(11,2),
loan_purpose varchar,
application_status varchar,
credit_score integer,
processing_time timestamp_ntz,
batch_date date,
load_timestamp timestamp_ntz
);

create table raw.disbursements (
disbursement_id varchar,
application_id varchar,
merchant_id varchar,
disbursed_amount number(11,2),
disbursement_date date,
interest_rate number(5,4),
term_months integer,
repayment_schedule varchar,
batch_date date,
load_timestamp timestamp_ntz
);

create table raw.payments (
payment_id varchar,
disbursement_id varchar,
merchant_id varchar,
payment_date date,
payment_amount number(11,2),
payment_method varchar,
is_scheduled boolean,
days_from_due integer,
processing_timestamp timestamp_ntz,
batch_date date,
load_timestamp timestamp_ntz
);

create table raw.error_log (
file_name varchar,
error_message varchar,
load_timestamp timestamp_ntz
);
