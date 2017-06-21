-- 1.   Land of Toys, customer # 131 has a new phone number. 212-555-9987. Update accordingly.


SELECT 
    *
FROM
    customers
WHERE
    customerNumber = 131;

UPDATE customers 
SET 
    phone = 2125559987
WHERE
    customerName = 'Land of Toys Inc.'
        AND customerNumber = 131;

-- 2.  American Souvenirs, Inc. customer # 168 has a new address.  
-- Update accordingly to:335 Allendale Lane Bristol, CT  06010

SELECT 
    *
FROM
    customers
WHERE
    customerNumber = 168;

UPDATE customers 
SET 
    postalCode = '06010',
    addressLine1 = '335 Allendale Lane',
    addressLine2 = NULL,
    city = 'Bristol'
WHERE
    customerNumber = 168;

-- ANG Resellers has been assigned a new sales representative. 
-- Leslie Thompson is now assigned to that account. Update accordingly.

SELECT 
    *
FROM
    customers
WHERE
    customers.customerName = 'ANG Resellers'; -- customerNumber=237  salesRepEmployeeNumber=Null


SELECT 
    jobTitle,employeeNumber,
    CONCAT(employees.lastName,
            ', ',
            employees.firstName) AS 'Employee Name'
FROM
    employees
WHERE
    jobTitle = 'Sales Rep'
        AND lastName = 'Thompson'
        AND firstName = 'Leslie';     -- employeeNumber=1166
            
UPDATE customers 
SET 
    salesRepEmployeeNumber=1166
WHERE
    customerNumber=237; 
        
-- 4.  Martin Gerard is no longer with the company. 
-- All of his accounts will be handled by the VP
-- Sales.  Update the appropriate customer records and remove Gerald’s record.


select * from employees where lastName='Gerard' and firstName='Martin'; -- employeeNumber=1702
select * from employees where jobTitle='VP Sales'; -- employeeNumber=1056

select * from customers where salesRepEmployeeNumber=1702;

Update customers
set salesRepEmployeeNumber=1056
where salesRepEmployeeNumber=1702;

select * from customers where salesRepEmployeeNumber=1056;

delete from employees where employeeNumber=1702;

select * from employees where employeeNumber=1702;
select * from employees where employeeNumber=1056;
 

-- 5.  We’ve hired a new employee. Details are:
-- Keith Johnson
-- Director of Business Development
-- Employee Number 1875
-- Extension 3322
-- kjohnson@classicmodelcars.com
-- He will work in the San Francisco Office
-- He will report to Jeff Firrelli 


select *from employees WHERE
    employees.lastName = 'Firrelli'
        AND employees.firstName = 'Jeff';
SELECT 
    *
FROM
    offices
WHERE
    city = 'San Francisco';

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) 
values (1875,'Johnson','Keith','3322','kjohnson@classicmodelcars.com','1',1076,'Director of Business Development');

-- 6.  All of Euro + Shopping Channel’s In Process orders were shipped
-- on December 2nd 2016. Update accordingly, including status.

select * from customers 
where  customerName='Euro+ Shopping Channel';

select * from orders
where orders.customerNumber=141 
and
    orders.orderNumber=10424;

UPDATE customers
        LEFT JOIN
    orders ON customers.customerNumber= orders.customerNumber
SET orders.shippedDate = DATE(STR_TO_DATE('2016-12-02', '%Y-%m-%d')),
    orders.status='Shipped'
WHERE
    customers.customerNumber=141
    and customerName='Euro+ Shopping Channel'
    and
    orders.orderNumber=10424;
    
-- 7.  What does the rollback command do?
-- The ROLLBACK command is the transactional command used to undo transactions that 
-- have not already been saved to the database.
-- The ROLLBACK command can only be used to undo transactions since the last COMMIT 
-- or ROLLBACK command was issued.


-- 8.  Create a new table called PlaneProducts that has all of the information
--   from the products table for anything in the planes product line.


Create table PlaneProducts
AS
(SELECT 
    *
FROM
    products
    WHERE
    products.productLine = 'Planes');
    
 SELECT *FROM    PlaneProducts;
        