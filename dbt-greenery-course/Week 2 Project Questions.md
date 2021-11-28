**WEEK 2**

(Part 1) Models

What is our user repeat rate? 80%
     
    SELECT
       SUM(CASE WHEN order_count>1 THEN 1 ELSE 0 END) / COUNT(user_id)::FLOAT
    FROM (
    SELECT 
       user_id, 
       COUNT(DISTINCT order_id) as order_count 
    FROM stg_users AS u
    LEFT JOIN stg_orders AS o 
    ON u.user_id = o.user_id
    GROUP BY 1
    )

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

    - Weather. Cold regions with temperatures the freezing mark rely on seasonal shopping behaviour, whereas tropical ones show a more steady behavior.
    - Visit engagement. With event tracking enabled some key user actions, such as their journey to conversions (or obstacles in their joirney) would help predict           their chances to convert.
    - Local economy. Some regions are typically more depressed than others, specially if they're heavily dependant on key resources experiencing depressed prices.           This situation impacts income and; therefore, purchase power for non-critical items.
    - Education and/or professional user profiles. 
    

Within each marts folder, create at least 1-2 intermediate models and 1-2 dimension/fact models. Explain the marts models you added. Why did you organize the models in the way you did?

    The models were organized to be in a good position to answer the typical eCommerce questions stakeholders make. The transactional events at the order & user levels are connected to relevant attributes, thus enabling richer context.
        
Use the dbt docs to visualize your model DAGs to ensure the model layers make sense
    Shared here, as well as at the slack project channel when submitting.
![image](https://user-images.githubusercontent.com/23464397/143790815-7cb6d47d-3c70-46fb-a179-6017937bf615.png)


(Part 2) Tests

What assumptions are you making about each model? (i.e. why are you adding each test?)

    I'm assuming all dimension tables have unique primary keys with no nulls, while also assuming all orders have their corresponding creation dates.

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

    The dbt test retunred errors, some contracdictiong my assumptions related to nulls & order dates. In cases like these, it's not about adjusting my assumptions, but instead investigation the root cause, updating the standard operating procedures (SOP) to avoid creating incomplete records, and finally refreshing the raw tables to backfill the missing data and override the wrong data.
    
        
Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

    I'd do the following:
        - run all jobs on a schedule
        - configure error notifications to alert key stakeholders for immediate resolution

