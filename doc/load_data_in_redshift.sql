create schema dbt_redshift_shop_sample;
create schema dbt_redshift_payments;

create table dbt_redshift_shop_sample.raw_customers(
  id integer,
  first_name varchar(50),
  last_name varchar(50)
);

create table dbt_redshift_shop_sample.raw_orders(
  id integer,
  user_id integer,
  order_date date,
  status varchar(50),
  _etl_loaded_at timestamp default current_timestamp
);

create table dbt_redshift_payments.raw_payment(
  id integer,
  orderid integer,
  paymentmethod varchar(50),
  status varchar(50),
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

copy dbt_redshift_shop_sample.raw_customers( id, first_name, last_name)
from 's3://data-sch-lake-dev/dbt-redshift-module-test/jaffle_shop_customers.csv'
iam_role 'arn:aws:iam::441318093815:role/etl-dwh-redshift-role'
delimiter ','
ignoreheader 1
acceptinvchars

copy dbt_redshift_shop_sample.raw_orders(id, user_id, order_date, status)
from 's3://data-sch-lake-dev/dbt-redshift-module-test/jaffle_shop_orders.csv'
iam_role 'arn:aws:iam::441318093815:role/etl-dwh-redshift-role'
delimiter ','
ignoreheader 1
acceptinvchars;

copy dbt_redshift_payments.raw_payment(id, orderid, paymentmethod, status, amount, created)
from 's3://data-sch-lake-dev/dbt-redshift-module-test/stripe_payments.csv'
iam_role 'arn:aws:iam::441318093815:role/etl-dwh-redshift-role'
delimiter ','
ignoreheader 1
acceptinvchars;