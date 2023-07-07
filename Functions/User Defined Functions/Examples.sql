-- Scalar Function -> returns one value

-- Example

CREATE FUNCTION AverageProductPrice()
RETURNS money
as
BEGIN
    RETURN (SELECT AVG(UnitPrice) FROM Products)
END

-- Test

SELECT dbo.AverageProductPrice() AS AveragePrice


-- Table-Valued Function -> returns table

-- Example

CREATE FUNCTION OrdersByCity(@city nvarchar(15))
RETURNS TABLE
as
RETURN
(
    SELECT Orders.OrderID, Customers.CompanyName, Customers.ContactName
    FROM Orders
    JOIN Customers ON Orders.CustomerID = Customers.CustomerID
    WHERE Customers.City = @city
)

-- Test

SELECT * FROM dbo.OrdersByCity('London')


-- Multi-Statement Table-Valued -> returns multi statement table

-- Example

CREATE FUNCTION OrderDetailsByProduct(@ProductID int)
RETURNS @orderDetails TABLE 
(
   OrderID int,
   ProductID int,
   UnitPrice money,
   Quantity smallint,
   Discount real
)
as
BEGIN
   INSERT INTO @orderDetails
   SELECT OrderID, ProductID, UnitPrice, Quantity, Discount
   FROM [Order Details]
   WHERE ProductID = @ProductID

   RETURN
END

-- Test

SELECT * FROM dbo.OrderDetailsByProduct(1)
