CREATE SCHEMA FinalExam;

CREATE TABLE finalexam.instructor(
   INSTRUCTORID INTEGER NOT NULL,
   NAME VARCHAR(25) NULL,
   DEPARTMENT VARCHAR(25) NULL,
   SALARY INTEGER NOT NULL,
   PRIMARY KEY (INSTRUCTORID),
   INDEX SALARY_index (SALARY)
);

-- Created the MySQL Table `instructor` successfully.

-- Inserted Excel data in MySQL Table `instructor` with the following statements:

 INSERT INTO finalexam.instructor (INSTRUCTORID,NAME,DEPARTMENT,SALARY) VALUES (44547,'Smith','Computer Science',95000);
 INSERT INTO finalexam.instructor (INSTRUCTORID,NAME,DEPARTMENT,SALARY) VALUES (44541,'Bill','Electrical',55000);
 INSERT INTO finalexam.instructor (INSTRUCTORID,NAME,DEPARTMENT,SALARY) VALUES   (47778,'Sam','Humanities',44000);
 INSERT INTO finalexam.instructor (INSTRUCTORID,NAME,DEPARTMENT,SALARY) VALUES  (48147,'Erik','Mechanical',80000);
 INSERT INTO finalexam.instructor (INSTRUCTORID,NAME,DEPARTMENT,SALARY) VALUES   (411547,'Melisa','Information Technology',65000);
INSERT INTO finalexam.instructor (INSTRUCTORID,NAME,DEPARTMENT,SALARY) VALUES   (48898,'Jena','Civil',50000);


-- Executed the following statement to create MySQL Table `department`:

CREATE TABLE finalexam.department(
   DEPARTMENT VARCHAR(25) NOT NULL,
   Budget INTEGER NOT NULL,
   PRIMARY KEY (DEPARTMENT),
   INDEX Budgetindex (Budget)
);

-- Created the MySQL Table `department` successfully.

-- Inserted Excel data in MySQL Table `department` with the following statements:

INSERT INTO finalexam.department (DEPARTMENT,Budget) VALUES ('Computer Science ',100000);
INSERT INTO finalexam.department (DEPARTMENT,Budget) VALUES ('Electrical ',80000);
INSERT INTO finalexam.department (DEPARTMENT,Budget) VALUES('Humanities ',50000);
INSERT INTO finalexam.department (DEPARTMENT,Budget) VALUES ('Mechanical ',40000);
INSERT INTO finalexam.department (DEPARTMENT,Budget) VALUES ('Information Technology ',90000);
INSERT INTO finalexam.department (DEPARTMENT,Budget) VALUES ('Civil ',60000);
-- Inserted 6 row(s) successfully.
select * from department;

select * from instructor;

-- 1.A) Display all professors whose salary is greater than the average budget of all the departments.(1 Marks) 

select Name from instructor where salary >(select avg(Budget) from department);

-- 1.B) Display the name of the department that has budget of more than 50000(1 Mark)  

select department from department where budget >50000;

-- 1.C) Display the ID of those instructors who have an ID length of 6 characters (1 Mark)  

select instructorid,name from instructor where length(instructorid)=6;

-- 1.D) Display the name of all instructors with their respective department name and budget. (1 Mark) 

select i.name,i.department,d.budget from instructor i,department d
where i.department=d.department;

-- 1.E) Display all the details of instructors whose department name contains the word ‘science’ (1 Mark) 

select * from instructor where DEPARTMENT like "%science";


CREATE TABLE product (
  product_id int(11),
  product_name Varchar(30)
  );
  
  insert into product values(100, 'Nokia');
  insert into product values(200, 'IPhone');
  insert into product values(300, 'Samsung');
  insert into product values(100, 'LG');

CREATE TABLE sales (
  SALE_ID Integer,
  PRODUCT_ID Integer,
  PRD_DATE TIMESTAMP,
  QUANTITY Integer,
  PRICE Integer
  );
  
