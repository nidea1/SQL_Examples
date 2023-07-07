-- Examples

-- COUNT
SELECT COUNT(*) FROM Products;

-- SUM
SELECT SUM(UnitPrice) FROM Products;

-- AVG
SELECT AVG(UnitPrice) FROM Products;

-- MAX MIN
SELECT MAX(UnitPrice), MIN(UnitPrice) FROM Products;

-- UCASE LCOSE
SELECT UCASE(ProductName), LCASE(ProductName) FROM Products; --> Output -> TEST, test

-- SUBSTRING
SELECT SUBSTRING(ProductName, 1, 5) FROM Products; --> Output -> Alice Mutton to Alice

-- ROUND
SELECT ROUND(UnitPrice, 2) FROM Products; --> Output -> 21.35 to 21.40

-- GETDATE
SELECT OrderID, GETDATE() as CurrentDateTime FROM Orders;

-- DATEDIFF
SELECT OrderID, DATEDIFF(day, OrderDate, GETDATE()) as DaysFromOrderToNow FROM Orders;


-- RANK ROWNUMBER

SELECT 
    OrderID, 
    CustomerID, 
    OrderDate,
    RANK() OVER(ORDER BY OrderDate) as Rank,
    ROW_NUMBER() OVER(ORDER BY OrderDate) as RowNumber
FROM Orders;

-- OUTPUT
-- OrderID  CustomerID  OrderDATE               Rank    RowNumber
-- 10248	VINET	    1996-07-04 00:00:00.000	1	    1


-- LAG

SELECT 
    OrderID, 
    CustomerID, 
    OrderDate,
    LAG(OrderDate) OVER(ORDER BY OrderDate) as PreviousOrderDate
FROM Orders;

-- OUTPUT
-- OrderID  CustomerID  OrderDATE                   PreviousOrderDate
-- 10248	VINET	    1996-07-04 00:00:00.000	    NULL
-- 10249	TOMSP	    1996-07-05 00:00:00.000	    1996-07-04 00:00:00.000
