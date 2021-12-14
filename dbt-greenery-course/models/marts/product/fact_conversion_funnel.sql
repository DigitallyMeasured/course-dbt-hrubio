{{
  config(
    materialized='table'
  )
}}

WITH funnel_base AS (

    SELECT
        session_id,
        CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END AS with_page_view,
        CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END AS with_add_to_cart,
        CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END AS with_checkout
    FROM
        {{ref('dim_events')}}
    WHERE
        event_type IN ('page_view','add_to_cart','checkout')

),

funnel_aggregation AS ( 

    SELECT
        session_id,
        SUM(with_page_view) AS num_page_view,
        SUM(with_add_to_cart) AS num_add_to_cart,
        SUM(with_checkout) AS num_checkout
    FROM
        funnel_base
    GROUP BY  
        session_id
 ),

funnel_total as (
    
    SELECT
        COUNT(session_id) as num_sessions,
        SUM(CASE WHEN num_page_view > 0 THEN 1 ELSE 0 END) AS page_views,
        SUM(CASE WHEN num_add_to_cart > 0 THEN 1 ELSE 0 END) AS add_to_carts,
        SUM(CASE WHEN num_checkout > 0 THEN 1 ELSE 0 END) AS checkouts
    FROM
        funnel_aggregation
)
SELECT
    num_sessions AS total_sessions,
    ROUND( (num_sessions - page_views) / CAST(num_sessions AS decimal) * 100, 2) AS dropoff_pct_sessions_to_page_views,
    ROUND( (page_views - add_to_carts) / CAST(page_views AS decimal) * 100, 2) AS dropoff_pct_page_views_to_add_to_carts,
    ROUND( (add_to_carts - checkouts) / CAST(add_to_carts AS decimal) * 100, 2) AS dropoff_pct_add_to_carts_to_checkouts
FROM
    funnel_total