insert into sales values(1,100,'2008-01-01 00:00:01',25,5000);
insert into sales values(2,100,'2008-01-01 00:00:01',16,5000);
insert into sales values(3,100,'2008-01-01 00:00:01',8,5000);
insert into sales values(4,200,'2008-01-01 00:00:01',10,9000);
insert into sales values(5,200,'2008-01-01 00:00:01',15,9000);
insert into sales values(6,200,'2008-01-01 00:00:01',20,9000);
insert into sales values(7,300,'2008-01-01 00:00:01',20,7000);
insert into sales values(8,300,'2008-01-01 00:00:01',18,7000);
insert into sales values(9,300,'2008-01-01 00:00:01',20,7000);

select * from sales;

 -- 2.A) Write a query to fetch the top 5 records from Sales table so as to include the columns Sale_ID, Product_ID and Quantity renamed as shown below
select sale_id,product_id,quantity from sales;

-- 2.B) Write a query to fetch the details (SALE_ID, DATE, Quantity, PRICE, PRODUCT_NAME) of the products sold

select sale_id, prd_date, quantity, price, product_name
from sales s, product p
where  s.product_id = p.product_id;

-- 2.C) Write a query to fetch the details (SALE_ID, DATE, Quantity, PRICE, PRODUCT_NAME) of the products sold in 2017
select s.sale_id, s.quantity, s.price, s.prd_date, p.product_name
from sales s, product p
where  s.product_id = p.product_id 
and prd_date > '2017-01-01 00:00:00';


 -- 2.D) Write a query to fetch the details (SALE_ID, PRODUCT_ID, DATE, Quantity, PRICE, PRODUCT_ID, PRODUCT_NAME) of the product that ends with 'Phone' 
 
 select sale_id, s.product_id, quantity, price, product_name
from sales s, product p
where  s.product_id = p.product_id and product_name like '%Phone';

-- 2.E) Write a query to fetch the Sales details (SALE_ID, PRODUCT_ID, DATE, Quantity, PRICE, PRODUCT_ID, PRODUCT_NAME) for the products  -  ‘Nokia’, ‘Samsung’, and ‘LG’

select sale_id, s.product_id, s.prd_date, quantity, price, product_name
from sales s, product p
where  s.product_id = p.product_id and product_name in ('Nokia','Samsung','LG');


-- 3.A) Write a query to fetch the name, total sales, average price and total quantity sold for each product in the database
select product_name, sum(price*quantity) as total_Sales, avg(price) as average_price, sum(quantity) as total_quantity
from sales, product
group by product_name;
-- 3.B) Write a query to display the names of products sold since 1st October 2016. (1 Mark) 
select product_name 
from product, sales
where sales.product_id = product.product_id
and prd_date > '2016-10-01 00:00:00';
-- .C) Write a query to fetch year wise total sales, average sales and total quantity for each product along with the name of the product
select product_name, sum(price*quantity) as total_Sales, avg(price) as average_price, sum(quantity) as total_quantity
from sales, product
group by format(prd_date,'%Y');

-- 3.D) Write a query to display total sales details for every quarter. (1 Mark) 
select sum(price*quantity) as total_Sales, quarter(prd_date)
from sales
group by quarter(prd_date);
-- 3.E) Fetch Total Sales details on monthly and yearly basis and arrange the output as per year and month in descending order.  (
SELECT     { fn MONTHNAME(prd_date) } AS MonthName, YEAR(prd_date) AS Year, SUM(price*quantity) AS total_sales
FROM sales
WHERE     (YEAR(prd_date) = @year)
GROUP BY { fn MONTHNAME(prd_date) }, YEAR(prd_date), MONTHNAME(prd_date)
order by Year(prd_date),month(prd_date);






  
  CREATE TABLE customer (
  CUSTOMERID Int(11),
  CUSTOMERNAME varchar(40),
  CONTACTNAME varchar(30) ,
  ADDRESS varchar(30),
  CITY varchar(20),
  POSTALCODE int (11) ,
  COUNTRY varchar (20)
  );
  
insert into customer values(1, "Alfreds Futterkiste"," Maria Anders"," Obere Str. 57"," Berlin",12209," Germany" );
insert into customer values(2," Ana TrujilloEmparedados  y helados","Ana Trujillo"," AvdadelaConstituciÃ³n2222","MÃ©xico D.F",5021,"Mexico" );
insert into customer values(3,"Antonio Moreno  TaquerÃa","Antonio  Moreno","Mataderos 2312","MÃ©xico D.F",5023,"Mexico" );

select * from customer;

-- 4.A) Write a query to display customer name1, customer name2 and city who reside in the same city.(3 Marks

SELECT customername,contactname,city
FROM customer c
WHERE c.city = c.city;

-- 4.B) Write a query to display all details of the customers where city contains 'D.F' (1 Mark);
select * from customer where city like "%d.f%";


