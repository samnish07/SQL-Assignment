# 1. select all employees in department 10 whose salary is greater than 3000. [table: employee]

select concat(fname,' ',lname) as employees, deptno, salary from employee where deptno=10 and salary>3000;

/*
2. The grading of students based on the marks they have obtained is done as follows:

40 to 50 -> Second Class
50 to 60 -> First Class
60 to 80 -> First Class
80 to 100 -> Distinctions

a. How many students have graduated with first class?
b. How many students have obtained distinction? [table: students]
*/

alter table students add column grade varchar(20);

update students
set grade = case when marks between 40 and 50 then 'Third Class'
				   when marks between 50 and 60 then 'Second Class'
                   when marks between 60 and 80 then 'First Class'
                   when marks between 80 and 100 then 'Distinction'
                   else 'Fail'
                   end;
                   
select count(*) as 'no of students with first class' from students where grade='First Class';

select count(*) as 'no of students with distinction' from students where grade='Distinction';

# 3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]

select distinct city from station where id%2=0;

/* 4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table. 
In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, 
write a query to find the value of N-N1 from station.
[table: station]*/

select count(city)-count(distinct city) as 'diff bet no of total city entries and distinct' from station;

/*
5. Answer the following
a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. 
[Hint: Use RIGHT() / LEFT() methods ]

b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
Your result cannot contain duplicates.

c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
Your result cannot contain duplicates. [table: station]
*/

select distinct city from station where left(city,1) in ('a','e','i','o','u');

select distinct city from station where left(city,1) in ('a','e','i','o','u') and
right(city,1) in ('a','e','i','o','u');

select distinct city from station where left(city,1) not in ('a','e','i','o','u');

select distinct city from station where left(city,1) not in ('a','e','i','o','u') and
right(city,1) not in ('a','e','i','o','u');

/*6. Write a query that prints a list of employee names having a salary greater than $2000 per month who have been employed for less than 36 months. 
Sort your result by descending order of salary. [table: emp]*/

select concat(first_name,' ',last_name) as employees, salary,
timestampdiff(month,hire_date,(select max(hire_date) from emp)) as duration
from emp 
where timestampdiff(month,hire_date,(select max(hire_date) from emp))<36 and
salary > 2000 order by salary desc;

# 7. How much money does the company spend every month on salaries for each department? [table: employee]

select deptno, sum(salary) as total_salary from employee group by deptno;

# 8. How many cities in the CITY table have a Population larger than 100000. [table: city]

select count(name) as 'no of cities with population > 100000' from city where population > 100000;

# 9. What is the total population of California? [table: city]

select district, sum(population) as 'total population' from city where district='California';

# 10. What is the average population of the districts in each country? [table: city]

select countrycode as country, district, avg(population) as 'average population' from city
group by countrycode, district;

# 11. Find the ordernumber, status, customernumber, customername and comments for all orders that are ‘Disputed=  [table: orders, customers]

select c.customerNumber, o.orderNumber, c.customerName, o.status, o.comments
from orders o join customers c on o.customerNumber = c.customerNumber
where o.status = 'Disputed'; 