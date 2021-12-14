 {{
  config(
    materialized='table'
  )
}}

WITH checkout_sessions AS (

SELECT
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS num_checkout_sessions,
    COUNT(DISTINCT session_id) AS num_sessions

FROM {{ref('dim_events')}}
)

SELECT
    ROUND((CAST(num_checkout_sessions AS decimal) / num_sessions) * 100, 2) AS conversion_rate
FROM 
    checkout_sessions
