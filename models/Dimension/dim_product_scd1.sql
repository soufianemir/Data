{{
  config(
    materialized = 'table',
    full_refresh = true
  )
}}

with src as (
  select
    product_id ,
--     concat('C_', cast(abs(FARM_FINGERPRINT(cast(product_id )) as string)) as sk_product,
    product_name,
    category_id,
    unit_price,
    discontinued,
    current_timestamp() as updated_at
  from {{ ref('stg_products') }}

)
  select * from src