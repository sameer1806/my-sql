-- 1. Select all the employees who joined the organization on the 3rd of every month. (17 rows)
use hr;
select first_name from employees where day(hire_date)=03;


-- 2. Fetch the department name, manager name, and salary of the manager for all managers whose
-- experience is more than 25 years (in the company) – 3 rows

select department_name,first_name,salary
from employees e, departments d
where e.manager_id=d.manager_id
and year(current_date())-year(hire_date)>25;


-- 3. Fetch details of departments in which the maximum salary is more than 10000. (6 rows)
select j.max_salary from departments d,employees e,jobs j
where e.department_id=d.department_id
and e.job_id=j.job_id
and j.max_salary>10000;

select e.department_id,d.department_name,e.employee_id,e.first_name,e.salary
from employees e,departments d
where e.department_id=d.department_id
group by department_id,department_name
having max(salary)>10000;

-- 4. Salary is dispatched for all employees on the last day of the month. Fetch a report of employees’
-- name, phone and the date on which they received their first salary in the company
select first_name,phone_number, last_day(hire_date)  from  employees;

-- 5. Fetch the name of the city of the employees whose ID's are 130 and 150. (2 rows)

select l.city 
from employees e, locations l,departments d
where e.department_id=d.department_id
and d.location_id=l.location_id
and e.employee_id in (130,150);
-- 6. Fetch all the details of employees working in US / UK earning a salary above 7000 (42 rows)

select * 
from employees e, countries c,locations l, departments d
where e.department_id = d.department_id
and d.location_id=l.location_id
and l.country_id=c.country_id 
and c.country_id in ("US","UK")
and e.salary>7000;
-- 7. Fetch details of departments managed by John / Alexander (2 rows)

select * from departments d,employees e
where e.department_id=d.department_id
and e.first_name in ("john","alexander")
group by first_name;

-- 8. Fetch records of all employees whose salary is more than the overall average salary (51 rows)

select * from employees group by employee_id having salary > (select avg(salary) from employees);
select * from employees group by employee_id having salary > avg(salary);
-- 9. Fetch all records of employees whose salary is greater than the average salary of a sales rep (job_id
-- = SA_Rep) (30 rows)
select * from employees group by employee_id 
having salary > (select avg(salary) from employees where job_id="SA_REP");
-- 10. Fetch a report all managers who manage more than 3 employees (15 rows)

select * from employees group by manager_id having count(employee_id)>3;

-- 11. Fetch the 3rd and 4th highest salary earned by an employee

select salary from employees group by employee_id order by max(salary) desc limit 2 offset 2;


select temp1.salary from
(select *, dense_rank()over(order by salary desc) as rnk
from employees) 
as temp1 where rnk in (3,4);



-- 12. Fetch the names of countries having less than 10 employees. (3 rows)
select country_name 
from employees e, countries c,locations l, departments d
where e.department_id = d.department_id
and d.location_id=l.location_id
and l.country_id=c.country_id
group by country_name
having count(employee_id)<10; 

-- 13. Display the name, department_id and salary of employees earning the 2nd highest salary in each
-- department. (9 rows)
-- select first_name,department_id,salary from employees group by department_id order by max(salary) desc limit 1 offset 1;

-- select department_id,(salary) from employees;

-- select department_id,avg(salary) over(partition by department_id) from employees;

select t1.department_id,t1.salary,t1.rnk from
(select *, dense_rank() over(partition by department_id order by salary desc) as rnk from employees) 
as t1 where t1.rnk=2 