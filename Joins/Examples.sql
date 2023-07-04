
-- INNER JOIN syntax and example

SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

-- Example

SELECT Orders.OrderID, Customers.ContactName, Orders.OrderDate
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

-- This query retrieves Order ID, Customer's contact name and Order Date by matching CustomerID in Orders and Customers tables.

-- Order ID     ContactName     Phone           OrderDate
-- 10249	    Karin Josephs	0251-031259	    1996-07-05 00:00:00.000

-- Example with 3 tables

SELECT Orders.OrderID, Customers.ContactName, [Orders Details].ProductID, Orders.OrderDate
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID);

-- This query retrieves Order ID, Customer's contact name, Order Product ID and Order Date by matching CustomerID in Orders and Customer tables and matching OrderID in Orders and Order Details tables.

-- Order ID     ContactName     ProductID           OrderDate
-- 10294	    Paula Wilson	1	                1996-08-30 00:00:00.000


-- LEFT JOIN syntax and example

SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;

-- Example

SELECT Orders.OrderID, Customers.ContactName
FROM Orders
LEFT JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
ORDER BY Customers.ContactName;

-- This query retrieves all Order ID and their corresponding Customer's contact name including orders with no associated customer.

-- Order ID     ContactName
-- 10281	    Alejandra Camino


-- RIGHT JOIN syntax and example

SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;

-- Example

SELECT Orders.OrderID, Customers.CompanyName
FROM Orders
RIGHT JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

-- This query retrieves all Company Name and their corresponding Order IDs including customers with no associated orders.

-- Order ID     CompanyName
-- 10643	    Alfreds Futterkiste


-- FULL OUTER JOIN syntax and example

SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name = table2.column_name;

-- Example

SELECT Orders.OrderID, Customers.CompanyName, Customers.ContactName
FROM Orders
FULL OUTER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
ORDER BY Customers.ContactName;

-- This query retrieves all Order IDs, Customer Company Names and Contact Names including orders with no associated customer and customers with no associated orders.

-- Order ID     CompanyName         ContactName
-- 10281	    Romero y tomillo	Alejandra Camino


-- SELF JOIN syntax and example

SELECT column_name(s)
FROM table1 AS t1
JOIN table1 AS t2
ON t1.column_name = t2.column_name;

-- Example (this example has done without db sample)

SELECT e1.name as employee, e2.name as manager
FROM Employees as e1
INNER JOIN Employees as e2
ON e1.ManagerID = e2.EmployeeID;

-- This query retrieves Employee names and their corresponding manager names by joining the employees table with itself.

-- employee         manager
-- Ali Mehmet       Doruk Çoralı


-- CROSS JOIN syntax and example

SELECT column_name(s)
FROM table1
CROSS JOIN table2;

-- Example

SELECT Products.ProductID, Products.ProductName, Categories.CategoryID, Categories.CategoryName
FROM Products
CROSS JOIN Categories;

-- This query retrieves all possible combinations of products IDs and names and categories IDs and names.

-- ProductID    ProductName     CategoryID      CategoryName
-- 1	        Chai	        1	            Beverages
