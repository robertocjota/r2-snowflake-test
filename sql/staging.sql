create schema if not exists staging;

create table staging.stg_merchants as
select *
from (
select *,
row_number() over (partition by merchant_id order by batch_date desc, load_timestamp desc) as row_num
from raw.merchants
)
where row_num = 1;

create table staging.stg_applications as
select distinct *
from raw.applications
where application_id is not null;

create table staging.stg_disbursements as
select distinct *
from raw.disbursements
where disbursement_id is not null;

create table staging.stg_payments as
select distinct *
from raw.payments
where payment_id is not null;
