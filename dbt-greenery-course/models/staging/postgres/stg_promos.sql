{{
  config(
    materialized='view'
  )
}}

SELECT
    id,
    promo_id,
    discout AS discount,
    status
FROM {{ source('tutorial', 'promos') }}