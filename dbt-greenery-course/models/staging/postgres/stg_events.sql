{{
  config(
    materialized='view'
  )
}}

SELECT
    id,
    event_id,
    session_id,
    user_id,
    page_url,
    REPLACE(page_url,'https://greenary.com/product/','') AS product_id,
    CASE 
      WHEN page_url LIKE '%browse%' THEN 'Search Page' 
      WHEN page_url = 'https://greenary.com' THEN 'Home Page' 
      WHEN page_url = 'https://greenary.com/help' THEN 'Help Page' 
      WHEN page_url = 'https://greenary.com/shipping' THEN 'Shipping Page'
      WHEN page_url = 'https://greenary.com/signup' THEN 'Registration Page'
      WHEN page_url = 'https://greenary.com/checkout' THEN 'Checkout Page'
      WHEN page_url LIKE 'https://greenary.com/product%' THEN 'Product Page' 
      ELSE page_url 
    END page_name,
    created_at,
    event_type
FROM {{ source('tutorial', 'events') }}
