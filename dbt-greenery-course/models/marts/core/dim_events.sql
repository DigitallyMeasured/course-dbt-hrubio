{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    user_id,
    page_url,
    product_id,
    page_name,
    created_at,
    event_type
FROM {{ref('stg_events')}}
