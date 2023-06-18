create database car_project;
use car_project;
-- read data --
select* from car_dekho;
-- to count total car--
select count(*) from car_dekho;
-- total car avaliable in 2023--
select count(*) from car_dekho where year = 2023;
-- total car avaliable in 2020, 2021,2022--
select count(*) from car_dekho where year =2020;
select count(*) from car_dekho where year =2021;
select count(*) from car_dekho where year =2022;
-- group by--
select count(*) from car_dekho where year in (2020,2021,2022) group by year;
-- total of all car by years
select year , count(*) from car_dekho  group by year;
-- total diesel car in 2022
select count(*) from car_dekho where year = 2022 and fuel= "diesel";
-- total petrol car in 2020
select count(*) from car_dekho where year = 2020 and fuel= "petrol";
-- total fule car of all year
select year, count(*) from car_dekho where fuel ="petrol" group by year;
select year, count(*) from car_dekho where fuel ="diesel" group by year;
select year, count(*) from car_dekho where fuel ="cng" group by year;
-- ear having more than 100 car
select year ,count(*) from car_dekho group by year having count(*)>100;
select year , count(*)from car_dekho group by year having count(*)<50;
-- total no. of acr between 2015 and 2023
select count(*) from car_dekho where year between 2015 and 2023;
-- car detail between 2015 and 2023
select * from car_dekho where year between 2015 and 2023;