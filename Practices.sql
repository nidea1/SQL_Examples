-- Add a new order and return it details

-- Stored Procedure

CREATE Procedure InsertOrder
(
    @CustomerID NCHAR(5),
    @EmployeeID INT,
    @OrderDate DATETIME,
    @ShipName NVARCHAR(40),
    @ShipCity NVARCHAR(15),
    @ShipAddress NVARCHAR(60)
)
as
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

            DECLARE @InsertedOrders TABLE (
                OrderID INT,
                CustomerID NCHAR(5),
                EmployeeID INT,
                OrderDate DATETIME,
                ShipName NVARCHAR(40),
                ShipCity NVARCHAR(15),
                ShipAddress NVARCHAR(60)
            );

            INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipName, ShipCity, ShipAddress)
            OUTPUT INSERTED.OrderID, INSERTED.CustomerID, INSERTED.EmployeeID, INSERTED.OrderDate, INSERTED.ShipName, INSERTED.ShipCity, INSERTED.ShipAddress
            INTO @InsertedOrders
            VALUES(@CustomerID, @EmployeeID, @OrderDate, @ShipName, @ShipCity, @ShipAddress)

            COMMIT;

            SELECT * FROM @InsertedOrders;
    END TRY
    BEGIN CATCH
        ROLLBACK;

        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_STATE() AS ErrorState,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;

-- Function

CREATE FUNCTION GetOrder(@OrderID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT O.OrderID, O.CustomerID, O.EmployeeID, O.OrderDate, O.ShipName, O.ShipAddress, O.ShipCity
    FROM Orders as O
    WHERE O.OrderID = @OrderID
);

-- TEST
EXEC InsertOrder 'ALFKI', 1, '2023-07-07', 'Alfreds Futterkiste', 'Obere Str. 57', 'Berlin'

SELECT * FROM GetOrderDetails(11078)


-- Add new customer and check product stock

-- Stored Procedure
CREATE PROCEDURE InsertCustomer
(
    @CustomerID NCHAR(5),
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24)
)
as
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
        VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax)

        COMMIT;

    END TRY
    BEGIN CATCH
        ROLLBACK;

        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_STATE() AS ErrorState,
            ERROR_SEVERITY() AS ErrorSeverity,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_LINE() AS ErrorLine,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;

-- Trigger
CREATE TRIGGER AfterInsertCustomer
ON Customers
AFTER INSERT
AS
BEGIN
  DECLARE @CompanyName nvarchar(40);
  DECLARE @CustomerID nchar(5);

  SELECT @CompanyName = i.CompanyName, @CustomerID = i.CustomerID
  FROM inserted i;

  PRINT 'New customer has been added: ' + @CompanyName + ' with ID: ' + @CustomerID;
END;

-- Function
CREATE FUNCTION CheckStock(@ProductID INT)
RETURNS INT
as
BEGIN
    DECLARE @UnitsInStock INT

    SELECT @UnitsInStock = UnitsInStock - UnitsOnOrder
    FROM Products
    WHERE ProductID = @ProductID;

    RETURN @UnitsInStock;
END;

-- TEST
EXEC InsertCustomer 'NEWCO', 'New Company', 'John Doe', 'CEO', '123 Main St.', 'New City', 'Region', '12345', 'Country', '123-456-7890', '123-456-7891';

SELECT dbo.CheckStock(1);
