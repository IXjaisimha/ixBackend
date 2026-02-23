use company_db;

select * from departments;
select * from employee_projects;
select * from employees;
select * from projects;






select e.employee_id,CONCAT(e.first_name,' ',e.last_name) as Full_Name, email,salary,d.department_name, agg.*,
	
	case when e.employee_id not in 
						(select distinct e2.employee_id as manager_id 
						from employees e1 
						join employees e2 
						on e1.manager_id = e2.employee_id) 
	then 'Empolyee' else 'Manager' end as Designation,
	
	case when e.salary >= department_avg then 'High' else 'Basic' end as Payout

from employees e 
join 
employee_projects ep 
on e.employee_id = ep.employee_id 
join 
	(select project_id,project_name, DATEDIFF(month,start_date,end_date) as No_Of_Months 
	from projects 
	where end_date is not null) 
agg 
on agg.project_id = ep.project_id 
left join 
departments d
on d.department_id = e.department_id
join
				(select d.department_name,d.department_id,Avg(salary) as department_avg 
					from employees e 
					join departments d 
					on d.department_id = e.department_id 
					group by d.department_id,d.department_name
					having Avg(salary)>=50000
				  ) 
avgg on avgg.department_id = d.department_id
where exists (select * from departments where location like '%Bengal%' or location like '%Hyd%')				  
;