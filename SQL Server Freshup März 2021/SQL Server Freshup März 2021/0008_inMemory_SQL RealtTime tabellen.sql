USE [Northwind]
GO


--"Normale Tabelle"
DROP TABLE IF EXISTS BEST;
GO

CREATE TABLE [dbo].[BEST](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_O] PRIMARY KEY NONCLUSTERED 
(
	[OrderID] ASC
))
USE [Northwind]
GO


--Mit den üblichen Indizes
CREATE CLUSTERED INDEX [NIX1] ON [dbo].[BEST]
(
	[OrderDate] ASC
)

USE [Northwind]
GO
CREATE NONCLUSTERED INDEX [NIX2] ON [dbo].[BEST]
(
	[Freight] ASC
)



--ToDo für Realtime

--erste Idee...mit Columnstore.. Non CLustered.. fitered

--Jetzt in Memory mit Columstore
--alle Indizes löschen
--dafür NON CL COL Store filtered

DROP INDEX [NIX1] ON [dbo].[BEST] 
GO
DROP INDEX [NIX2] ON [dbo].[BEST] 

GO

create nonclustered Columnstore Index NCCSfilter on BEST(orderid, customerid, freight, orderdate)
 WHERE (orderdate < '1.1.2020');
GO



-----oder----
--mit inMemory und CloumnStore



DROP TABLE IF EXISTS BEST;
GO

CREATE TABLE [dbo].[BEST](
	[OrderID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,

	  INDEX t_account_cci CLUSTERED COLUMNSTORE  
    )  
    WITH (MEMORY_OPTIMIZED = ON );  
	
