CREATE TABLE departments (
    department_id BIGINT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(50)
);


CREATE TABLE employees (
    employee_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    department_id BIGINT,
    manager_id BIGINT,

    CONSTRAINT FK_emp_dept
        FOREIGN KEY (department_id) REFERENCES departments(department_id),

    CONSTRAINT FK_emp_manager
        FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);


CREATE TABLE projects (
    project_id BIGINT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2),
    start_date DATE,
    end_date DATE
);


CREATE TABLE employee_projects (
    employee_id BIGINT,
    project_id BIGINT,
    assigned_date DATE,

    PRIMARY KEY (employee_id, project_id),

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);



INSERT INTO departments VALUES
(5000000001, 'IT', 'Bengaluru'),
(5000000002, 'HR', 'Hyderabad'),
(5000000003, 'Finance', 'Mumbai'),
(5000000004, 'Sales', 'Delhi'),
(5000000005, 'Operations', 'Chennai');


INSERT INTO employees VALUES
(6000000001, 'Amit', 'Sharma', 'amit@company.com', 90000, '2019-03-15', 5000000001, NULL),
(6000000002, 'Neha', 'Reddy', 'neha@company.com', 75000, '2020-07-22', 5000000001, 6000000001),
(6000000003, 'Rahul', 'Mehta', 'rahul@company.com', 65000, '2021-01-10', 5000000002, NULL),
(6000000004, 'Pooja', 'Iyer', 'pooja@company.com', 72000, '2018-11-05', 5000000003, NULL),
(6000000005, 'Suresh', 'Gupta', 'suresh@company.com', 60000, '2022-06-18', 5000000004, 6000000004),
(6000000006, 'Anjali', 'Nair', 'anjali@company.com', 82000, '2023-02-09', 5000000001, 6000000001),
(6000000007, 'Rohit', 'Singh', 'rohit@company.com', 58000, '2020-09-27', 5000000004, 6000000005),
(6000000008, 'Kiran', 'Das', 'kiran@company.com', 70000, '2021-12-14', NULL, NULL),
(6000000009, 'Meena', 'Joshi', 'meena@company.com', 67000, '2019-05-08', 5000000002, 6000000003),
(6000000010, 'Vikram', 'Patel', 'vikram@company.com', 88000, '2024-01-20', 5000000005, NULL);


INSERT INTO projects VALUES
(7000000001, 'ERP System', 5000000, '2021-01-01', '2021-12-31'),
(7000000002, 'HR Automation', 2000000, '2022-03-01', '2022-10-31'),
(7000000003, 'Sales Dashboard', 3000000, '2023-01-15', '2023-09-30'),
(7000000004, 'Cloud Migration', 8000000, '2020-06-01', '2021-06-30'),
(7000000005, 'Mobile App', 4000000, '2024-02-01', NULL);


INSERT INTO employee_projects VALUES
(6000000001, 7000000001, '2021-01-05'),
(6000000002, 7000000001, '2021-02-01'),
(6000000003, 7000000002, '2022-03-10'),
(6000000004, 7000000003, '2023-01-20'),
(6000000005, 7000000003, '2023-02-15'),
(6000000006, 7000000004, '2020-06-10'),
(6000000007, 7000000004, '2020-07-01'),
(6000000008, 7000000005, '2024-02-05'),
(6000000009, 7000000002, '2022-04-01'),
(6000000010, 7000000005, '2024-02-10');

select * from employees;
select * from departments;
select * from employee_projects;
select * from projects;

INSERT INTO employees VALUES
(6000000011, 'Test', 'User', 'test@company.com', 50000, '2023-01-01', 9999, NULL);
--testing error

INSERT INTO employees VALUES
(6000000011, 'Test', 'User', 'test@company.com', 50000, '2023-01-01', 5000000001, NULL);
--inserting the right value



-------------INNER JOIN Tasks-------------------------------------------

----Orders with products (3-table join)
select e.employee_id, e.first_name,e.last_name, d.department_id, d.department_name from employees e inner join departments d on e.department_id = d.department_id;

----Filter joined rows using LIKE pattern : find people belong to dept IT and Finance and salary above 50000/-
select * from departments d inner join employees e on e.department_id = d.department_id where d.department_name like '%I_%' and e.salary >= 50000 and d.department_name != 'Operations';


-------------LEFT JOIN Tasks---------------------------------------------

----------All departments with employees
select * from departments d left join employees e on e.department_id = d.department_id;

delete employees where employee_id = 6000000010;

-----------Departments without employees
select * from departments d left join employees e on e.department_id = d.department_id where e.employee_id is null;





------------RIGHT JOIN Tasks---------------------------------------


-----------All departments even if empty
select * from employees e right join departments d on e.department_id = d.department_id;

-----------RIGHT JOIN with WHERE condition
select * from employees e right join departments d on e.department_id = d.department_id where e.employee_id is not null and department_name = 'IT';


