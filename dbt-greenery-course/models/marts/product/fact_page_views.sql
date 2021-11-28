{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    user_id,
    page_url,
    created_at,
    event_type
FROM {{ref('stg_events')}}
WHERE event_type = 'page_view'
