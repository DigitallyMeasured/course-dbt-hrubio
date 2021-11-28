{{
  config(
    materialized='table'
  )
}}

WITH product_stock AS (

SELECT 
    order_date, 
    p.product_id, 
    name,
    price, 
    quantity, 
    quantity_sold, 
    quantity - quantity_sold AS quantity_available,
    CASE WHEN quantity - quantity_sold > 0 THEN 'On Stock' ELSE 'Not Available' END AS stock_status,
    row_number() OVER (PARTITION BY p.product_id ORDER BY order_date DESC) as rn
FROM {{ref('stg_products')}} AS p
LEFT JOIN {{ref('int_daily_products_sold')}} AS ps
ON p.product_id = ps.product_id
)


SELECT 
    order_date, 
    product_id, 
    name,
    price, 
    quantity, 
    quantity_sold 
    quantity_available, 
    stock_status, 
    CASE WHEN rn = 1 THEN TRUE ELSE FALSE END AS is_last_status
FROM product_stock
