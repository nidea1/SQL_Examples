-- CREATE INDEX

-- Syntax

CREATE INDEX index_name
ON table_name (column1, column2, ...);

-- Example

CREATE INDEX idx_Orders_CustomerID
ON Orders (CustomerID);

-- Now we can do faster queries by CustomerID

SELECT OrderID, OrderDate
FROM Orders
WHERE CustomerID = 'ALFKI';


-- DROP INDEX

-- Syntax

DROP INDEX table_name.index_name;

-- Example

DROP INDEX Orders.idx_Orders_CustomerID;
