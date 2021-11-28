{{
  config(
    materialized='table'
  )
}}

SELECT 
    p.promo_id,
    CAST(created_at AS DATE) AS order_created_at,
    COUNT(DISTINCT order_id) AS orders_with_promo
FROM {{ref('stg_promos')}} AS p
LEFT JOIN {{ref('stg_orders')}} AS o 
ON p.promo_id = o.promo_id
GROUP BY 1,2
