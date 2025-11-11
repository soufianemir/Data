with src as (
  select
product_id, product_name, category, unit_price, active, updated_at,
    current_timestamp() as _load_ts
  from {{ source('tp_source','products') }}
)
select * from src
