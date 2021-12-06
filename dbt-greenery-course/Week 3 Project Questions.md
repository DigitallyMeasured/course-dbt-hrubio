(1) Create new models to answer the first two questions (answer questions in README file)

What is our overall conversion rate?
    
    The overalll conversion rate is 36.1%
    
    SELECT
    ROUND((num_checkouts::DECIMAL / num_sessions) *100, 2) AS conversion_rate
    FROM (
    SELECT
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) as num_checkouts,
    COUNT(DISTINCT session_id) AS num_sessions
    FROM {{ref('dim_events')}}
    
    What is our conversion rate by product?
    
    product_name	conv_rate
    Alocasia Polly	0.61
    Aloe Vera	0.48
    Angel Wings Begonia	0.58
    Arrow Head	0.51
    Bamboo	0.5
    Bird of Paradise 	0.64
    Birds Nest Fern	0.57
    Boston Fern	0.55
    Cactus	0.52
    Calathea Makoyana	0.61
    Devil's Ivy	0.37
    Dragon Tree	0.56
    Ficus	0.52
    Fiddle Leaf Fig	0.62
    Jade Plant	0.48
    Majesty Palm	0.59
    Money Tree	0.48
    Monstera	0.58
    Orchid	0.58
    Peace Lily	0.55
    Philodendron	0.63
    Pilea Peperomioides	0.47
    Pink Anthurium	0.58
    Ponytail Palm	0.48
    Pothos	0.5
    Rubber Plant	0.48
    Snake Plant	0.57
    Spider Plant	0.55
    String of pearls	0.53
    ZZ Plant	0.59
    
    SELECT 
    product_name,
    ROUND((SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ElSE 0 END) * 1.0 ) / COUNT(DISTINCT session_id), 2) as conv_rate
    FROM {{ ref('int_user_events') }}
    WHERE session_id IN (
        SELECT DISTINCT 
            session_id 
        FROM {{ ref('int_user_events') }}
        WHERE event_type = 'checkout'
        )
    AND page_name = 'Product Page'
    {{ dbt_utils.group_by(n=1) }}
    
    
(2) Create a macro to simplify part of a model(s).

    - grant_role_permissions
    - positive_values
    - truncate_stg_tables
    
(3) Add a post hook to your project to apply grants to the role “reporting”.

      - "{{ apply_grants_select_usage(role='reporting') }}"
      
(4) After learning about dbt packages, we want to try one out and apply some macros or tests.

    - package: dbt-labs/dbt_utils
      version: 0.7.4
    - package: calogica/dbt_expectations
      version: [">=0.4.0", "<0.5.0"]
    - package: dbt-labs/codegen
      version: 0.4.0
