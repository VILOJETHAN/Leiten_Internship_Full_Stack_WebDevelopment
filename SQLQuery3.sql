-- Creating Sample Tables
CREATE DATABASE EMPDBASE
GO
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    HireDate DATE
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Inserting Sample Data
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'HR'),
(102, 'Finance'),
(103, 'IT'),
(104, 'Sales');

INSERT INTO Employees (EmployeeID, Name, Age, Salary, DepartmentID, HireDate) VALUES
(1, 'Alice', 30, 60000, 101, '2022-01-15'),
(2, 'Bob', 40, 75000, 102, '2020-05-20'),
(3, 'Charlie', 28, 50000, 103, '2023-03-10'),
(4, 'David', 35, 90000, 104, '2019-08-25'),
(5, 'Eve', 32, 48000, 101, '2021-06-30');

ALTER TABLE employees ADD Date_of_Joining DATE DEFAULT getdate()

UPDATE employees SET Date_of_Joining='2024-07-12' WHERE name='Alice'
UPDATE employees SET Date_of_Joining='2024-08-01' WHERE name='Bob'
UPDATE employees SET Date_of_Joining='2024-07-26' WHERE name='Charlie'
UPDATE employees SET Date_of_Joining='2024-10-10' WHERE name='Diana'
UPDATE employees SET Date_of_Joining='2024-10-23' WHERE name='Eva'
UPDATE employees SET Date_of_Joining='2024-11-20' WHERE name='Frank'
UPDATE employees SET Date_of_Joining='2024-09-18' WHERE name='Grace'
UPDATE employees SET Date_of_Joining='2024-09-02' WHERE name='Henry'

WITH MNG AS(
SELECT employee_id,name
FROM employees 
)
SELECT e.employee_id, e.name AS 'manager',m.name AS 'employee'
FROM employees e
JOIN MNG m
ON e.manager_id=m.employee_id



-- 1. Retrieve All Employees
SELECT * 
FROM employees

-- 2. Retrieve Employee Names and Salaries
SELECT name, Salary 
FROM Employees

-- 3. Retrieve Unique Department IDs
SELECT DISTINCT department_id
FROM Employees 

-- 4. Employees Earning More Than 50,000
SELECT * 
FROM Employees 
WHERE Salary>=50000

-- 5. Employees in Department 101 Earning More Than 40,000
SELECT * 
FROM  Employees 
WHERE department_id=101 AND Salary>=40000

-- 6. Employees Ordered by Salary Descending
SELECT * 
FROM Employees 
ORDER BY Salary DESC

-- 7. Top 5 Highest Paid Employees
SELECT TOP 5* FROM Employees ORDER BY Salary DESC

-- 8. Total Employees in Each Department
SELECT department_id, COUNT(*) AS 'Employee_Count'
FROM employees GROUP BY department_id

-- 9. Average Salary Per Department (Only for Departments with >5 Employees)
SELECT department_id, AVG(Salary) AS 'Avg_Salary/Dept'
FROM Employees
GROUP BY department_id


-- 10. Employees with Their Department Names
SELECT emp.name, dept.department_name
FROM Employees AS emp INNER JOIN Departments AS dept
ON emp.department_id = dept.department_id

-- 11. Employees Without Departments                    
SELECT * FROM employees WHERE department_id IS NULL

-- 12. Departments with Employees
SELECT D.department_id, D.department_name, COUNT(E.employee_id) AS EmployeeCount
FROM Departments D
LEFT JOIN Employees E ON D.department_id = E.department_id
GROUP BY D.department_id, D.department_name;

-- 13. Employees Earning More Than the Company’s Average Salary 
SELECT *
FROM employees 
WHERE salary>(SELECT AVG(salary) 
              FROM employees)

-- 14. Employees in Departments with Average Salary > 60,000
SELECT department_id, AVG(salary) AS 'Average salary of Dept'
FROM Employees 
GROUP BY department_id HAVING AVG(Salary)>=60000

-- 15. Using CTE: Employees Earning Above Their Department’s Average Salary
WITH DeptAvg AS (
    SELECT department_id, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY department_id
)
SELECT E.*
FROM Employees E
JOIN DeptAvg D ON E.department_id = D.department_id
WHERE E.Salary > D.AvgSalary;

-- 16. Assign Rank to Employees Based on Salary in Each Department   
SELECT employee_id, Name, department_id, Salary,
       RANK() OVER (PARTITION BY department_id ORDER BY Salary DESC) AS SalaryRank
FROM Employees;


-- 17. Top 2 Highest Paid Employees Per Department

SELECT employee_id, Name, department_id, Salary
FROM (
    SELECT employee_id, Name, department_id, Salary,
           DENSE_RANK() OVER (PARTITION BY department_id ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) Ranked
WHERE SalaryRank <= 2;

-- 17. Top 2 Highest Paid Employees Per Department(METHOD 2 USING SUBQUERY)

SELECT emp1.name, emp1.department_id, emp1.salary
FROM employees emp1 
WHERE
(SELECT COUNT(*)
FROM employees emp2
WHERE emp2.department_id = emp1.department_id
AND emp2.salary > emp1.salary)<2


-- 18. Employees Hired in the Last 1 Year
SELECT * FROM Employees WHERE Date_of_Joining >= DATEADD(YEAR, -1, GETDATE());

-- 19. Orders Per Month (Assuming Orders Table Exists)            -----------------------------------------------
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear DESC, OrderMonth DESC;

-- 20. Employees Whose Names Start With "A"
SELECT * FROM Employees 
WHERE name LIKE '/A'

-- 21. Convert All Employee Names to Uppercase
SELECT UPPER(name) AS 'name'
FROM Employees 
 
-- 22. Categorizing Employees Based on Salary
SELECT name, salary, CASE WHEN salary<40000 THEN 'Staff'
                          WHEN salary<80000 AND salary>=40000 THEN 'Manager'
						  ELSE 'Executive'
						  END AS 'EMp_Category'
FROM employees

SELECT * FROM employees