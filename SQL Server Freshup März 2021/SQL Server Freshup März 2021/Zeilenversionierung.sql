--Zeilenversionierung

/*
ein ändern von Daten hindert kein Lesen 
Idee: akt Datensatz in tempdb kopieren mit Versionsnummer.
Möchte jemand dieses Datensatz lesen wird der aus der tempdb geliefert 
und muss icht warten bis sich die TX entschiedet ob ein Rollback oder Commit stattfindet

!! Traffic auf TempDB

*/

--User A:  TX  update tab a

--User B: select a  x READ COMMITTED
--erst lesen nach commit

--bei READ UNCOMM liest man die aktuellen Daten
--die nicht committed wurden

USE [master]
GO
ALTER DATABASE [Northwind] 
SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [Northwind]
SET ALLOW_SNAPSHOT_ISOLATION ON
GO
