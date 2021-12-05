(1) Create new models to answer the first two questions (answer questions in README file)

What is our overall conversion rate?
    
    The overalll conversion rate is 36.1%
    
    SELECT
    ROUND((num_checkouts::DECIMAL / num_sessions) *100, 2) AS conversion_rate
    FROM (
    SELECT
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) as num_checkouts,
    COUNT(DISTINCT session_id) AS num_sessions
    
    What is our conversion rate by product?
