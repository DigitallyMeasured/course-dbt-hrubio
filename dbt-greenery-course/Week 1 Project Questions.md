**WEEK 1**

- How many users do we have?\
  130 users

- On average, how many orders do we receive per hour?\
  17.15 orders per hour

    SELECT AVG(orders_per_hour) avg
    FROM (
    SELECT
    created_at,
    split_part(CAST(created_at AS VARCHAR), ' ', 1) created_date,
    split_part(CAST(created_at AS VARCHAR), ' ', 2) created_time_full,
    split_part(split_part(CAST(created_at AS VARCHAR), ' ', 2), ':', 1) created_hour,
    order_id,
    COUNT(order_id) OVER (PARTITION BY split_part(split_part(CAST(created_at AS VARCHAR), ' ', 2), ':', 1)) orders_per_hour
    FROM "stg_orders" 
    order by 1
    ) a

- On average, how long does an order take from being placed to being delivered?\
  3 days, 22 hours hours and 13 minutes per order
  
    SELECT AVG(diff) as avg
    FROM (
    SELECT
    order_id,
    created_at,
    delivered_at,
    AGE(delivered_at, created_at) diff
    FROM "stg_orders" 
    WHERE status = 'delivered'
    ) a

- How many users have only made one purchase? Two purchases? Three+ purchases?\
  One purchase = 25 users\
  Two purchases = 22 users\
  Three+ purchases = 81 users
  
    SELECT 
    purchase_buckets,
    COUNT(DISTINCT user_id) number_of_users
    FROM (
    SELECT
    user_id,
    count(order_id) OVER (PARTITION BY user_id ORDER BY user_id) number_of_orders,
    CASE 
    WHEN count(order_id) OVER (PARTITION BY user_id ORDER BY user_id) = '1' THEN 'One purchase'
    WHEN count(order_id) OVER (PARTITION BY user_id ORDER BY user_id) = '2' THEN 'Two purchases'
    WHEN count(order_id) OVER (PARTITION BY user_id ORDER BY user_id) >= '3' THEN 'Three+ purchases'
    END AS purchase_buckets
    FROM "stg_orders" 
    order by 1
    ) a
    GROUP BY 1
    ORDER BY 1

- On average, how many unique sessions do we have per hour?\
  136.38 sessions per hour

    SELECT AVG(sessions_per_hour) avg
    FROM (
    SELECT
    created_at,
    split_part(CAST(created_at AS VARCHAR), ' ', 1) created_date,
    split_part(CAST(created_at AS VARCHAR), ' ', 2) created_time_full,
    split_part(split_part(CAST(created_at AS VARCHAR), ' ', 2), ':', 1) created_hour,
    session_id,
    COUNT(session_id) OVER (PARTITION BY split_part(split_part(CAST(created_at AS VARCHAR), ' ', 2), ':', 1)) sessions_per_hour
    FROM "stg_events" 
    order by 3
    ) a
