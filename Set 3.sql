use p_hr;

-- 1. Fetch the names of countries having less than 10 employees.

select c.country_name
from employees e join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
join countries c on c.country_id = l.country_id
group by c.country_id
having count(employee_id) < 10;

-- 2. Fetch a report of total number of employees in each department (Department name, total number of employees).
-- (Try the same without using joins)

select department_id,count(employee_id) 
from employees
group by department_id;

-- 3. Fetch details of all employees earning more than their department’s average salary.

select *
from employees o
where o.salary > 
(select avg(salary) from employees i where o.department_id = i.department_id);

select * from (select *,(avg(salary) over (partition by department_id)) as av from employees) as T
where T.salary > T.av;

-- 4. Fetch a report of all employees names, ids, department name, salary and department average salary.

select first_name, employee_id, department_id, salary, 
(select avg(salary) from employees i where o.department_id = i.department_id ) as avg_salary
from employees o;

select first_name, employee_id, department_id, salary, 
avg(salary) over (partition by department_id)
from employees o;

-- 5. Fetch a report of all employees (emp id, name & salary) along with the difference of their salary
-- from their department’s average salary. Please group this data department-wise and sort the data in order of the salary difference.

select first_name, employee_id, department_id, salary, 
salary-(select avg(salary) from employees i where o.department_id = i.department_id ) as diff
from employees o
order by diff;

select first_name, employee_id, department_id, salary, 
salary-avg(salary) over ( partition by department_id) as diff
from employees o
order by diff;

-- 6. For each employee in department 80, fetch a report of their names, id, department name, salary,
-- and the difference between their department’s max salary and their salary.

select first_name, employee_id, department_id,(select department_name from departments d where d.department_id = o.department_id) as name, salary, 
salary-(select max(salary) from employees i where o.department_id = i.department_id ) as diff
from employees o
where department_id = 80
order by diff;

select first_name, employee_id, department_id,(select department_name from departments d where d.department_id = o.department_id) as name, salary, 
salary-max(salary) over (partition by department_id) as diff
from employees o
where department_id = 80
order by diff;

-- 7. Show the employee id, his/her joining date along with the number of employees that were hired on the same date

select first_name,hire_date, (select count(employee_id) from employees i where o.hire_date = i.hire_date) as number
from employees o
order by number desc;

select employee_id, hire_date, count(employee_id) over (partition by hire_date) as number
from employees o
order by number desc;

-- 8. Sort the data by department_id and fetch the even records (2nd, 4th , 6th …..)

select * 
from (select *, row_number() over (order by department_id) as row_no from employees) as T
where T.row_no mod 2 = 0;

-- 9. Find the 25th – 30th highest salary earned by an employee

select distinct(T.salary) 
from (select *,dense_rank() over (order by salary) as rank1 from employees) as T
where T.rank1 between 25 and 30;

select * 
from (select *,dense_rank() over (partition by department_id order by salary desc) as rank1 
from employees) as T
where T.rank1 between 25 and 30;

-- 10. 2 weeks from now bonus will be released for the employees. Bonus will be 3% of their salary.
-- Display employees name, their bonus and the bonus date.

