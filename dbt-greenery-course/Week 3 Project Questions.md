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
