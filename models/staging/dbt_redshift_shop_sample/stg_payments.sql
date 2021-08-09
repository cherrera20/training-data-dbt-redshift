with payments as (

    select
           id as payment_id,
           orderid as order_id,
           paymentmethod as payment_method,
           status,
           created as created_at,
           -- amount is stored in cents, convert it to dollars
           {{ cents_to_dollar('amount') }} as amount --amount / 100 as amount

    from {{ source('dbt_redshift_payments', 'raw_payment') }}

)

select * from payments