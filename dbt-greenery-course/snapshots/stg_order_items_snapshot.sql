{% snapshot order_items_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['quantity']
    )
  }}

  SELECT * 
  FROM {{ source('tutorial', 'order_items') }}

{% endsnapshot %}