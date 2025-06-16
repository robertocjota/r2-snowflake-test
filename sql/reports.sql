create or replace view marts.daily_processing_summary as
select
batch_date,
current_date as processing_date,
count(*) as records_processed
from raw.applications
where batch_date >= dateadd(day, -30, current_date)
group by batch_date
order by batch_date desc;

create or replace view marts.lending_performance_dashboard as
select
application_date as event_date,
count(distinct application_id) as applications_received,
sum(case when application_status = 'approved' then 1 else 0 end) as applications_approved,
sum(case when application_status = 'rejected' then 1 else 0 end) as applications_rejected
from facts.fact_applications
where application_date >= dateadd(day, -40, current_date)
group by event_date
order by event_date desc;

create or replace view marts.risk_monitoring_report as
select
merchant_id,
avg(risk_score) as avg_risk_score,
sum(case when days_from_due > 30 then 1 else 0 end) as late_payments_over_30_days
from facts.fact_payments p
join dims.dim_merchants m on p.merchant_id = m.merchant_id
group by merchant_id;
