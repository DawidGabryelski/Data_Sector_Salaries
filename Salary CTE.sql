with q1
as
(
	select
		job_title
		,count(*)														as nr_of_employee
		,round(count(*)/ (select count(*) from salaries s) * 100,2) 	as ratio
	from salaries s 
	group by 1
	order by 2 desc
	limit 10
), q2
as
(
	select
		job_title
		,round(avg(salary),0)											as average_salary
	from salaries s 
	group by 1
), q3
as
(
	select 
		q1.job_title
		,q1.nr_of_employee
		,q1.ratio
		,q2.average_salary
	from q2
	join q1 on q2.job_title = q1.job_title
), q4
as
(
	select 
		company_size
		,experience_level
		,round(Avg(salary),0)											as average_salary
	from salaries s 
	where job_title  in (select job_title from q3) 
	group by 1,2
	order by 3
), q5 
as
(
	select 
		experience_level
		,round(Avg(salary),0)											as average_salary
	from salaries
	where job_title  in (select job_title from q3) 
	group by 1
	order by 2
), q6 
as
(
	select 
		company_size 
		,round(Avg(salary),0)											as average_salary
	from salaries
	where job_title  in (select job_title from q3) 
	group by 1
	order by 1 desc
), q7
as
(
	select 
		remote_ratio
		,experience_level														
		,count(*) 														as nr_of_employee
	from salaries
	where job_title  in (select job_title from q3) 
	group by 1,2
	order by 3 desc
)
	select 
		remote_ratio
		,company_size														
		,count(*) 														as nr_of_employee
	from salaries
	where job_title  in (select job_title from q3) 
	group by 1,2
	order by 3 desc;
