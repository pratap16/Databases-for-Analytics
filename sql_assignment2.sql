-- 4.	What employees report directly to the to the VP Sales?  
-- List their name and their job title.  
-- (Hint: you’ll need to alias tables to avoid ambiguity)

-- good 30/30.
SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Employee ',
    m.jobTitle AS 'Manager Job Title',
    e.jobTitle AS 'Employee Job Title'
FROM
    employees e
        INNER JOIN
    employees m ON m.employeeNumber = e.reportsto
WHERE
    UPPER(m.jobTitle) = 'VP SALES';

-- 5.	Assuming a sales commission of 5% on every order, 
-- calculate the sales commission due for all employees.  
-- List the employee name and the sales commission they’re due.

SELECT 
    CONCAT(employees.lastName,
            ', ',
            employees.firstName) AS 'Employee Name',
    format(SUM(orderdetails.quantityOrdered * orderdetails.priceEach) * .05,2) AS commision
FROM
    employees
        LEFT JOIN
    customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
        JOIN
    orders ON orders.customerNumber = customers.customerNumber
        JOIN
    orderdetails ON orders.orderNumber = orderdetails.orderNumber
GROUP BY employees.employeeNumber;


-- 6.	Create a list of customers and the amount they currently owe us.  
-- List the customer name and the amount due.  
-- Create views to track the total amount ordered and the total amount paid.  
-- Use these views to create your final query.  
-- Important – do not format interim numeric results.  
-- If you need to round numbers use the round function.  
-- Don’t format your numbers until your final query.
--  Having imbedded commas in numeric fields can cause math problems.


drop view orderTotal;

CREATE VIEW orderTotal AS
    SELECT 
        customers.customerNumber AS 'customerNumber',
        customers.customerName AS 'CustomerName',
        orderdetails.orderNumber AS 'orderNumber',
        SUM(orderdetails.quantityOrdered * orderdetails.priceEach) AS 'orderTotal'
    FROM
        customers
            LEFT JOIN
        orders ON customers.customerNumber = orders.customerNumber
            JOIN
        orderdetails ON orders.orderNumber = orderdetails.orderNumber
    GROUP BY customers.customerNumber ;

SELECT 
    *
FROM
    orderTotal
GROUP BY orderTotal.customerNumber;


drop view PaidPayment;

CREATE VIEW Paid_Payment AS
    SELECT 
        payments.customerNumber, SUM(payments.amount) AS paidTotal
    FROM
        payments
    GROUP BY payments.customerNumber;

SELECT 
    *
FROM
    Paid_Payment;

SELECT 
    o.CustomerName,
    
    format((o.orderTotal-p.paidTotal),2) AS due
FROM
    orderTotal AS o
        LEFT JOIN
    Paid_Payment AS p ON o.customerNumber = p.customerNumber
GROUP BY o.customerNumber;

