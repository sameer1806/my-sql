-- 1. Fetch the names of countries having less than 10 employees.  
select c.country_name ,count(e.employee_id) as count
from countries c, employees e, departments d,locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and l.country_id=c.country_id
group by country_name
having count(employee_id) <10;
-- 2. Fetch a report of total number of employees in each department (Department name, total number of employees). (Try the same without using joins) 
select d.department_name,count(e.employee_id) as count
from employees e, departments d
where e.department_id=d.department_id
group by department_name;

select department_name from departments
where  department_id in (select department_id from employees)
group by department_name;
-- 3. Fetch details of all employees earning more than their department’s average salary 
select * 
from employees e, departments d
where e.department_id=d.department_id
group by department_name
having salary>avg(salary);


-- 4. Fetch a report of all employees names, ids, department name, salary and department average salary. 


select e.employee_id,e.first_name,d.department_name,e.salary,avg(salary) as average_salary 
from employees e, departments d
where e.department_id=d.department_id
group by department_name;



-- 5. Fetch a report of all employees (emp id, name & salary) along with the difference of their salary 
-- from their department’s average . Please group this data department-wise 
-- and sort the data in order of the salary difference . 

select employee_id,first_name,salary,(avg(salary)-salary) as diff_salary 
from employees e, departments d
where e.department_id=d.department_id
group by department_name
order by diff_salary;

-- 6. For each employee in department 80, fetch a report of their names, id, department name, salary,
--  and the difference between their department’s max salary and their salary. 
 
 
select first_name, employee_id, department_id,(select department_name from departments d 
where d.department_id = o.department_id) as name, salary, 
salary-(select max(salary) from employees i where o.department_id = i.department_id ) as diff
from employees o
where department_id = 80
order by diff;

-- 7. Show the employee id, his/her joining date along with the number of employees that were hired on the same date 
select employee_id,hire_date, (select count(employee_id) 
from employees e where e.hire_date=o.hire_date)as count
from employees o order by count desc;
-- 8. Sort the data by department_id and fetch the even records (2nd, 4th , 6th …..) 
 select * 
from (select *, row_number() over (order by department_id) as row_no from employees) as T
where T.row_no mod 2 =0;

-- 9. Find the 25th – 30th highest salary earned by an employee 

select * from (select *, dense_rank() over(order by salary desc) as rnk from employees) as t1
where t1.rnk between 25 and 30;

select * from (select *, rank() over(order by salary desc) as rnk from employees) as t1
where t1.rnk between 25 and 30;

select * from employees order by salary desc limit 5 offset 25;
-- 10. 2 weeks from now bonus will be released for the employees. Bonus will be 3% of their salary. Display employees name, their bonus and the bonus date.  
--  

select first_name, ((salary div 100)*3) as bonus, date_add(curdate(),interval 2 week) as bonus_date;
from employees