-- 4.C) Write a query to display all details of the customers whose name has ‘i’ in the last but one position

select * from customer where customername like "%i_";

-- SECTION B

  CREATE TABLE emptable (
EMPID Int (11),
EMPNAME varchar (30),
HIRE_DATE Date, 
SALARY Int, 
DEPTNO Int 
  );
  
  insert into emptable values(1,"Shivani","2018-08-01", 4000, 10);
insert into emptable values(1,"Shivani","2018-08-01", 4000, 10);
insert into emptable values(2,"John","2018-08-01",4900,20 );
insert into emptable values(1, "Priya", "2017-07-01", 6000, 30);
insert into emptable values(1 ,"Swati","2017-04-01",4500,20);

select * from emptable;

 -- Write a query to display non duplicate rows without using ‘distinct’
 
 SELECT empname, COUNT(*) as CNT
FROM  emptable
GROUP BY empname;
HAVING cnt  = 1;

-- 5.B) Write a query to display year and number of employees joined in each year (4 Mark) 

SELECT DATE_FORMAT (HIRE_DATE,'%Y') as year,COUNT(EMPid) as number 
FROM emptable
GROUP BY empid, DATE_FORMAT(HIRE_DATE, '%Y');

-- 5.C) Write a query to display the below series 

-- 5.D) Write a query to display department wise average salary 


select deptno, avg(salary) as Avg_salary
from emptable
group by deptno;

-- 5.E) Write a query that returns the result as “<Name of employee> joined on <Hire_date> for all the employees  
 
select concat( empname,"joined on", Hire_date) from emptable;

-- 5.F) Write a query to display minimum and maximum salaries without using min and max functions in a single query. (3 Marks








-- section c

create table A (
x int(11)
);

insert into A values(2);
insert into A values(-2);
insert into A values(4);
insert into A values(-4);
insert into A values(-3);
insert into A values(0);
insert into A values(2);

create table mass(
weight decimal(10,4)
);

select * from mass;

insert into mass values(5.5700);
insert into mass values(34.5670);
insert into mass values(365.2530);
insert into mass values(34.0000);

-- 6.A) Write a query to display 2nd highest salary by using window or analytical function (use table emp

select lag(salary,1) over (order by salary desc) second_highest
from emptable
limit 1 offset 2;


-- 6B Write a query to display 2nd to 4th highest salary from emp table.

select salary from empltable
order by salary desc
limit 3 offset 1;


-- 6C  Write a query to display the sum of all positive numbers as sum_pos and negative numbers as sum_neg in the given table ‘A’

select sum(case when x>=0 then x else 0 end) as sum_pos,
sum(case when x<0 then x else 0 end) as sum_neg
from A;

-- 6D Write a query to display the output

select weight, cast(substring_index(weight, '.', 1) as unsigned) as kg,
       cast(substring_index(weight, '.', -1) as unsigned) as gms
from mass;


-- 6E Write a query to display the current date, total number of rows in employees (emp) and ‘A’ table using subqueries

select current_time,(select count(*) from employee) as employee_count,(select count(*) from A) as A_count
from dual;


-- 6F Write a query to display all the details of employees who work in the same department and drawing salary less than 5000, sorted by highest to lowest salary 

select * from employee
where salary < 5000
order by deptno asc,salary desc;





