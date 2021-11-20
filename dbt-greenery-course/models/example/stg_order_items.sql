{{
  config(
    materialized='view'
  )
}}

SELECT
    id,
    order_id,
    product_id,
    quantity
FROM {{ source('tutorial', 'order_items') }}