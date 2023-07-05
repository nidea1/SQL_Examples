-- Creating Views

-- We can can create View using CREATE VIEW statement. A View can be created from a single table or multiple tables.
-- Syntax

CREATE VIEW view_name
as
SELECT column1, column2...
FROM table1...
WHERE condition;

--view_name: Name for the View
--table_name: Name of the table
--condition: Condition to select rows

-- Example

CREATE VIEW ExampleOrderDetail
as
SELECT O.OrderID,
	C.CompanyName as Customer,
	P.ProductName as Product,
	sum(OD.Quantity) as Qty,
	sum(OD.Quantity * (OD.UnitPrice * (1 - OD.Discount))) as Price,
	O.ShipAddress as [Address Detail],
	O.ShipCity + '/' + O.ShipCountry as [Address],
	O.OrderDate as [Date]
FROM Customers as C
JOIN Orders as O ON C.CustomerID = O.CustomerID
JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
JOIN Products as P ON OD.ProductID = P.ProductID
GROUP BY C.CompanyName,
	O.OrderID,
	P.ProductName,
	O.ShipAddress,
	O.ShipCity,
	O.ShipCountry,
	O.OrderDate;


-- Reading Views

-- We can list a view with the same statement as the real table.
-- Syntax

SELECT column1, column2...
FROM view_name
WHERE condition;

-- Example

SELECT OrderID,
    Product
FROM ExampleOrderDetail;


-- Updating Views

-- We can update a view using ALTER VIEW statement.
-- Syntax

ALTER VIEW view_name
as
SELECT column1, column2...
FROM table1...
WHERE condition;

-- Example

ALTER VIEW ExampleOrderDetail
as
SELECT O.OrderID,
	C.CompanyName as Customer,
	P.ProductName as Product,
	sum(OD.Quantity) as Qty,
	sum(OD.UnitPrice) as [Unit Price], --> Added this column
	sum(OD.Quantity * (OD.UnitPrice * (1 - OD.Discount))) as Price,
	O.ShipAddress as [Address Detail],
	O.ShipCity + '/' + O.ShipCountry as [Address],
	O.OrderDate as [Date]
FROM Customers as C
JOIN Orders as O ON C.CustomerID = O.CustomerID
JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
JOIN Products as P ON OD.ProductID = P.ProductID
GROUP BY C.CompanyName,
	O.OrderID,
	P.ProductName,
	O.ShipAddress,
	O.ShipCity,
	O.ShipCountry,
	O.OrderDate;


-- Deleting Views

-- We can delete a view using DROP VIEW statement.
-- Syntax

DROP VIEW view_name;

-- Example

DROP VIEW ExampleOrderDetail;


-- Encrypted Views

-- We can create a encrypted view with the same statement as the create view but we must add WITH ENCRYPTION statement before the AS.
-- Now we can not use design in the encrypted view but we can update with ALTER statement and delete with DROP statement the view.

-- Syntax

CREATE VIEW view_name
WITH ENCRYPTION
as
SELECT column1, column2...
FROM table1...
WHERE condition;

-- Example

CREATE VIEW ExampleOrderDetail
WITH ENCRYPTION
AS
SELECT O.OrderID,
	C.CompanyName as Customer,
	P.ProductName as Product,
	sum(OD.Quantity) as Qty,
	sum(OD.UnitPrice) as [Unit Price],
	sum(OD.Quantity * (OD.UnitPrice * (1 - OD.Discount))) as Price,
	O.ShipAddress as [Address Detail],
	O.ShipCity + '/' + O.ShipCountry as [Address],
	O.OrderDate as [Date]
FROM Customers as C
JOIN Orders as O ON C.CustomerID = O.CustomerID
JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
JOIN Products as P ON OD.ProductID = P.ProductID
GROUP BY C.CompanyName,
	O.OrderID,
	P.ProductName,
	O.ShipAddress,
	O.ShipCity,
	O.ShipCountry,
	O.OrderDate;
