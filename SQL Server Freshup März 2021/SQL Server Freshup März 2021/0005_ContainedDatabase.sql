/*

eigenständige DB.. 

Dinge enthält in der Regel keine Objekte die in SystemDB sind

Jobs, Login , #tabellen
*/
USE [master]

GO
EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

USE [FRESHUP]
GO
CREATE USER [Otto] WITH PASSWORD=N'ppedv2020!'
GO



