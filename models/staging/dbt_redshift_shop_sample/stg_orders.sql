with orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from {{ source('dbt_redshift_shop_sample', 'raw_orders') }}
)

select * from orders

{{ limit_data_in_dev('order_date', 1000) }}