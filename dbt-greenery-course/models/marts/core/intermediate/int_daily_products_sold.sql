{{
  config(
    materialized='table'
  )
}}

WITH products_sold AS (

SELECT 
    CAST(created_at AS date) as order_date,
    oi.product_id,
    SUM(quantity) AS quantity_sold
FROM {{ref ('stg_orders')}} AS o
LEFT JOIN {{ref ('stg_order_items')}} AS oi 
ON o.order_id = oi.order_id
GROUP BY 1,2
)



SELECT *
FROM products_sold
