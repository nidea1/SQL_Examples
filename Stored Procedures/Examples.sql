-- CREATE Stored Procedure

-- We can create a procedure with CREATE PROCEDURE statement and if we want add a parameter, using @ before the parameter.
-- Example

CREATE PROCEDURE OrdersByPrice
(
    @OrderBeginPrice real,
    @OrderEndPrice real,
)
as
BEGIN
    SELECT *
    FROM ExampleOrderDetail
    WHERE Price BETWEEN @OrderBeginPrice AND @OrderEndPrice
    ORDER BY Price
END;

-- Users can list orders by the between specific prices in this procedure. Thus users now performs same operation by calling the procedure instead of typing a queary.

-- EXECUTE Stored Procedure
-- Example

EXEC OrdersByPrice
@OrderBeginPrice = 4,
@OrderEndPrice = 20


-- ALTER Stored Procedure

-- We can update a procedure with ALTER PROCEDURE statement.
-- Example

ALTER PROCEDURE OrdersByPrice
@OrderBeginPrice real,
@OrderEndPrice real
as
BEGIN
    SELECT *
    FROM ExampleOrderDetail
    WHERE Price BETWEEN @OrderBeginPrice AND @OrderEndPrice
    -- ORDER BY Price
END;


-- DROP Stored Procedure

-- We can delete a procedure with DROP PROCEDURE statement.
-- Example

DROP PROCEDURE OrdersByPrice;


-- ENCRYPTED Stored Procedure

-- We can create a encrypted procedure with the same statement as the create procedure but we must add WITH ENCRYPTION statement before the AS.
-- Now we can not use design in the encrypted procedure but we can update with ALTER statement and delete with DROP statement the procedure.
-- Example

CREATE PROCEDURE OrdersByPrice
(
    @OrderBeginPrice real,
    @OrderEndPrice real,
)
WITH ENCRYPTION
as
BEGIN
    SELECT *
    FROM ExampleOrderDetail
    WHERE Price BETWEEN @OrderBeginPrice AND @OrderEndPrice
    ORDER BY Price
END;


-- RECOMPILE Stored Procedure

-- Stored Procedures are usually storing in Plan Cache. But if we use RECOMPILE statement when creating a procedure, it does not storing in Plan Cache and is recreated each time the procedure is executed.
-- Example

CREATE PROCEDURE OrdersByPrice
(
    @OrderBeginPrice real,
    @OrderEndPrice real,
)
WITH RECOMPILE
as
BEGIN
    SELECT *
    FROM ExampleOrderDetail
    WHERE Price BETWEEN @OrderBeginPrice AND @OrderEndPrice
    ORDER BY Price
END;
