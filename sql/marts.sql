create schema if not exists marts;

create or replace view marts.daily_lending_summary as
select
date(application_date) as event_date,
count(distinct application_id) as total_applications,
sum(case when application_status = 'approved' then 1 else 0 end) as total_approved,
sum(case when application_status = 'rejected' then 1 else 0 end) as total_rejected,
sum(requested_amount) as total_requested
from facts.fact_applications
where application_date >= dateadd(day, -40, current_date)
group by event_date
order by event_date desc;

create or replace view marts.merchant_portfolio_metrics as
select
merchant_id,
count(distinct disbursement_id) as total_loans,
sum(disbursed_amount) as total_disbursed,
avg(term_months) as avg_term_months,
avg(interest_rate) as avg_interest_rate
from facts.fact_disbursements
group by merchant_id;

create or replace view marts.payment_performance as
select
merchant_id,
count(distinct payment_id) as total_payments,
sum(payment_amount) as total_collected,
avg(days_from_due) as avg_days_from_due
from facts.fact_payments
group by merchant_id;
