{{ config(materialized='view') }}

select
  customer_id,
  first_name,
  last_name,
  email,
  phone,
  city,
  country,
  created_at,
  updated_at
from {{ source('tp_source', 'customers') }}

