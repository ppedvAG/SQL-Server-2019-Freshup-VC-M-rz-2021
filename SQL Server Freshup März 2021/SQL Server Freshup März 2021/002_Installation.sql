/*


MAXOP

Arbeitsspeicher
-OS (10%)--mind 5 bis 10GB


Wieviele  CPUS verwendet eine ABfrage
*/


SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, 
                         Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName, 
                         Employees.BirthDate, Employees.HireDate
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


insert into ku
select * from ku



select top 3 * from ku


--Pl‰ne
set statistics io, time on --Anzhal der Seiten, Dauer und Zeit der CPU in ms
--bloﬂ nicht in Schleifen

--Scoped database pro DB
select companyname, sum(unitprice*quantity) from ku group by companyname
option (maxdop 1)
--CPU-Zeit = 985 ms, verstrichene Zeit = 170 ms.
--Mehr CPU Zeit als Dauer??
--Paralellismus
--Default: alle CPUS.. man sollte max 8 ansetzen
--w‰re es nicht besser mehr zu nehmen
--Gather Stream  Partition Stream

select companyname, sum(unitprice*quantity) from ku
where city = 'UK'
group by companyname


Sortierung DB  mit A--  #t tempdb Sort B
--hohe CPU 60%--MAXDOP von 8 auf 6 oder 4








