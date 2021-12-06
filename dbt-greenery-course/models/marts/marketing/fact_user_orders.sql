{{
  config(
    materialized='table'
  )
}}

WITH lifetime_user_revenue AS (

SELECT 
    u.user_id, 
    u.created_at AS user_created_at, 
    MIN(o.created_at) AS first_order_date, 
    COUNT(DISTINCT order_id) AS number_of_orders, 
    SUM(order_total) AS lifetime_revenue
FROM {{ref('stg_users')}} AS u
LEFT JOIN {{ref('stg_orders')}} AS o
ON u.user_id = o.user_id
{{ dbt_utils.group_by(n=2) }}
)


SELECT 
    user_id, 
    user_created_at, 
    first_order_date, 
    first_order_date - user_created_at as date_first_order, 
    number_of_orders, 
    lifetime_revenue
FROM lifetime_user_revenue
