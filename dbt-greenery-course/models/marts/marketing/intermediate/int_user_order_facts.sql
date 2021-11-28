{{
  config(
    materialized='table'
  )
}}

WITH user_order_history AS (

SELECT DISTINCT
user_id,
COUNT( order_id ) OVER (PARTITION BY user_id) As orders_per_user
FROM {{ ref('stg_orders') }}
ORDER BY user_id
)

SELECT
user_id,
orders_per_user,
CASE WHEN orders_per_user > 1 THEN 1 ELSE 0 END AS repeat_users
FROM user_order_history
GROUP BY 1,2