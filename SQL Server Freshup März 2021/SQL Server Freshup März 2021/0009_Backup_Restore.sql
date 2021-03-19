/*BACKUP.. RESTORE





SNAPSHOTS

Protokollfragment = ungesicherte Teil der LogFiles

sobald wir einen Resore erstellen, schl�gt das SSMS ein Backup dieses Fragments vor

*/
create table test5(id int, GebDatum datetime)




/*
Wiederhersstellungsmodel pro DB: 

SIMPLE
jede TX wird nach Commit/Rollback  und Checpoint aus dem Log gel�scht
es kann kein Restore per Log gemacht werden
TestDB
Bulk Operaationen werden nur rudiment�r protkolliert


Bulk
wie einfach... aber es wird nix aus dem Log gel�scht--> Log w�chst .bis: Log geichert wird
nur dann auf Sek restoren, wenn kein Bulk stattfand


FULL
ausf�hrliche protkollierung, auch den Bulk
auf sek restorebar
ProduktivDBs..



kann ein restore per Logfile auf Sek arrangiert

Voll
sichert Pfade, Dateien, den Inhalt, die Gr��e
Checkpoint
Zeitpunkt der Sicherung wird gesichert

Diff
ge�nderte Seiten seit V


Tlog
sichert die Transaktionen ..wie ein makro..wir sichern Anweisungen




V   TTT  D   TTT D TTT D TTT
V                      D TTT ..T wird alle 30min gesichert


der schnellste Restore: V --> so h�ufig wie m�glich V
wie lange dauert das vorletzte T beim restore: so lange die TX dauerten die im T stecken

-- ich mag keine gro�en Ts haben 

V TTTX!TTTTTTTDTTTTT


--alles nach einen defekten T ist unn�tz... ausser es h�tte nach ein D gegeben


---Wie lange darf der Server ausfallen?  1STD
--Wie gro� darf der Datenverlust in Zeit sein?   15min
--50GB

--V um 22 Uhr
--T alle 15min
--alle 3 bi 4 T: alle Stunden eine D 


Was kann passieren:


fall 1: logischer fehler--> falsche Daten durch TSQL 

Fall 2: technischer Fehler
			HDD oder DAtei defekt
			oder nur LogFile ist defekt
			oder Server ist hin, aber HDD lebt


Fall 3:  Was , wenn ich weiss, dass gleich was passieren k�nnte



---mit m�glichst geringsten Datenverlust

*/


BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'Nwind Voll', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  DIFFERENTIAL 
, NOFORMAT, NOINIT,  NAME = N'nwind Diff', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak'
	WITH NOFORMAT, NOINIT,  NAME = N'Nwind TLog', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--V  TTT D TTT D TTT

--Logischer Fehler.. restore unter anderen NAmen

--11:25 HUHU MEldung
--11:20 Error
---n�chste T w�rde um 11:45 laufen

--geringst m�glich Datenverlust


--Kill User (SPID)
--jetzt eine T Sicherung: 11:27 
--Restore von 11.19: 59 Sekunden




--SNAPSHOT

-- =============================================
-- Create Database Snapshot Template
-- =============================================


-- Create the database snapshot
CREATE DATABASE SN_dataMask1208
ON
( NAME	 = dynDataMasking, --logischer DAteiname der orgDB
FILENAME = 'D:\_SQLDB\SN_dataMask1208.mdf' )
AS SNAPSHOT OF dynDatamasking;
GO

--f�r den restore m�ssen alle von de allen DB runter

use master --wir selber shon mal nicht

select db_id('dyndatamasking')--17
select db_id('SN_datamask1208')--27

--oder auch per 
select * from sysdatabases




select * from sysprocesses where dbid in (17,27)
kill 106

restore database dynDataMasking
from database_snapshot='SN_dataMask1208'


















