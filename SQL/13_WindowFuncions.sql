-- WINDOW FUNCTIONS

-- window functions perform calculations across multiple rows while keeping each row in the result.
create database sql_learning;
use  sql_learning;
CREATE TABLE marks (
 student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

INSERT INTO marks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);

select * from marks;

select avg(marks) from marks;

select  *,avg(marks) over() from marks;

select * ,avg(marks) over(partition by branch) as 'branch_avg' from marks;
 
select * ,
min(marks) over() as min_marks,
max(marks) over() as max_marks
from marks;

-- find all the students who have marks higher than the avg marks of their respective branch
select * from (select *,
avg(marks) over(partition by branch)
as branch_avg
from marks) t 
where t.marks>t.branch_avg;

-- RANK/DENSE_RANK/ROW_NUMBER

-- RANK() skips the next rank when two or more rows have the same value.
-- DENSE_RANK() does not skip any rank when two or more rows have the same value.
-- ROW_NUMBER() Assigns a unique sequential number to every row


-- topoper of all branches
SELECT * ,
RANK() OVER (ORDER BY marks DESC),
dense_rank() OVER (ORDER BY marks DESC),
row_number() over()
FROM marks;

-- branch wise toppper 
select *,
rank () over ( partition by branch order by marks  desc),
dense_rank () over (partition by branch order by marks desc)
from marks;

-- FIRST_VALUE/LAST_VALUE/NTH_VALUE

-- FIRST_VALUE() → Returns the first value in a window.
-- LAST_VALUE() → Returns the last value in a window frame.
-- NTH_VALUE() → Returns the value at the Nth position in a window frame.

select *,
first_value(name) over(order by marks desc) as 'topper'
from sql_learning.marks;

select *,
first_value(marks) over(order by marks desc) as 'highest_marks'
from sql_learning.marks;

-- FRAMES

-- A frame helps you specify which rows should be considered when calculating a result for the current row.
-- Frames are mainly used with window functions such as SUM(), AVG(), COUNT(), FIRST_VALUE(), and LAST_VALUE().
-- 1.ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
-- 2.ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
-- 3.ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
-- 4.ROWS BETWEEN 3 PRECEDING AND 2 FOLLOWING


-- LAST_VALUE()
SELECT *,
LAST_VALUE(NAME) OVER(ORDER BY marks DESC 
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'least_scorer'
FROM sql_learning.marks;
                    
SELECT *,
LAST_VALUE(marks) OVER(ORDER BY marks DESC 
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'least_scorer'
FROM sql_learning.marks;

SELECT *,
LAST_VALUE(NAME) OVER(PARTITION BY BRANCH ORDER BY marks DESC 
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'least_scorer'
FROM sql_learning.marks;

-- NTH_VLAUE(NAME,POSITION)

SELECT *,
NTH_VALUE(name,2) OVER(PARTITION BY BRANCH ORDER BY marks DESC 
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
AS 'least_scorer'
FROM sql_learning.marks;


-- Q. find the branch toppers
select * from sql_learning.marks;

 

select name,branch,marks
from (select *,
first_value(name) over (partition by branch order by marks desc) as topper_name,
first_value(marks) over(partition by branch order by marks desc) as topper_marks
from sql_learning.marks) t
where t.name=t.topper_name and t.marks=t.topper_marks;


-- those who have scored last position in every branch
select * ,
last_value(name) over(partition by branch order by marks desc 
					rows between unbounded preceding and unbounded following)
as lowest_scorer,
last_value(marks ) over(partition by branch order by marks desc 
					rows between unbounded preceding and unbounded following)
                    as lowest_score
from sql_learning.marks;





select name,branch,marks
from (select * ,
		last_value(name) over(partition by branch order by marks desc 
							rows between unbounded preceding and unbounded following)
		as lowest_scorer,
		last_value(marks ) over(partition by branch order by marks desc 
							rows between unbounded preceding and unbounded following)
		as lowest_score
		from sql_learning.marks) t
where t.name=t.lowest_scorer and t.marks=t.lowest_score;

-- we can also use the window keyword in the place of code that we have writeen multiple times in the over fun

select name,branch,marks
from (select * ,
		last_value(name) over w
		as lowest_scorer,
		last_value(marks ) over w
		as lowest_score
		from sql_learning.marks
        
        window w as (partition by branch 
			order by marks desc 
			rows between unbounded preceding and unbounded following)) t
            
where t.name=t.lowest_scorer and t.marks=t.lowest_score;

-- LEAD AND LAG
-- LAG() → Accesses data from a previous row.
-- LEAD() → Accesses data from a subsequent (next) row.

select *,
lead(marks) over (order by student_id asc),
lag(marks) over (order by student_id asc)
from sql_learning.marks
