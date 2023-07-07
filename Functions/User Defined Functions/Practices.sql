-- Orders by Employee

CREATE FUNCTION OrderDetailsByEmployee(@EmployeeID INT)
RETURNS TABLE
as
RETURN
(
    SELECT P.ProductID, P.ProductName, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalPrice, SUM(OD.Quantity) as TotalQuantity, AVG(OD.Discount) as AvgDiscount, O.OrderDate
    FROM Employees as E
    JOIN Orders as O ON O.EmployeeID = E.EmployeeID
    JOIN [Order Details] as OD ON O.OrderID = OD.OrderID
    JOIN Products as P ON OD.ProductID = P.ProductID
    WHERE E.EmployeeID = @EmployeeID
    GROUP BY P.ProductID, P.ProductName, O.OrderDate
)

-- Test
SELECT * FROM OrderDetailsByEmployee(5)


-- Product Name and Product Price by Employee
-- If ID <= 0 returns ID = 0, ProductName = Invalid Employee ID, TotalPrice = 0

CREATE FUNCTION ProductDetailsByEmployee(@EmployeeID INT)
RETURNS @ProductsByEmployee TABLE
(
    ID INT,
    ProductName NVARCHAR(50),
    TotalPrice MONEY
)
as
BEGIN
    IF @EmployeeID > 0
        BEGIN
            INSERT INTO @ProductsByEmployee (ID, ProductName, TotalPrice)
            SELECT P.ProductID, P.ProductName, SUM(OD.UnitPrice * OD.Quantity) as TotalPrice
            FROM Employees as E
            JOIN Orders as O ON E.EmployeeID = O.EmployeeID
            JOIN [Order Details] as OD ON OD.OrderID = O.OrderID
            JOIN Products as P ON P.ProductID = OD.ProductID
            WHERE E.EmployeeID = @EmployeeID
            GROUP BY P.ProductID, P.ProductName
        END
    ELSE
        BEGIN
            INSERT INTO @ProductsByEmployee (ID, ProductName, TotalPrice)
            VALUES (0, 'Invalid Employee ID', 0)
        END

    RETURN
END

-- Test
SELECT * FROM ProductDetailsByEmployee(0)
