-- Person Information
Create Table PersonInfo (
	person_no      INT             NOT NULL,
    first_name  VARCHAR(30)     NOT NULL,
	last_name   VARCHAR(30)     NOT NULL,
	middle_initial VARCHAR(1)     NOT NULL,
    prefix   VARCHAR(10)     NOT NULL,
	suffix   VARCHAR(10)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL, 
    PRIMARY KEY (person_no)
);

-- Person Address
Create Table PersonAddress (
	person_no      INT             NOT NULL,
    AddressLine1  VARCHAR(50)     NOT NULL,
	AddressLine2   VARCHAR(50)     NOT NULL,
	City VARCHAR(20)     NOT NULL,
    State   VARCHAR(2)     NOT NULL,
	zip INT NOT NULL,
    PlaceType ENUM ('Work','Home')  NOT NULL, 
    FOREIGN KEY (person_no)  REFERENCES PersonInfo (person_no) ON DELETE CASCADE,
    PRIMARY KEY (person_no,zip,PlaceType)
);

-- Person Phone Number
Create Table PhoneInfo(
	person_no      INT             NOT NULL,
    AreaCode  INT(3)     NOT NULL,     -- area code length is 3
	DigitNum   INT(7)     NOT NULL,    -- 7 Digit Number
	Extn INT(4)     NOT NULL,          -- extension is 4 digit
    PhoneType ENUM ('Work','Home','Cell','Fax','Other')  NOT NULL, 
    FOREIGN KEY (person_no)  REFERENCES PersonInfo (person_no) ON DELETE CASCADE,
    PRIMARY KEY (person_no,AreaCode,DigitNum,Extn, PhoneType)
);

-- Person Email Information
Create Table EmailInfo(
	person_no      INT             NOT NULL,
    EmailAddress  VARCHAR(50)     NOT NULL,
    EmailType ENUM ('Work','Home','Alternate','Other')  NOT NULL, 
    FOREIGN KEY (person_no)  REFERENCES PersonInfo (person_no) ON DELETE CASCADE,
    PRIMARY KEY (person_no,EmailAddress,EmailType)
);

-- Person's Emergency Contact
Create Table EmergencyContact (
	emergency_no      INT             NOT NULL,
    person_no      INT             NOT NULL,
    EmAddressLine1  VARCHAR(50)     NOT NULL,
	EmAddressLine2   VARCHAR(50)     NOT NULL,
	EmCity VARCHAR(20)     NOT NULL,
    EmState   VARCHAR(2)     NOT NULL,
	Emzip INT NOT NULL,
    Telephone INT NOT NULL,
    FOREIGN KEY (person_no)  REFERENCES PersonInfo (person_no) ON DELETE CASCADE,
    PRIMARY KEY (emergency_no,person_no)
);
    

-- 1) Write a query to select all of the columns and rows from the departments table.
SELECT 
    *
FROM
    departments;
    
-- Write a query to select employee number, first name, and last name.
SELECT 
    emp_no AS 'Employee Number',
    first_name AS 'First Name',
    last_name AS 'Last Name'
FROM
    employees;
    
-- Write a query to select employee’s names and ages.  Age should be calculated in years. 
SELECT 
    CONCAT(first_name, last_name) AS 'Full Name',
    TIMESTAMPDIFF(YEAR,
        birth_date,
        CURDATE()) AS 'Age in Years'
FROM
    employees;
    
-- Write a query to return the current date in the format mm/dd/yyyy.    
SELECT DATE_FORMAT(NOW(), '%m/ %d/ %y') AS 'Current Date';

-- Write a query that returns the number of days until July 4th, 2016.
SELECT DATEDIFF(CURDATE(), '2016-06-04') AS 'Days elapsed since June 4th, 2016';

-- Write a query that shows the number of rows in the employees table
SELECT 
    COUNT(*) AS 'Number of Rows'
FROM
    employees;

-- Write a query that shows all of the salary history of employee # 10911  Casley Shay
-- Columns should include salary (##,###.##), effective date (Month dd, Year) 
-- and end date (Month dd, Year).
SELECT 
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Employee Name',
    FORMAT(salaries.salary, 2) AS 'Current Salary',
    DATE_FORMAT(salaries.from_date, '%M %d,%Y') AS 'Effective Date',
    DATE_FORMAT(salaries.to_date, '%M %d,%Y') AS 'End Date'
FROM
    salaries
        JOIN
    employees ON salaries.emp_no = employees.emp_no
WHERE
    salaries.emp_no = '10911';
 
 
-- Write a query that shows the current salary of employee #10607 Rosalyn Hambrick
-- Columns should include salary (##,###) and effective date (mm/dd/yy).
SELECT 
    salaries.salary AS 'Current Salary',
    DATE_FORMAT(salaries.from_date, '%m/%d/%y') AS 'Effective Date'
FROM
    salaries
        JOIN
    employees ON salaries.emp_no = employees.emp_no
WHERE
    salaries.emp_no = '10607'
        AND salaries.to_date = '9999-01-01';
 
 
 -- Write a query that returns all of the female employees currently 
 -- making less than 50,000 in the Customer Service department. 
 -- Columns should include name (last, first) salary (##,###), 
 -- and salary effective date (YYYY-MM-DD).
 -- Sort the data in alphabetical order by last name.
 SELECT 
    CONCAT(employees.last_name,' ', employees.first_name) AS 'Full Name',
    salaries.salary AS 'Salary',
    DATE_FORMAT(salaries.from_date, '%m/%d/%y') AS 'Effective Date'
FROM
    salaries
        JOIN
    employees ON salaries.emp_no = employees.emp_no
        JOIN
    dept_emp ON dept_emp.emp_no = employees.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
WHERE
    employees.gender = 'F'
        AND salaries.salary < 50000
        order by employees.last_name Desc;
 
-- Write a query to return the minimum current salary (##,###).
SELECT 
    MIN(salaries.salary) AS 'Minimum Current Salary'
FROM
    salaries
WHERE
    salaries.to_date = '9999-01-01';
 
-- Write a query to return the maximum current salary (##,###).
SELECT 
    MAX(salaries.salary) AS 'Maximum Current Salary'
FROM
    salaries
WHERE
    salaries.to_date = '9999-01-01';

-- Write a query to return the maximum current salary in each department.
-- Columns should include department name and salary (##,###).   
SELECT 
    departments.dept_name AS 'Department Name',
    MAX(salaries.salary) AS ' Maximum Current Salary'
FROM
    salaries
        JOIN
    employees ON salaries.emp_no = employees.emp_no
        JOIN
    dept_emp ON dept_emp.emp_no = employees.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
WHERE
    salaries.to_date = '9999-01-01'
GROUP BY departments.dept_name
ORDER BY MAX(salaries.salary) DESC;

-- Write a query that shows the current head count in each department. 
-- The only columns should be department name and the head count.
SELECT 
    departments.dept_name AS 'Department Name',
    COUNT(*) AS 'Head Count'
FROM
    employees
        JOIN
    dept_emp ON dept_emp.emp_no = employees.emp_no
        JOIN
    departments ON departments.dept_no = dept_emp.dept_no
GROUP BY departments.dept_name
ORDER BY COUNT(*) DESC;




    
    
 
 
 
