with src as (
  select
   seller_id, seller_name, grade, hire_date, seniority_days, region, updated_at,
    current_timestamp() as _load_ts
  from {{ source('tp_source','sellers') }}
)
select * from src
