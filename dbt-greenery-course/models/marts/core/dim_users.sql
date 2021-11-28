{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    address,
    zipcode,
    state,
    country,
    created_at,
    updated_at
FROM {{ref('stg_users')}} AS u
LEFT JOIN {{ref('stg_addresses')}} AS a
ON u.address_id = a.address_id