-----------RIGHT JOIN with COUNT per parent
select d.department_id,count(*) as empolyees_per__dept from employees e right join departments d 
on d.department_id = e.department_id group by d.department_id;


----------FULL OUTER JOIN Tasks-------------------------------------

------------Employees + departments full list
select * from employees e full outer join departments d on d.department_id = e.department_id;


-----------Write FULL JOIN using LEFT + RIGHT + UNION
select * from employees e left outer join departments d on d.department_id = e.department_id
union
select * from employees e right outer join departments d on d.department_id = e.department_id;


-----------SELF JOIN Tasks--------------------------------------

---------Employee with manager name
select e1.employee_id as manager_id, e2.employee_id as employee_id, 
concat(e2.first_name,' ',e2.last_name) as emp_name,
concat(e1.first_name,' ',e1.last_name) as manager_name 
from employees e1 join employees e2 
on e1.employee_id = e2.manager_id;

----Employees under same manager
select employee_id as employee_id, 
concat(first_name,' ',last_name) as emp_name, manager_id
from employees where manager_id in (select manager_id from employees group by manager_id having count(*)>1);
;


----Employees under same manager
select e1.employee_id as manager_id, e2.employee_id as employee_id, 
concat(e2.first_name,' ',e2.last_name) as emp_name,
concat(e1.first_name,' ',e1.last_name) as manager_name 
from employees e1 join employees e2 
on e1.employee_id = e2.manager_id where e2.manager_id in (select manager_id from employees group by manager_id having count(*)>1);


----List only managers
select distinct e1.employee_id, concat(e1.first_name,' ',e1.last_name) as manager_name  from employees e1 right join employees e2 
on e1.employee_id = e2.manager_id where e1.employee_id is not null;


-----Employee–mentor mapping
select e1.employee_id as manager_id, e2.employee_id as employee_id, 
concat(e2.first_name,' ',e2.last_name) as emp_name,
concat(e1.first_name,' ',e1.last_name) as mentor_name
from employees e1 join employees e2 
on e1.employee_id = e2.manager_id;



-----------Show reporting hierarchy pairs
WITH EmployeeHierarchy AS (
 
    SELECT employee_id, first_name, last_name, manager_id, 1 AS HierarchyLevel
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
  
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, eh.HierarchyLevel + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)

SELECT 
    employee_id,
    concat(first_name, ' ', last_name) AS EmployeeName,
    HierarchyLevel
FROM EmployeeHierarchy
ORDER BY HierarchyLevel, manager_id;


--------------CROSS JOIN Tasks----------------------------------------
select * from employees e cross join departments;


-----------------Multi-Table JOIN Tasks-------------------------------

----------------employees + departments + projects
select e.employee_id, concat(e.first_name,' ',e.last_name) as emp_name, p.project_id,p.project_name from employees e join employee_projects ep on e.employee_id = ep.employee_id join projects p on ep.project_id = p.project_id; 



----------------Build full order report (4 tables)
select e.employee_id, concat(e.first_name,' ',e.last_name) as emp_name, p.project_id,p.project_name, d.department_name from employees e join employee_projects ep on e.employee_id = ep.employee_id join projects p on ep.project_id = p.project_id join departments d on e.department_id = d.department_id; 



------------------------JOIN + GROUP BY Tasks--------------------------------------

----------------Employee count per department
select count(e.employee_id), d.department_name,d.department_id from employees e right join departments d on e.department_id = d.department_id group by d.department_id,d.department_name;

--------------------Department salary total
select sum(e.salary), d.department_name,d.department_id from employees e right join departments d on e.department_id = d.department_id group by d.department_id,d.department_name;


---------------JOIN + HAVING Tasks---------------------------------------------------

-------------------Departments with more than 5 employees
select count(e.employee_id), d.department_name,d.department_id from employees e right join departments d on e.department_id = d.department_id group by d.department_id,d.department_name having count(e.employee_id)>1;

-----------------------JOIN + WHERE Tasks---------------------------------

select  * from employees e right join departments d on e.department_id = d.department_id where d.department_name = 'IT';

-----------------------JOIN + LIKE Tasks-------------------------------------------------------------------
-------------------Employees name LIKE pattern + department

select  * from employees e right join departments d on e.department_id = d.department_id where d.department_name like 'IT' and e.first_name like 'A%';

--------------------------JOIN + Subquery Tasks (IN / NOT IN / EXISTS / NOT EXISTS)----------------------------


select * from employees where employee_id not in (select employee_id from employee_projects);

use company_db;

select e.employee_id, concat(e.first_name, ' ' ,e.last_name) as emp_name ,
e.salary, agg.avg_dept_salary, agg.department_name 
from employees e join 
(select avg(e.salary) avg_dept_salary ,d.department_id,d.department_name 
	from employees e right join departments d 
	on e.department_id = d.department_id 
	group by d.department_id, d.department_name) 
agg 
on agg.department_id = e.department_id 
where e.salary > agg.avg_dept_salary;

select * from employees where department_id in (select department_id from departments);

select * from employee_projects;