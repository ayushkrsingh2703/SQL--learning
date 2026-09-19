-- SQL JOINS
-- SQL JOIN is used to combine rows from two or more tables based on a related column between them.

-- Types of joins
/*
| JOIN                | What it returns                |
| ------------------- | ------------------------------ |
| **INNER JOIN**      | Matching rows from both tables |
| **LEFT JOIN**       | All left + matching right      |
| **RIGHT JOIN**      | All right + matching left      |
| **FULL OUTER JOIN** | All rows from both tables      |
| **CROSS JOIN**      | Every possible combination     |
| **SELF JOIN**       | Table joined with itself       | */

-- 1.CROSS JOINS (It produces a cartisian product)
use ayush;
create table students(
stu_id int,
stu_name varchar(255)
);
insert into ayush.students 
values (1,'Ayush'),
(2,'kunal'),
(3,'Ayman');
select * from students;
create table courses (
course_id int ,
course_name varchar(255));
insert into ayush.courses values 
(010,'sql'),
(020,'excel');
select * from courses;
-- cross join query
select * from ayush.students s1
cross join ayush.courses c2;

-- INNER JOIN (returns only those rows where the joining condition matches in both tables.
CREATE TABLE students2 (
    student_id INT,
    student_name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO students2 (student_id, student_name, city)
VALUES
(1, 'Ayush', 'Delhi'),
(2, 'Rahul', 'Mumbai'),
(3, 'Aman', 'Pune'),
(4, 'Rohit', 'Delhi');
select * from students2;
CREATE TABLE marks (
    student_id INT,
    subject VARCHAR(50),
    marks INT
);
INSERT INTO marks (student_id, subject, marks)
VALUES
(1, 'SQL', 85),
(2, 'SQL', 78),
(3, 'SQL', 92),
(5, 'SQL', 88);
select * from marks;
-- INNER JOIN QUERY
select * from ayush.students2 s1
inner join ayush.marks s2
on s1.student_id=s2.student_id;

-- LEFT JOIN (It returns All rows from the LEFT table + matching rows from the RIGHT table.
select * from ayush.students2 s
left join ayush.marks m
on s.student_id=m.student_id;

-- RIGHT JOIN(It returns all rows from the right table + matching rows from the left table)
select * from ayush.students2 s 
right join ayush.marks m 
on s.student_id = m.student_id ;

-- MY SQL DOESNOT DIRECTLY SUPPORT FULL OUTER JOIN ( explained below)

-- SET OPERATIONS
-- Set Operations are used to combine the results of two or more SELECT queries.

/* The main SQL set operations are:

UNION
UNION ALL
INTERSECT
EXCEPT / MINUS */

create table person1(
id int ,
name varchar(50));
insert into ayush.person1
values (1,'ayush'),
(2,'alok'),
(3,'jatin'),
(5,'Adit');
select * from ayush.person1;
create table person2(
id int ,
name varchar(50));
insert into person2 values
(4,'pritam'),
(5,'Adit');
select * from ayush.person2;

-- UNION
select * from ayush.person1
union
select * from ayush.person2;

-- UNION ALL
select * from ayush.person1
union all 
select * from ayush.person2;

-- INTERSECT
select * from ayush.person1
intersect
select * from ayush.person2;

-- EXCEPT
select * from ayush.person1
except
select * from ayush.person2;

-- FULL OUTER  JOIN

select * from ayush.students2 s
left join ayush.marks m
on s.student_id=m.student_id
UNION
select * from ayush.students2 s 
right join ayush.marks m 
on s.student_id = m.student_id ;


-- SELF JOIN(A SELF JOIN is a join in which a table is joined with itself.)

-- It is useful when rows in the same table are related to other rows in that table.
CREATE TABLE employees (
    employee_id INT,
    employee_name VARCHAR(50),
    manager_id INT
);
INSERT INTO employees (employee_id, employee_name, manager_id)
VALUES
(1, 'Raj', NULL),
(2, 'Ayush', 1),
(3, 'Rahul', 1),
(4, 'Aman', 2),
(5, 'Rohit', 2);
select * from ayush.employees;
select * from ayush.employees e1
join ayush.employees e2
on e1.manager_id = e2.employee_id;
-- here : Raj is the manager of Ayush and Rahul.Ayush is the manager of Aman and Rohit.

-- JOINING ON MORE THAN ONE COLMs
use ayush;
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    quantity INT
);
INSERT INTO orders (order_id, customer_id, product_id, quantity)
VALUES
(101, 1, 10, 2),
(102, 1, 20, 1),
(103, 2, 10, 3),
(104, 2, 20, 2);
CREATE TABLE sales (
    customer_id INT,
    product_id INT,
    price INT
);
INSERT INTO sales (customer_id, product_id, price)
VALUES
(1, 10, 500),
(1, 20, 700),
(2, 10, 600),
(2, 20, 800);
select * from orders;
select * from sales;
select * from orders o 
join sales s 
on o.customer_id = s.customer_id 
and o.product_id = s.product_id;

-- JOINING MORE THAN TWO TABLES
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO customers
VALUES
(1, 'Rahul', 'Delhi'),
(2, 'Priya', 'Mumbai'),
(3, 'Amit', 'Pune');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT
);
INSERT INTO orders
VALUES
(101, 1, 10, 2),
(102, 2, 20, 1),
(103, 3, 10, 3);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);
INSERT INTO products
VALUES
(10, 'Laptop', 50000),
(20, 'Mouse', 1000);
-- multiple table joining queries
select * from customers as c
join orders as o 
on c.customer_id =o.customer_id
join products as p
on p.product_id= o.product_id;


