{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_name,
    ROUND((SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ElSE 0 END) * 1.0 ) / COUNT(DISTINCT session_id), 2) as conv_rate
FROM {{ ref('int_user_events') }}
WHERE session_id IN (
    SELECT DISTINCT 
        session_id 
    FROM {{ ref('int_user_events') }}
    WHERE event_type = 'checkout'
    )
AND page_name = 'Product Page'
{{ dbt_utils.group_by(n=1) }}
