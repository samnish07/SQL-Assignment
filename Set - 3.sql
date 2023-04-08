/*1. Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, 
orderdate and status of the orders placed in that month. 

Example:  call order_status(2005, 11);
*/

DELIMITER $$
USE `assignment`$$
CREATE PROCEDURE `order_status`(in in_year int, in in_month int)
BEGIN
select orderNumber, orderDate, status from orders
where year(orderDate) = in_year 
and month(orderDate) = in_month;
END$$

DELIMITER ;

call order_status(2003, 11);

/*
2. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]

if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
if amount > 50000 Platinum

b. Write a query that displays customerNumber, customername and purchase_status from customers table.
*/

DELIMITER $$
USE `assignment`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `purchase_status`(cust_no int) RETURNS varchar(25) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare stat varchar(25);
declare total int;
set total = (select sum(amount) from Payments where customerNumber = cust_no);
if total < 25000 then set stat='silver';
elseif total between 25000 and 50000 then set stat='gold';
elseif total > 50000 then set stat='platinum';
end if;
return stat;
END$$
DELIMITER ;

select purchase_status(114);

# b. Write a query that displays customerNumber, customername and purchase_status from customers table.

DELIMITER $$
USE `assignment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_custno_name_purchasestatus`()
BEGIN
select c.customerNumber, c.customerName,
case when sum(amount) < 25000 then 'silver'
	 when sum(amount) between 25000 and 50000 then 'gold'
     when sum(amount) > 50000 then 'platinum'
end as purchase_status
from customers c join Payments p on c.customerNumber = p.customerNumber
group by p.customerNumber;
END$$
DELIMITER ;

call display_custno_name_purchasestatus();

/*
3. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. 
Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.
*/

# on delete cascade

DELIMITER $$
USE `assignment`$$
CREATE DEFINER = CURRENT_USER TRIGGER `assignment`.`movies_AFTER_DELETE` AFTER DELETE ON `movies` FOR EACH ROW
BEGIN
delete from rentals
where movieid 
not in (select distinct id from movies);
END$$
DELIMITER ;

# on update cascade

DELIMITER $$
USE `assignment`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `movies_AFTER_UPDATE` AFTER UPDATE ON `movies` FOR EACH ROW BEGIN
update rentals
set movieid = new.id
where movieid = old.id;
END$$
DELIMITER ;

# 4. Select the first name of the employee who gets the third highest salary. [table: employee]

select fname, salary from employee order by salary desc limit 1 offset 2;

# 5. Assign a rank to each employee  based on their salary. The person having the highest salary has rank 1. [table: employee]

select *, rank() over (order by salary desc) salary_rank from employee;