-- DML Triggers
-- CREATE TRIGGER
--Syntax

CREATE TRIGGER trigger_name
ON table_name
{FOR | AFTER | INSTEAD OF} {[INSERT] [,] [UPDATE] [,] [DELETE]}
AS
{sql_statements}

-- Example 1

CREATE TRIGGER NewOrderTrigger
ON Orders
AFTER INSERT
as
BEGIN
	PRINT 'A new order has been placed.';	
END;

-- Users when add a data to the orders will see print message


-- Example 2

-- Procedure
CREATE PROCEDURE GetProductByID
(
    @ProductID INT
)
as
BEGIN
    SELECT ProductID,
        ProductName,
        UnitsInStock
    FROM Products
    WHERE ProductID = @ProductID
END;

CREATE PROCEDURE DecraseStock
(
    @ProductID INT,
    @Quantity INT
)
as
BEGIN
    UPDATE Products
    SET UnitsInStock = UnitsInStock - @Quantity
    WHERE ProductID = @ProductID
END;

-- Trigger
CREATE TRIGGER UpdateStock
ON [Order Details]
AFTER INSERT
as
BEGIN
    DECLARE @Product INT
    DECLARE @Qty INT

    SELECT @Product = ProductID,
        @Qty = Quantity
    FROM INSERTED;

    EXEC DecraseStock
    @ProductID = @Product,
    @Quantity = @Qty

    EXEC GetProductByID
    @ProductID = @Product
END;

-- Test
INSERT INTO [Order Details]
(
	OrderID,
	ProductID,
	Quantity,
	UnitPrice
)
VALUES
(
	10501,
	2,
	1,
	5
)


-- ALTER TRIGGER
-- Syntax

ALTER TRIGGER trigger_name
ON table_name
{FOR | AFTER | INSTEAD OF} {[INSERT] [,] [UPDATE] [,] [DELETE]}
AS
{sql_statements}

-- Example
ALTER TRIGGER UpdateStock
ON [Order Details]
AFTER INSERT
as
BEGIN
    DECLARE @Product INT
    DECLARE @Qty INT

    SELECT @Product = ProductID,
        @Qty = Quantity
    FROM INSERTED;

    EXEC DecraseStock
    @ProductID = @Product,
    @Quantity = @Qty
END;


-- Now lets update the UpdateStock to more complex

-- 1 more procedure
CREATE PROCEDURE IncreaseStock
(
    @ProductID INT,
    @Quantity INT
)
as
BEGIN
    UPDATE Products
    SET UnitsInStock = UnitsInStock + @Quantity
    WHERE ProductID = @ProductID
END;

-- Now updating our trigger to insert and delete events cause actived the trigger

ALTER TRIGGER UpdateStock
ON [Order Details]
FOR INSERT, DELETE
as
BEGIN
    DECLARE @insertedProduct INT, @insertedQty INT, @deletedProduct INT, @deletedQty INT

    SELECT @insertedProduct = ProductID,
        @insertedQty = Quantity
    FROM INSERTED;

    SELECT @deletedProduct = ProductID,
        @deletedQty = Quantity
    FROM DELETED;

    IF @insertedProduct IS NOT NULL
    BEGIN
        EXEC DecraseStock
        @ProductID = @insertedProduct,
        @Quantity = @insertedQty

        EXEC GetProductByID
        @ProductID = @insertedProduct
    END;

    IF @deletedProduct IS NOT NULL
    BEGIN
        EXEC IncreaseStock
        @ProductID = @deletedProduct,
        @Quantity = @deletedQty

        EXEC GetProductByID
        @ProductID = @deletedProduct
    END;
END;

-- Test
-- Insert
INSERT INTO [Order Details]
(
	OrderID,
	ProductID,
	Quantity,
	UnitPrice
)
VALUES
(
	10503,
	2,
	1,
	5
)

-- Delete
DELETE FROM [Order Details]
WHERE OrderID = 10503 AND ProductID = 2;


-- DROP TRIGGER
DROP TRIGGER UpdateStock


-- DDL Trigger Example

CREATE TRIGGER PreventTableCreation
ON example
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'You cannot create a table in this database.';
    ROLLBACK;
END;


-- LOGON Trigger Example

CREATE TRIGGER RestrictLogon
ON ALL SERVER WITH EXECUTE AS 'sa'
FOR LOGON
AS
BEGIN
    IF ORIGINAL_LOGIN() != 'sa' AND ORIGINAL_LOGIN() != 'dbo'
    BEGIN
        PRINT 'You cannot access this database.';
        ROLLBACK;
    END
END;

