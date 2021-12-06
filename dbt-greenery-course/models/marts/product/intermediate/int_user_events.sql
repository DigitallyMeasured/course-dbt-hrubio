{{
  config(
    materialized='table'
  )
}}

SELECT
    a.user_id, 
    a.event_id, 
    a.page_name, 
    CASE WHEN a.product_id IS NOT NULL THEN b.name END product_name,
    a.created_at,
    a.event_type,
    a.session_id,
    a.product_id
  FROM {{ ref('dim_events')}} AS a
  LEFT JOIN {{ ref('dim_products')}} b
  ON a.product_id = b.product_id
