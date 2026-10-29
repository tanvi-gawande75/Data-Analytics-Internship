CREATE DATABASE Day8_SQL_Fundamentals;


--  Tables, Rows, Columns, and Primary Keys

-- 1. Table:
-- A table is a collection of related data organized into rows and columns.
-- Example: Customers table stores customer information.

-- 2. Row:
-- A row represents one complete record in a table.
-- Example: One customer's details.

-- 3. Column:
-- A column represents a specific attribute of the data.
-- Example: Customer_Name, City, or Age.

-- 4. Primary Key:
-- A primary key is a column or combination of columns that uniquely identifies each record.
-- It cannot contain duplicate or NULL values.
-- Example: Customer_ID.


--  Basic SQL Commands

-- 1. SELECT:
-- SELECT is used to retrieve specific columns or all columns from a table.
-- Example: SELECT Customer_Name FROM Customers;

-- 2. WHERE:
-- WHERE is used to filter records based on a specified condition.
-- Example: SELECT * FROM Customers WHERE City = 'Nagpur';

-- 3. ORDER BY:
-- ORDER BY is used to sort records in ascending (ASC) or descending (DESC) order.
-- Example: SELECT * FROM Customers ORDER BY Customer_Name ASC;

-- 4. DISTINCT:
-- DISTINCT is used to retrieve only unique values and remove duplicates
-- from the query result.
-- Example: SELECT DISTINCT City FROM Customers;



--  Aliases and Filtering Conditions

-- 1. Alias:
-- An alias is a temporary name given to a column or table
-- to make query results easier to understand.
-- Example: SELECT Customer_Name AS Name FROM Customers;

-- 2. Filtering Conditions:
-- Filtering conditions are used with WHERE to retrieve records
-- that satisfy specific requirements.

-- 3. Comparison Operators:
-- These operators compare values.
-- Examples: =, >, <, >=, <=, <>

-- 4. Logical Operators:
-- These operators combine or reverse conditions.
-- AND: Both conditions must be true.
-- OR: At least one condition must be true.
-- NOT: Reverses a condition.

-- 5. BETWEEN:
-- BETWEEN filters values within a specified range.
-- Example: WHERE Amount BETWEEN 100 AND 500;

-- 6. IN:
-- IN filters records matching any value in a given list.
-- Example: WHERE City IN ('Nagpur', 'Mumbai');

-- 7. LIKE:
-- LIKE searches for a specified text pattern.
-- Example: WHERE Customer_Name LIKE 'A%';


--  Checking for NULL Values

-- 1. NULL:
-- NULL represents a missing, unknown, or unavailable value.
-- It is different from zero or an empty string.

-- 2. IS NULL:
-- IS NULL is used to find records where a column has NULL values.
-- Example: SELECT * FROM Customers WHERE Email IS NULL;

-- 3. IS NOT NULL:
-- IS NOT NULL is used to find records where a column has a value.
-- Example: SELECT * FROM Customers WHERE Email IS NOT NULL;

-- We should not use = NULL or <> NULL to check NULL values.
-- Use IS NULL or IS NOT NULL instead.


USE Day8_SQL_Fundamentals;
GO



--  Customer, Product, and Sales Records

--  Customers table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(30),
    Email VARCHAR(100)
);

-- Insert customer records
INSERT INTO Customers VALUES
(1, 'Asha', 'Nagpur', 'asha@gmail.com'),
(2, 'Rahul', 'Mumbai', NULL),
(3, 'Priya', 'Pune', 'priya@gmail.com'),
(4, 'Amit', 'Nagpur', 'amit@gmail.com');

select * from Customers;

--  Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2)
);

-- Insert product records
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mouse', 'Accessories', 500),
(103, 'Keyboard', 'Accessories', 1000),
(104, 'Monitor', 'Electronics', 12000);

select * from Products;


--  Sales table
CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT,
    Total_Amount DECIMAL(10,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Insert sales records
INSERT INTO Sales VALUES
(1001, 1, 101, 1, 50000),
(1002, 2, 102, 2, 1000),
(1003, 3, 104, 1, 12000),
(1004, 1, 103, 2, 2000),
(1005, 4, 102, 3, 1500);

select * from Sales;


-- Retrieve all customer records
SELECT * FROM Customers;

-- Retrieve customers from Nagpur
SELECT * FROM Customers
WHERE City = 'Nagpur';

--  Retrieve customer names with aliases
SELECT Customer_Name AS Name, City AS Location
FROM Customers;

-- Retrieve customers whose email is missing
SELECT * FROM Customers
WHERE Email IS NULL;

-- Retrieve all products costing more than 1000
SELECT * FROM Products
WHERE Price > 1000;

--  Retrieve unique product categories
SELECT DISTINCT Category
FROM Products;

--  Retrieve products from lowest to highest price
SELECT * FROM Products
ORDER BY Price ASC;

--  Retrieve sales with a total amount of at least 2000
SELECT * FROM Sales
WHERE Total_Amount >= 2000;

-- Retrieve sales made by customer 1
SELECT * FROM Sales
WHERE Customer_ID = 1;

--  Retrieve sales with customer and product names
SELECT
    Sales.Sale_ID,
    Customers.Customer_Name,
    Products.Product_Name,
    Sales.Quantity,
    Sales.Total_Amount
FROM Sales
INNER JOIN Customers
    ON Sales.Customer_ID = Customers.Customer_ID
INNER JOIN Products
    ON Sales.Product_ID = Products.Product_ID;


