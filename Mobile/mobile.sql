create database mobile_project;
use mobile_project;
select*from mobile;
-- mobile feature and price list
select phone_name,price from mobile;
-- most expensive phone
select*from mobile
order by price desc
limit 5;
-- cheapest phone
select*from mobile 
order by price asc
limit 5;
-- best samsung phone
select*from mobile where brands = "samsung"
order by price desc
limit 5;
-- best android top 5
select*from mobile where operating_system_type= "android"
order by price desc
limit 5;
-- best android cheapest 5
select*from mobile where operating_system_type="android"
order by price asc
limit 5;
-- best ios cheapest 5
select*from mobile where operating_system_type="ios"
order by price asc
limit 5;
-- best ios top 5
select*from mobile where operating_system_type="ios"
order by price desc
limit 5;
-- 5g availability
select*from mobile where 5g_availability= "yes"
order by price desc
limit 5;
-- total price brand wise
select brands,sum(price) from mobile group by brands;