select count(*)
from first_project..[Orders$]

select *
from first_project..[Orders$]
order by 1

select [Order ID] ,count(*)
from first_project..[Orders$]
group by [Order ID]
having count(*)>1

select *
from first_project..[Orders$]
where [Order ID]= 'AG-2013-8490'

Select [Row ID],[Order ID], count(*)
from first_project..[Orders$]
group by [Row ID],[Order ID]
having count(*)>1

select * from first_project..[Orders$]
where [Ship Date]<[Order Date]

select distinct [Ship Mode] from first_project..[Orders$]

select MIN(a.NumOfDays),max(a.NumOfDays)
from(
select DATEDIFF( DAY,[Order Date],[Ship Date]) as NumOfDays,*
from first_project..[Orders$]
where [Ship Mode]='Second Class') a

select [Customer ID],[Order ID],count(*)
from first_project..[Orders$]
group by [Customer ID],[Order ID]
order by [Customer ID]

select * from first_project..[Orders$]
where [Order ID]='CA-2011-138100'



