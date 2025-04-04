1		--  Create Database
CREATE DATABASE SchoolDB;

--  Use the Database
USE SchoolDB;

-- Create Department Table First
CREATE TABLE Department (
    SubjectID INT PRIMARY KEY, 
    SubjectName VARCHAR(30) NOT NULL
);

-- Create Teachers Table with Foreign Key
CREATE TABLE Teachers (
    TeacherID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    SubjectID INT,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Salary DECIMAL(10,2),
    FOREIGN KEY (SubjectID) REFERENCES Department(SubjectID)  -- Moved to a separate line
);

-- Altering Existing Column by it's Size and Datatype
ALTER TABLE Teachers ALTER COLUMN Phone VARCHAR(25);
ALTER TABLE Teachers ALTER COLUMN Salary FLOAT;

--Date functions
ALTER TABLE Teachers ADD DOJ DATE DEFAULT getdate();

--  Insert Data into Department Table
INSERT INTO Department (SubjectID, SubjectName)
VALUES
    (1, 'Mathematics'),
    (2, 'Science'),
    (3, 'English'),
    (4, 'Social Studies');  

--  Insert Data into Teachers Table
INSERT INTO Teachers (Name, SubjectID, Email, Phone, Salary)
VALUES 
    ('John Doe', 1, 'johndoe@example.com', '9876543210', 50000.00),
    ('Jack', 2, 'jack@example.com', '9567893056', 60000.00),
    ('Bob', 3, 'bob@example.com', '8976543210', 55000.00),
    ('Stuvert', 4, 'stuvert@example.com', '8573543210', 45000.00);

INSERT INTO Teachers (Name, SubjectID, Email, Phone, Salary)
VALUES 
    ('Doe', 1, 'doe@example.com', '7686543210', 20000.00),
    ('Sandy', 2, 'sandy@example.com', '8674893056', 54000.00),
    ('Sanjay', 3, 'sanjay@example.com', '6479543210', 88000.00);

-- Step 7: Verify the Data
SELECT * FROM Teachers;

/*USE master;  
ALTER DATABASE SchoolDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE IF EXISTS SchoolDB;

SELECT name FROM sys.databases;*/

