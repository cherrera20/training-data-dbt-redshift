--drop table my_first_dbt_model cascade;
--create schema if not exists jaffle_shop;
--create schema if not exists stripe;

select * from fotocasa.orders;
select * from fotocasa.customers;
select * from fotocasa.payment;

select
        user_id as customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(id) as number_of_orders

    from fotocasa.orders

    group by 1;




    select
        customers.id as customer_id,
        customers.first_name,
        customers.last_name,
        customers_orders.first_order_date,
        customers_orders.most_recent_order_date,
        coalesce(customers_orders.number_of_orders, 0) as number_of_orders

    from fotocasa.customers as customers

    left join (
        select
            user_id as id,
            min(order_date) as first_order_date,
            max(order_date) as most_recent_order_date,
            count(id) as number_of_orders
        from fotocasa.orders
        group by 1) as customers_orders

    USING (id)


