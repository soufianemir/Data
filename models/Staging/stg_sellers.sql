with src as (
  select
    seller_id,
    seller_name,
    city,
    country,
    current_timestamp() as _load_ts
  from {{ source('tp_source','sellers') }}
)
select * from src
