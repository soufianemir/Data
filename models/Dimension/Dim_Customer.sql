{{
  config(
    materialized = 'table',
    full_refresh = true
  )
}}

-- dim_customers : génération de SK dans la même CTE que la lecture
with src as (

  select
    customer_id,
    -- SK déterministe (stable entre runs) : préfixe + hash (FARM_FINGERPRINT)
 --   concat('C_', cast(abs(FARM_FINGERPRINT(cast(customer_id )) as string)) as sk_customer,
    first_name,
    last_name,
    lower(trim(email)) as email,
    phone,
    city,
    country,
    created_at as source_created_at,
    updated_at as source_updated_at,
    current_timestamp() as dbt_loaded_at

  from {{ ref('stg_customer') }}
)
  select * from src




