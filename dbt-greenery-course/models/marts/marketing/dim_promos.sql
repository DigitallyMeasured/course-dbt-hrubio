{{
  config(
    materialized='table'
  )
}}

SELECT 
    promo_id,
    discount,
    status
FROM {{ref('stg_promos')}}
