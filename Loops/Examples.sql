-- WHILE LOOP

-- Syntax

WHILE <condition>
    SQL Statement | statement_block | BREAK | CONTINUE


-- Example 1

DECLARE @i INT = 1;

WHILE @i <= 5
BEGIN
    PRINT(@i);
    SET @i = @i + 1;
END;

-- Example 2

CREATE PROCEDURE CountOrders
    @EmployeeID INT,
    @OrderCount INT OUTPUT
as
BEGIN
    SET @OrderCount = 0;

    DECLARE @CurrentOrderID INT, @CurrentEmployeeID INT; -- New local variables

    DECLARE order_cursor CURSOR FOR
    SELECT OrderID, EmployeeID
    FROM Orders; -- Creating order_cursor for choosing per row in orders

    OPEN order_cursor; 

    FETCH NEXT FROM order_cursor
    INTO @CurrentOrderID, @CurrentEmployeeID; -- Opening order_cursor for taking first row and setting orderID and employeeID to our variables from current row

    WHILE @@FETCH_STATUS = 0 -- If fetch is success
    BEGIN
        IF @CurrentEmployeeID = @EmployeeID
        BEGIN
            SET @OrderCount = @OrderCount + 1;
        END;

        FETCH NEXT FROM order_cursor 
        INTO @CurrentOrderID, @CurrentEmployeeID;
    END;

    CLOSE order_cursor;
    DEALLOCATE order_cursor;
END;


-- Test

DECLARE @OrderCount INT;

EXEC
CountOrders 4,
@OrderCount OUTPUT;

SELECT @OrderCount as 'Order Count';


-- We can too do this as
SELECT COUNT(*) as 'Order Count'
FROM Orders
WHERE EmployeeID = 4;        
