{{
  config(
    materialized='table'
  )
}}

SELECT 
    product_id,
    name,
    price,
    quantity
FROM {{ref('stg_products')}}