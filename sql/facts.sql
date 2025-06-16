create schema if not exists facts;

create table facts.fact_applications as
select *
from staging.stg_applications;

create table facts.fact_disbursements as
select *
from staging.stg_disbursements;

create table facts.fact_payments as
select *
from staging.stg_payments;
