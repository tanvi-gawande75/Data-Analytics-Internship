CREATE DATABASE Day9_SQL_Joins_Aggregations;


--  SQL JOINS AND AGGREGATIONS

-- 1. INNER JOIN:
-- INNER JOIN combines rows from two tables when their
-- matching values satisfy the join condition.

-- 2. LEFT JOIN:
-- LEFT JOIN returns all rows from the left table and
-- matching rows from the right table.
-- If no match exists, right-table columns contain NULL.

-- 3. GROUP BY:
-- GROUP BY groups rows that have the same values
-- so aggregate calculations can be performed for each group.

-- 4. HAVING:
-- HAVING filters groups after GROUP BY,
-- usually based on aggregate conditions.

-- 5. Aggregate Functions:
-- COUNT(): Counts rows or non-NULL values.
-- SUM(): Calculates the total of numeric values.
-- AVG(): Calculates the average of numeric values.
-- MIN(): Returns the minimum value.
-- MAX(): Returns the maximum value.

-- 6. CASE WHEN:
-- CASE WHEN applies conditional logic and returns
-- a result based on which condition is satisfied.

-- 7. Subquery:
-- A subquery is a query written inside another SQL query.

-- 8. Common Table Expression (CTE):
-- A CTE is a temporary named result set defined using WITH
-- and used within a single SQL statement.

USE Day9_SQL_Joins_Aggregations;
GO



-- 1. Customers Table
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(30)
);

-- 2. Products Table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2)
);

-- 3. Sales Table
CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT,
    Sales_Date DATE,
    Total_Amount DECIMAL(10,2),

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID),

    FOREIGN KEY (Product_ID)
        REFERENCES Products(Product_ID)
);




-- Insert Customers
INSERT INTO Customers (Customer_ID, Customer_Name, City)
VALUES
(1, 'Asha', 'Nagpur'),
(2, 'Rahul', 'Mumbai'),
(3, 'Priya', 'Pune'),
(4, 'Amit', 'Nagpur'),
(5, 'Neha', 'Nashik');

select * from Customers;

-- Insert Products
INSERT INTO Products (Product_ID, Product_Name, Category, Price)
VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mouse', 'Accessories', 500),
(103, 'Keyboard', 'Accessories', 1000),
(104, 'Monitor', 'Electronics', 12000),
(105, 'Headphones', 'Accessories', 2000);

select * from Products;

-- Insert Sales
INSERT INTO Sales
(Sale_ID, Customer_ID, Product_ID, Quantity, Sales_Date, Total_Amount)
VALUES
(1001, 1, 101, 1, '2026-01-15', 50000),
(1002, 2, 102, 2, '2026-01-20', 1000),
(1003, 3, 104, 1, '2026-02-10', 12000),
(1004, 1, 103, 2, '2026-02-18', 2000),
(1005, 4, 102, 3, '2026-03-05', 1500),
(1006, 2, 105, 1, '2026-03-12', 2000),
(1007, 3, 101, 1, '2026-03-20', 50000),
(1008, 1, 104, 2, '2026-04-08', 24000),
(1009, 4, 103, 1, '2026-04-15', 1000);

select * from Sales;

--  INNER JOIN
-- Display customers who have matching sales records.

SELECT
    Customers.Customer_Name,
    Sales.Sale_ID,
    Sales.Total_Amount
FROM Customers
INNER JOIN Sales
    ON Customers.Customer_ID = Sales.Customer_ID;

--  LEFT JOIN
-- Display all customers, including customers without sales.

SELECT
    Customers.Customer_Name,
    Sales.Sale_ID,
    Sales.Total_Amount
FROM Customers
LEFT JOIN Sales
    ON Customers.Customer_ID = Sales.Customer_ID;




--  GROUP BY
-- Calculate total sales for each customer.

SELECT
    Customers.Customer_Name,
    SUM(Sales.Total_Amount) AS Total_Sales
FROM Customers
INNER JOIN Sales
    ON Customers.Customer_ID = Sales.Customer_ID
GROUP BY
    Customers.Customer_ID,
    Customers.Customer_Name;


-- HAVING
-- Display customers whose total sales exceed 10000.

SELECT
    Customers.Customer_Name,
    SUM(Sales.Total_Amount) AS Total_Sales
FROM Customers
INNER JOIN Sales
    ON Customers.Customer_ID = Sales.Customer_ID
GROUP BY
    Customers.Customer_ID,
    Customers.Customer_Name
HAVING SUM(Sales.Total_Amount) > 10000;



--  AGGREGATE FUNCTIONS

-- 1. COUNT(): Counts the number of records.
SELECT COUNT(*) AS Total_Sales_Records
FROM Sales;

-- 2. SUM(): Calculates the total sales amount.
SELECT SUM(Total_Amount) AS Total_Sales
FROM Sales;

-- 3. AVG(): Calculates the average sales amount.
SELECT AVG(Total_Amount) AS Average_Sale
FROM Sales;

-- 4. MIN(): Finds the minimum sales amount.
SELECT MIN(Total_Amount) AS Minimum_Sale
FROM Sales;

-- 5. MAX(): Finds the maximum sales amount.
SELECT MAX(Total_Amount) AS Maximum_Sale
FROM Sales;



--  CASE WHEN
-- Classify sales based on the total amount.

SELECT
    Sale_ID,
    Total_Amount,
    CASE
        WHEN Total_Amount >= 20000 THEN 'High Sales'
        WHEN Total_Amount >= 5000 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS Sales_Category
FROM Sales;


--  SUBQUERY
-- Retrieve sales amounts greater than the average sales amount.

SELECT Sale_ID, Total_Amount
FROM Sales
WHERE Total_Amount > (
    SELECT AVG(Total_Amount)
    FROM Sales
);


-- Calculate total sales by product.

SELECT
    Products.Product_Name,
    SUM(Sales.Total_Amount) AS Total_Sales
FROM Products
INNER JOIN Sales
    ON Products.Product_ID = Sales.Product_ID
GROUP BY
    Products.Product_ID,
    Products.Product_Name
ORDER BY Total_Sales DESC;



--  Calculate total sales by customer.

SELECT
    Customers.Customer_Name,
    SUM(Sales.Total_Amount) AS Total_Sales
FROM Customers
INNER JOIN Sales
    ON Customers.Customer_ID = Sales.Customer_ID
GROUP BY
    Customers.Customer_ID,
    Customers.Customer_Name
ORDER BY Total_Sales DESC;



-- Calculate total sales by month.

SELECT
    YEAR(Sales_Date) AS Sales_Year,
    MONTH(Sales_Date) AS Sales_Month,
    SUM(Total_Amount) AS Total_Sales
FROM Sales
GROUP BY
    YEAR(Sales_Date),
    MONTH(Sales_Date)
ORDER BY
    Sales_Year,
    Sales_Month;

