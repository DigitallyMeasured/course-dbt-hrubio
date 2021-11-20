{{
  config(
    materialized='view'
  )
}}

SELECT
    id,
    address_id,
    address,
    zipcode,
    state,
    country
FROM {{ source('tutorial', 'addresses') }}