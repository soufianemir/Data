{{ config(
    materialized='incremental',
    unique_key='product_bk',
    on_schema_change='sync_all_columns',
    tags=['dim','scd1']
) }}

with base as (
  select
    product_id   as product_bk,
    product_name,
    category_id,
    unit_price,
    discontinued,
    current_timestamp() as updated_at
  from {{ ref('stg_products') }}
),
dedup as (
  select *
  from base
  qualify row_number() over (partition by product_bk order by updated_at desc) = 1
)

select
  {{ sk_hash(["product_bk"]) }} as product_sk,
  *
from dedup

{% if is_incremental() %}
-- Fallback sandbox : pas de MERGE, on reste insert+dedupe.
{% endif %}
