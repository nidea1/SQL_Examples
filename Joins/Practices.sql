-- Which Supplier solding which products?

SELECT Suppliers.SupplierID, Suppliers.CompanyName, Products.ProductID, Products.ProductName
FROM Suppliers
JOIN Products ON Suppliers.SupplierID = Products.SupplierID
WHERE Suppliers.SupplierID = 1;


-- Customers who did not ordered

SELECT Orders.OrderID, Customers.ContactName
FROM Customers
LEFT JOIN Orders ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderID IS NULL;


-- My sellings by products.

SELECT P.ProductName as [Product Name],
	sum(O.Quantity) as Unit,
	sum(O.UnitPrice) as [Unit Price],
	sum(O.Discount) as Discount,
	sum(O.Quantity * (O.UnitPrice * (1 - O.Discount))) as Profit
FROM Products as P
JOIN [Order Details] as O ON O.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY 1;


-- My sellings by categories.

SELECT C.CategoryName as [Category Name],
	sum(O.Quantity) as Unit,
	sum(O.UnitPrice) as [Unit Price],
	sum(O.Discount) as Discount,
	sum(O.Quantity * (O.UnitPrice * (1 - O.Discount))) as Profit
FROM Categories as C
JOIN Products as P ON P.CategoryID = C.CategoryID
JOIN [Order Details] as O ON O.ProductID = P.ProductID
GROUP BY C.CategoryName
ORDER BY 1;


-- Total freights by ship company.

SELECT S.CompanyName as Shipper,
	sum(O.Freight) as Freight
FROM Shippers as S
JOIN Orders as O ON S.ShipperID = O.ShipVia
GROUP BY S.CompanyName;


-- Best customer

SELECT TOP 1 C.CustomerID as Customer,
	sum(OD.Quantity * (OD.UnitPrice * (1 - OD.Discount))) as Total
FROM Customers as C
JOIN Orders as O ON C.CustomerID = O.CustomerID
JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID
ORDER BY Total DESC;


-- Total product selling by supplier company

SELECT S.CompanyName as Supplier,
	P.ProductName as Product,
	sum(OD.Quantity) as [Total Quantity]
FROM Suppliers as S
JOIN Products as P ON S.SupplierID = P.SupplierID
JOIN [Order Details] as OD ON P.ProductID = OD.ProductID
GROUP BY S.CompanyName, P.ProductName
ORDER BY 3 DESC;

-- Order
-- Customer
-- Employee
-- Date
-- Shipper
-- Price
-- Product's category
-- Product's supplier

SELECT O.OrderID,
	C.CompanyName as Customer,
	E.FirstName+ ' '+ E.LastName as [Employee Name],
	O.OrderDate as [Date],
	S.CompanyName as [Shipper],
	OD.Quantity as Quantity,
	OD.UnitPrice as [Unit Price],
	OD.Discount as Discount,
	sum(OD.Quantity * (OD.UnitPrice * ( 1 - OD.Discount ))) as Total,
	Cat.CategoryName as Category,
	Sup.CompanyName as Supplier
FROM Orders as O
	JOIN Customers as C ON O.CustomerID = C.CustomerID
	JOIN Employees as E ON O.EmployeeID = E.EmployeeID
	JOIN Shippers as S ON O.ShipVia = S.ShipperID
	JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
	JOIN Products as P ON OD.ProductID = P.ProductID
	JOIN Categories as Cat ON P.CategoryID = Cat.CategoryID
	JOIN Suppliers as Sup ON P.SupplierID = Sup.SupplierID
GROUP BY
	O.OrderID,
	C.CompanyName,
	E.FirstName,
	E.LastName,
	O.OrderDate,
	S.CompanyName,
	OD.Quantity,
	OD.UnitPrice,
	OD.Discount,
	Cat.CategoryName,
	Sup.CompanyName
ORDER BY
	O.OrderID;
