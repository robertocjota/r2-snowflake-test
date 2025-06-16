create schema if not exists dims;

create table dims.dim_merchants (
merchant_id varchar,
business_name varchar,
industry_code varchar,
state_code varchar,
annual_revenue number(12,2),
employees_count integer,
risk_score number(3,2),
onboarding_date date,
effective_date date,
end_date date,
is_current boolean
);

merge into dims.dim_merchants as target
using staging.stg_merchants as source
on target.merchant_id = source.merchant_id and target.is_current = true
when matched and (
target.business_name != source.business_name
or target.industry_code != source.industry_code
or target.state_code != source.state_code
or target.annual_revenue != source.annual_revenue
or target.employees_count != source.employees_count
or target.risk_score != source.risk_score
or target.onboarding_date != source.onboarding_date
) then
update set end_date = current_date, is_current = false
when not matched then
insert (merchant_id, business_name, industry_code, state_code, annual_revenue, employees_count, risk_score, onboarding_date, effective_date, end_date, is_current)
values (source.merchant_id, source.business_name, source.industry_code, source.state_code, source.annual_revenue, source.employees_count, source.risk_score, source.onboarding_date, current_date, null, true);
