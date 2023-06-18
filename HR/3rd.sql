create database hr_project;

use hr_project;

select * from hr;
-- to change colunm name
alter table hr
change column ï»¿id emp_id varchar(20) not null;

select * from hr;
-- to see colunm data type--
desc hr;

-- to change birthdate and hiredate and termdate from text to date
select birthdate from hr;

set sql_safe_updates = 0;

update hr
set birthdate = case
  when birthdate like'%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
  when birthdate like'%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
  else null
end;
alter table hr
modify column birthdate date;

update hr
set hire_date = case
  when hire_date like'%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
  when hire_date like'%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
  else null
end;
alter table hr
modify column hiredate date;

select birthdate ,hire_date from hr;

update hr
set termdate = date(str_to_date(termdate,'%Y-%m-%d,%H:%i:%s UTC'))
where termdate is not null and  termdate!= ' ';

alter table hr
modify column termdate date; 
select termdate from hr; 

-- add age  column
alter table hr add column age int; 
update hr
set age = timestampdiff(Year,birthdate,curdate());
select
min(age) as youngest,max(age) as oldest
from hr;
select * from hr;   
-- to see age below 0
select count(*) from hr where age <18;

--  employee gender wise in the company
select gender ,count(*) as count
from hr 
where age >= 18 and termdate = '0000-00-00'
group by gender;

-- employee religion wise
select race, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by race
order by count(*) desc;

-- age distribution of employee
select 
	min(age) as youngest,
    max(age) as oldest
from hr
where age >= 18;

select
	case
		when age>=18 and age <=24 then '18-24'
        when age>=25 and age <=34 then '25-34'
        when age>=35 and age <=44 then '35-44'
        when age>=45 and age <=54 then '45-54'
        when age>=55 and age <=64 then '55-64'
		else '65+'
	end as age_group,
    count(*) as count
from hr
where age >= 18
group by age_group
order by age_group;

select
	case
		when age>=18 and age <=24 then '18-24'
        when age>=25 and age <=34 then '25-34'
        when age>=35 and age <=44 then '35-44'
        when age>=45 and age <=54 then '45-54'
        when age>=55 and age <=64 then '55-64'
		else '65+'
	end as age_group, gender,
    count(*) as count
from hr
where age >= 18
group by age_group, gender
order by age_group, gender;

-- employees work at headquarters vs work from home
select location, COUNT(*) as count
from hr
where age >=  18
group by location;

-- avg length of employment for employees who is terminated
select round(avg(datediff(termdate, hire_date))/365,0) as avg_length_employment
from hr
where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;

-- gender departments wise and job titles wise
select department, gender, COUNT(*) as count
from hr
where age >= 18
group by department, gender
order by department;

-- job titles across the company
select jobtitle, COUNT(*) as count
from hr
where age >= 18
group by jobtitle
order by jobtitle desc;

-- department highest turnover rate
select department,
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
from (select department,
	COUNT(*) as total_count,
    SUM(case when termdate <= curdate() and termdate = '0000-00-00' then 1 else 0 end) as terminated_count
    from hr
    where age >= 18
    group by department) as subquery
order by termination_rate;

-- employees across locations by city and state
select location_state, COUNT(*) as count
from hr
where age >= 18
group by location_state
order by count desc;

-- company's no. of employee change between hire and term dates?
select
	year,
    hires,
    terminations,
    hires - terminations as net_change,
    ROUND((hires - terminations)/hires*100,2) as net_change_percent
from(
	select
    year(hire_date) as year,
    COUNT(*) as hires,
    SUM(case when termdate <= curdate() and termdate <> '0000-00-00' then 1 else 0 end) as terminations
    from hr
    where age >= 18
    group by year(hire_date)
    ) as subquery
order by year asc;
-- department wise tenure distribution
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr
where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18
group by department;