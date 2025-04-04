` --table creation
 CREATE DATABASE EmployeeDB;
 Select DB_name()
 Use EmployeeDB

  CREATE TABLE departments (
		department_id INT PRIMARY KEY,
		department_name NVARCHAR(50) NOT NULL
	);

 CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    age INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    manager_id INT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);
 
 -- Step 4: Insert data into the departments table
INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance'),
    (4, 'Marketing'),
    (5, 'Sales');
	
INSERT INTO departments (department_id, department_name)
VALUES
	(6, 'MAnagement');

INSERT INTO employees (employee_id, name, age, salary, department_id, manager_id)
VALUES
    (101, 'Alice', 30, 70000, 1, NULL),     -- Alice works in IT and is a top-level manager.
    (102, 'Bob', 28, 55000, 1, 101),       -- Bob works in IT and reports to Alice.
    (103, 'Charlie', 35, 60000, 2, NULL),  -- Charlie works in HR and is a top-level manager.
    (104, 'Diana', 40, 80000, 3, NULL),    -- Diana works in Finance and is a top-level manager.
    (105, 'Eva', 26, 45000, 3, 104),       -- Eva works in Finance and reports to Diana.
    (106, 'Frank', 32, 50000, 4, NULL),    -- Frank works in Marketing.
    (107, 'Grace', 29, 48000, 4, 106),     -- Grace works in Marketing and reports to Frank.
    (108, 'Henry', 27, 47000, 5, NULL);    -- Henry works in Sales.
	
INSERT INTO employees (employee_id, name, age, salary, department_id, manager_id)
VALUES
	(109, 'Jack', 25, 50000, 7, NULL);     --Added Jack to the table
	
ALTER TABLE employees ADD Date_of_Joining DATE DEFAULT getdate()
ALTER TABLE employees ADD DOB DATE

--Updation of DOB into EMployees
UPDATE employees SET DOB='1983-01-10' WHERE name='Alice'
UPDATE employees SET DOB='1993-08-10' WHERE name='Bob'
UPDATE employees SET DOB='1987-04-10' WHERE name='Charlie'

--Updation of DOJ
UPDATE employees SET Date_of_Joining='2024-07-12' WHERE name='Alice'
UPDATE employees SET Date_of_Joining='2024-08-01' WHERE name='Bob'
UPDATE employees SET Date_of_Joining='2024-07-26' WHERE name='Charlie'
UPDATE employees SET Date_of_Joining='2024-10-10' WHERE name='Diana'
UPDATE employees SET Date_of_Joining='2024-10-23' WHERE name='Eva'
UPDATE employees SET Date_of_Joining='2024-11-20' WHERE name='Frank'
UPDATE employees SET Date_of_Joining='2024-09-18' WHERE name='Grace'
UPDATE employees SET Date_of_Joining='2024-09-02' WHERE name='Henry'

-- Reassigning employees from Dept2 to Dept1
UPDATE employees SET department_id= 1 WHERE department_id=2

UPDATE employees SET name='David' WHERE employee_id=108

SELECT TOP 2* FROM employees 
SELECT top 1* FROM employees ORDER BY employee_id DESC

--Deletiion of an employee
DELETE From TABLE employees  


INSERT INTO employees (employee_id, name, age, salary, department_id, manager_id) VALUES (109, 'Jack', 25, 50000, 6, NULL);

INSERT INTO departments 
VALUES
(7, 'Testing');

CREATE TABLE sampleVal(val1 INT, Val2 VARCHAR(10));

INSERT INTO sampleVal VALUES
(1, 'sampleONE'),(2, 'sampleTWO');

SELECT * FROM sampleVal;

TRUNCATE TABLE sampleVal;
DROP TABLE sampleVal;


CREATE TABLE sampleVal(ID INT IDENTITY(1,1), NAME VARCHAR(10));

INSERT INTO sampleVal VALUES
('Josh'),('Joe');
 
SELECT * FROM departments;
SELECT Date_of_Joining, name, department_id FROM employees;
SELECT * from employees;

SELECT department_id,COUNT(name) AS 'Emp_Count'
FROM employees GROUP BY department_id HAVING COUNT(name)>1

SELECT * FROM employees WHERE Date_of_Joining>=DATEADD(MONTH, -6, getdate()) 

SELECT * FROM employees WHERE salary > 50000 AND age >30
SELECT * FROM employees WHERE salary >= 5000 AND salary <=70000
SELECT * FROM employees WHERE salary BETWEEN 5000 AND 70000
SELECT name,salary*12 AS 'Annual salary', salary FROM employees 
SELECT AVG(salary) AS 'Average salary' FROM employees
SELECT MIN(salary) AS 'Minimum salary' FROM employees
SELECT MAX(Salary) AS 'Maximum Salary' FROM employees

SELECT name, age, salary,case when salary>=80000 then 'Executive' 
						 when salary between 80000  AND 50000 then 'Manager'
					     else 'Staff' 
						 END AS 'Position'
						 FROM employees


SELECT * FROM employees WHERE name IN ('ALice', 'Bob', 'Charlie')
SELECT UPPER(name) FROM employees  


SELECT * FROM employees WHERE name LIKE '/A'
SELECT * FROM employees WHERE name LIKE '%E'

DROP TABLE employees

--------------------------------------------------------------------
--Practice for Date and Time
--------------------------------------------------------------------
CREATE TABLE Events (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    EventName NVARCHAR(100) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location NVARCHAR(100)
);
INSERT INTO Events (EventName, EventDate, Location)
VALUES
('Annual General Meeting', '2025-01-20 10:00:00', 'Conference Hall A'),
('Project Kickoff', '2025-02-01 14:30:00', 'Meeting Room 1'),
('Employee Training', '2025-03-15 09:00:00', 'Training Center'),
('Product Launch', '2025-04-10 18:00:00', 'Auditorium'),
('Board Meeting', '2025-05-05 11:00:00', 'Executive Room');
INSERT INTO Events(EventName, EventDate, Location) VALUES ('Counsling','2024-03-10 12:00:00', 'Counsling Room');

CREATE TABLE EmployeesWorkLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(100) NOT NULL,
    LogDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL
);
INSERT INTO EmployeesWorkLog (EmployeeName, LogDate, StartTime, EndTime)
VALUES
('Alice', '2025-01-15', '08:30:00', '16:30:00'),
('Bob', '2025-01-15', '09:00:00', '17:00:00'),
('Charlie', '2025-01-16', '08:45:00', '17:15:00'),
('Diana', '2025-01-16', '10:00:00', '18:30:00'),
('Eva', '2025-01-17', '08:00:00', '16:00:00');

SELECT * FROM Events
SELECT * FROM EmployeesWorkLog

--SELECT * FROM Events WHERE EventDate > Date default getdate()

-- 1. Retrieve all events scheduled after today
SELECT * FROM Events WHERE EventDate >= GETDATE()

-- 2. Find the time difference (in hours) between the start and end time for each employee log
--SELECT DATEADD(HOUR, EndTime, getdate()) FROM EmployeesWorkLog 
SELECT LogID, EmployeeName, LogDate, DATEDIFF(HOUR, StartTime, EndTime) AS 'LoggedIn Time(In Hrs)' FROM EmployeesWorkLog 

-- 3. Display event dates in 'DD-MM-YYYY' format
SELECT EventID, EventName, FORMAT(EventDate, 'dd-MM-yyyy') AS 'DMY-Format', Location FROM Events 

-- 4. Add 7 days to each event date and display the result
SELECT Eventdate, DATEADD(DAY, 7, EventDate) AS '7 Days after' FROM Events

-- 5. Find all work logs where employees worked more than 8 hours
SELECT *, DATEDIFF(HOUR, StartTime, EndTime) AS 'LoggedIn Time(In Hrs)' FROM EmployeesWorkLog WHERE DATEDIFF(HOUR, StartTime, EndTime) >= 8

-- 6. Display the current system date and time
SELECT GETDATE() AS 'Current System time and date'

-- 7. Find events happening this month
Select * FROM Events WHERE DATEPART(MONTH, EventDate) = MONTH(GETDATE())
SELECT * FROM Events WHERE MONTH(EventDate) = MONTH(GETDATE()) AND YEAR(EventDate) = YEAR(GETDATE())

-- 8. Calculate the number of days left Between each event
SELECT *,DATEDIFF(DAY, LAG(EventDate) OVER (ORDER BY EventDate),EventDate) AS 'No.of.Days till next event' FROM Events 

-- 8. Calculate the number of days left Until each event
SELECT *, DATEDIFF(DAY, GETDATE(), EventDate) FROM Events 

-- 9. Find employees who worked overtime (more than 9 hours) on any day
SELECT *, DATEDIFF(HOUR, StartTime, EndTime) AS 'Logged in for' FROM EmployeesWorkLog WHERE DATEDIFF(HOUR, StartTime, EndTime) >= 9

-- 10. Display events sorted by the most recent date first
SELECT * FROM Events ORDER BY EventDate DESC


--------------------------------------------------------------------
--Customer and Sales
--------------------------------------------------------------------

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName, City, Country) VALUES
(1, 'Alice', 'New York', 'USA'),
(2, 'Bob', 'Los Angeles', 'USA'),
(3, 'Charlie', 'New York', 'USA'),
(4, 'David', 'Chicago', 'USA'),
(5, 'Eva', 'Chicago', 'USA'),
(6, 'Frank', 'Los Angeles', 'USA'),
(7, 'Grace', 'New York', 'USA'),
(8, 'Hannah', 'Chicago', 'USA'),
(9, 'Ian', 'New York', 'USA'),
(10, 'Jack', 'Los Angeles', 'USA');

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SalesAmount DECIMAL(10,2)
);

INSERT INTO Sales (SaleID, ProductID, SalesAmount) VALUES
(1, 101, 5000.00),
(2, 102, 8000.00),
(3, 101, 3000.00),
(4, 103, 12000.00),
(5, 102, 4000.00),
(6, 103, 6000.00),
(7, 101, 2000.00),
(8, 104, 7000.00),
(9, 104, 8000.00),
(10, 105, 3000.00);

SELECT * FROM Customers;
SELECT * FROM Sales;

SELECT City, COUNT(CustomerID) AS 'Customers by CIty' 
FROM Customers 
GROUP BY City;

SELECT City, COUNT(CustomerID) 
FROM Customers 
WHERE Country = 'USA' 
GROUP BY City 
HAVING COUNT(CustomerID)>2;

SELECT ProductID, SUM(SalesAmount) AS 'Total_Sales Per PDT' 
FROM Sales 
GROUP BY ProductID 

-----------------------------------------------------------
SELECT * FROM employees
SELECT * FROM departments

SELECT department_id, AVG(salary) 
FROM employees 
GROUP BY department_id

SELECT * 
FROM employees AS emp INNER JOIN departments AS dept 
ON emp.department_ID = dept.department_ID

UPDATE employees 
SET department_id= NULL 
WHERE employee_id IN (108,109)

SELECT * 
FROM employees AS emp LEFT JOIN departments AS dept 
ON emp.department_ID = dept.department_ID

SELECT * 
FROM employees AS emp RIGHT JOIN departments AS dept 
ON emp.department_ID = dept.department_ID

SELECT emp2.name AS 'Employee', emp1.name AS 'Manager'
FROM employees AS emp1 INNER JOIN employees AS emp2
ON emp1.manager_id = emp2.employee_id;

SELECT AVG(Salary) from employees GROUP BY department_id HAVING AVG(Salary) < Salary 


--Corelated SubQuery
SELECT emp1.name, emp1.salary
FROM employees as emp1 
WHERE emp.salary > 
(SELECT AVG(emp2.salary)
FROM employees AS emp2 
WHERE emp2.department_id = emp1.department_id)

SELECT employee_id, name, age, salary, department_id, manager_id
FROM Employees AS E
WHERE E.salary > (SELECT AVG(salary) FROM Employees WHERE department_id = E.department_id);



--Common Table Expression
WITH DeptAvg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY department_id
)
SELECT E.employee_id, E.name, E.age, E.salary, E.department_id, E.manager_id
FROM Employees E
JOIN DeptAvg D
ON E.department_id = D.department_id
WHERE E.salary > D.avg_salary;



use EmployeeDB
go
CREATE PROCEDURE GetEmployeeDetails
AS
BEGIN
    SELECT employee_id, name, department_id
    FROM employees;
END;
GO
EXEC GetEmployeeDetails;
GO

CREATE PROCEDURE GetEmployeeById
    @emp_id INT
AS
BEGIN
    SELECT name, department_id, salary
    FROM employees
    WHERE employee_id = @emp_id;
END;
GO

EXEC GetEmployeeById @emp_id = 101;



CREATE PROCEDURE GetEmployeeSalary
    @emp_id INT,
    @salary DECIMAL OUTPUT
AS
BEGIN
    SELECT @salary = salary
    FROM employees
    WHERE employee_id = @emp_id;
END;
GO

DECLARE @sal DECIMAL--,@emp_id INT;
EXEC GetEmployeeSalary @emp_id = 101, @salary = @sal OUTPUT;
SELECT @sal AS EmployeeSalary;


CREATE FUNCTION CalculateBonus (@Salary DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Bonus DECIMAL(10, 2);
    
    IF @Salary < 50000
        SET @Bonus = @Salary * 0.10; -- 10% bonus for salary below 50,000
    ELSE
        SET @Bonus = @Salary * 0.05; -- 5% bonus for salary 50,000 or more
    
    RETURN @Bonus;
END;	

SELECT *,Name, Salary, dbo.CalculateBonus(Salary) AS Bonus
FROM Employees;


CREATE FUNCTION GetEmployeesByDept (@DeptID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
       *
    frOM Employees e
    WHERE e.department_id = @DeptID
);

SELECT * 
FROM dbo.GetEmployeesByDept(3);


SELECT TOP 1* 
FROM employees 
WHERE salary NOT IN (SELECT MAX(salary)FROM employees)
ORDER BY salary DESC

SELECT * 
FROM employees 
WHERE salary = (SELECT MAX(salary)FROM employees)
ORDER BY salary 


CREATE PROCEDURE Emp_manager_list
AS
BEGIN
    SELECT employee_id, name, manager_id
    FROM employees;
END;
GO
EXEC Emp_manager_list;
GO

WITH MNG AS(
SELECT employee_id,name
FROM employees 
)
SELECT e.employee_id, e.name AS 'manager',m.name AS 'employee'
FROM employees e
JOIN MNG m
ON e.manager_id=m.employee_id

SELECT * 
FROM employees