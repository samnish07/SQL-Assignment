select database();
/*
3. Create a table called countries with the following columns
name, population, capital    
- choose appropriate datatypes for the columns

a) Insert the following data into the table
*/
create table countries (name varchar(20), population integer, capital varchar(20));

insert into countries values ('China',1382,'Beijing'),('India',			1326,	 	'Delhi'),
('United States',		324,	 	'Washington D.C.'),
('Indonesia',		260,	 	'Jakarta'),
('Brazil',			209,	 	'Brasilia'),
('Pakistan',		193,	 	'Islamabad'),
('Nigeria',			187,	 	'Abuja'),
('Bangladesh',		163,	 	'Dhaka'),
('Russia',			143,	 	'Moscow'),
('Mexico',			128,	 	'Mexico City'),
('Japan',			126,	 	'Tokyo'),
('Philippines',		102,	 	'Manila'),
('Ethiopia',		101,	 	'Addis Ababa'),
('Vietnam', 		94,	 	'Hanoi'),
('Egypt',			93,	 	'Cairo'),
('Germany',		81,	 	'Berlin'),
('Iran',			80,	 	'Tehran'),
('Turkey',			79,	 	'Ankara'),
('Congo',			79,	 	'Kinshasa'),
('France',			64,	 	'Paris'),
('United Kingdom',	65,	 	'London'),
('Italy',			60,	 	'Rome'),
('South Africa',		55,	 	'Pretoria'),
('Myanmar',		54,	 	'Naypyidaw');
select * from countries;

# b) Add a couple of countries of ur choice

insert into countries values ('Bhutan', 50, 'Thimphu'),('Canada', 60, 'Ottawa');

# c) Change ‘Delhi' to ‘New Delhi'

update countries set capital='New Delhi' where name='India';

# 4. Rename the table countries to big_countries

rename table countries to big_countries;

/*
5. Create the following tables. Use auto increment wherever applicable

a. Product
product_id - primary key
product_name - cannot be null and only unique values are allowed
description
supplier_id - foreign key of supplier table

b. Suppliers
supplier_id - primary key
supplier_name
location

c. Stock
id - primary key
product_id - foreign key of product table
balance_stock
*/

create table Suppliers (supplier_id int auto_increment,
supplier_name varchar(20),
location varchar(20),
primary key(supplier_id));


create table Product (product_id int auto_increment,
product_name varchar(50) not null unique,
description varchar(250),
supplier_id int,
primary key(product_id),
foreign key(supplier_id) references Suppliers(supplier_id));


create table Stock (id int auto_increment,
product_id int,
balance_stock int,
primary key(id),
foreign key(product_id) references Product(product_id));
 
 # 6. Enter some records into the three tables.
 
 insert into Suppliers (supplier_name,location) values ('Apple','USA'),('Realme','China'),('Mi','China');
 
 insert into Product (product_name,description,supplier_id) values ('iPhone 14 Pro Max', 'Deep Purple 6G B RAM and 256 GB internal memory',
 (select supplier_id from Suppliers where supplier_name='Apple')),('Realme 10 Pro Plus 128 GB', 'Nebula Blue 6 GB RAM and 128 GB internal memory',
 (select supplier_id from Suppliers where supplier_name='Realme')),('Mi 11X Cosmic Black','6 GB RAM and 128 GB Storage',
 (select supplier_id from Suppliers where supplier_name='Mi'));
 
 insert into Stock (product_id,balance_stock) values ((select product_id from Product where product_name='iPhone 14 Pro Max'),550),
 ((select product_id from Product where product_name='Realme 10 Pro Plus 128 GB'),500),
 ((select product_id from Product where product_name='Mi 11X Cosmic Black'),450);
 
 # 7. Modify the supplier table to make supplier name unique and not null.
 
 alter table Suppliers modify supplier_name varchar(20) unique not null;
 
 /*
 8. Modify the emp table as follows

a.	Add a column called deptno

b. Set the value of deptno in the following order

deptno = 20 where emp_id is divisible by 2
deptno = 30 where emp_id is divisible by 3
deptno = 40 where emp_id is divisible by 4
deptno = 50 where emp_id is divisible by 5
deptno = 10 for the remaining records.
*/

select * from emp;
alter table emp add deptno int;

update emp 
set deptno = case when emp_no%2=0 then 20
				  when emp_no%3=0 then 30
				  when emp_no%4=0 then 40
				  when emp_no%5=0 then 50
				  else 10
			end;
                             
# 9. Create a unique index on the emp_id column.

alter table emp rename column emp_no to emp_id;
create unique index unq_idx on emp(emp_id);

/*
10. Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.

emp_no, first_name, last_name, salary
*/

create or replace view emp_sal as
select emp_id, first_name, last_name, salary from emp order by salary desc;

select * from emp_sal;