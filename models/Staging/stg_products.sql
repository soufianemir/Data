with src as (
  select
    product_id,
    product_name,
    category_id,
    unit_price,
    discontinued,
    current_timestamp() as _load_ts
  from {{ source('tp_source','products') }}
)
select * from src
