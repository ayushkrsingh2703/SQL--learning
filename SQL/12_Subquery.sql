-- SUBQUERY 
-- QUERY INSIDE ANOTHER QUERY 


-- find the movie having heighest rating
use ayush;
select max(score) from ayush.movies;

select * from ayush.movies 
where score=9.3;

select * from ayush.movies 
order by score
desc
limit 1;

-- example of subquery
select * from ayush.movies 
where score =( 
select max(score) from ayush.movies);

-- Types of subqueries (on the basis of returned data)
-- 1.scalar subquery 2.row subquery 3.table subquery

-- Types of subqueries ( on the basis of working)
-- 1.independent subquery 2.correlated subquery

-- Independent subquery(scalar)

-- Q1 find the movie with the heighest profit
select name , budget-gross as 'profit' from ayush.movies
order by profit desc
limit 1;

select * from ayush.movies 
where budget-gross = (select max(budget-gross) from ayush.movies);

-- Q2 find how many movies have a rating greater than the avg of all the movies 
select count(*) from ayush.movies 
where score > (select avg(score)  from ayush.movies );

-- Q3 find the heighest rated movie of 2000
select * from ayush.movies
where year=2000 and score = (
							select max(score) from ayush.movies
                            where year=2000);
                            
-- Q4 find the heighest rated movie among all movies whose no. of votes are greater than avg votes
select * from ayush.movies 
where score =(
			select max(score) from ayush.movies 
            where votes>(
						select avg(votes) from ayush.movies ));
                        
-- Independent subquery (row)

-- Q1 find all the movies made by top 3 directords in the terms of gross income
SELECT *
FROM movies
WHERE director IN (
    SELECT director
    FROM (
        SELECT director
        FROM movies
        GROUP BY director
        ORDER BY SUM(gross) DESC
        LIMIT 3
    ) AS top_directors
);

-- Q2 find all movies of all those actors whose filmographys avg rating >8.5  take 25000 votes as cutoff 
select * from ayush.movies 
where star in (select star from ayush.movies 
				where votes>25000
				group by star
				having avg (score)>8.5);
                
-- Independent subquery(table subquery)

-- find the most profitable movie of each year

select name,year,gross-budget as 'profit' from ayush.movies 
where (year,gross-budget) in (select year,max(gross-budget) from ayush.movies 
								group by year);

-- find the heighest rated movie of each genre votes cutoff of 25000
select genre ,max(score) from ayush.movies 
where votes>25000
group by genre ;

select name ,genre ,score from ayush.movies 
where (genre,score) in (select genre ,max(score) 
						from ayush.movies 
						where votes>25000
						group by genre )
                        and votes>25000;
                        
-- Correlated subquery

                        
                        







