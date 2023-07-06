-- Employee by first name and last name

CREATE PROCEDURE EmployeeByName
(
    @FirstName varchar(50)
    @LastName varchar(50)
)
as
BEGIN
    SELECT *
    FROM Employees
    WHERE FirstName = @FirstName AND LastName = @LastName
END;


EXEC EmployeeByName
@FirstName = 'Andrew'
@LastName = 'Fuller'


-- Selling products by name

CREATE PROCEDURE SellingProductsByName
(
    @ProductName varchar(50)
)
as
BEGIN
    SELECT P.ProductName as [Product Name],
        sum(O.Quantity) as Unit,
        sum(O.UnitPrice) as [Unit Price],
        sum(O.Discount) as Discount,
        sum(O.Quantity * (O.UnitPrice * (1 - O.Discount))) as Profit
    FROM Products as P
    JOIN [Order Details] as O ON O.ProductID = P.ProductID
    WHERE P.ProductName = @ProductName
    GROUP BY P.ProductName;
END;


EXEC SellingProductsByName
@ProductName = 'Alice Mutton'


-- Insert Order with error handling

CREATE PROCEDURE InsertOrder
  @CustomerID nchar(5),
  @EmployeeID int,
  @OrderDate datetime,
  @ShipName nvarchar(40),
  @ShipAddress nvarchar(60),
  @ShipCity nvarchar(15)
AS
BEGIN
  BEGIN TRY
    DECLARE @InsertedOrders TABLE (
      OrderID int,
      CustomerID nchar(5),
      EmployeeID int,
      OrderDate datetime,
      ShipName nvarchar(40),
      ShipAddress nvarchar(60),
      ShipCity nvarchar(15)
    );

    INSERT INTO Orders(CustomerID, EmployeeID, OrderDate, ShipName, ShipAddress, ShipCity)
    OUTPUT INSERTED.OrderID, INSERTED.CustomerID, INSERTED.EmployeeID, INSERTED.OrderDate, INSERTED.ShipName, INSERTED.ShipAddress, INSERTED.ShipCity
    INTO @InsertedOrders
    VALUES (@CustomerID, @EmployeeID, @OrderDate, @ShipName, @ShipAddress, @ShipCity)

    SELECT * FROM @InsertedOrders;
  END TRY
  BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_STATE() AS ErrorState,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage;
  END CATCH;
END;
