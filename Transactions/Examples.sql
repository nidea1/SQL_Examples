-- Transaction Expressions

-- BEGIN TRANSACTION -> starting a new transaction.
-- COMMIT -> makes all changes in the transaction permanent.
-- ROLLBACK -> rolls back all changes in the transaction since start. If a error occured or transaction is not completed, used ROLLBACK expression.

-- Example

BEGIN TRANSACTION;

UPDATE Products
SET UnitsInStock = UnitsInStock - 5
WHERE ProductID = 1;

IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;


-- Example 2

BEGIN TRANSACTION;

BEGIN TRY
    INSERT INTO Orders (CustomerID, EmployeeID, OrderDate)
    VALUES ('VINET', 5, GETDATE())

    DECLARE @NewOrderID INT;
    SELECT @NewOrderID = SCOPE_IDENTITY()

    INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@NewOrderID, 3, 15, 3, 0)

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;

    PRINT ERROR_MESSAGE();
END CATCH;
