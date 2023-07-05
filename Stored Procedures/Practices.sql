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
