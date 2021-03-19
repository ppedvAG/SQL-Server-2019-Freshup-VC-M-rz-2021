--Setup

/*
--TEMPDB


es wird automatisch fogendes erledig

Traceflag -T1117 alle Datendateien wachsen glecihm�ssig an
				-- SQL w�rde sonst immer die gr��ere beschreiben wolen
		  -T1118  Uniform Extent .kein Streit um eine Blockressource

es werden soviele DAteien wie Kerne angelegt, nicht mehr als 8
evtl andere / weiter HDDs in Spiuel bringen



--Volemwartungstask
aktivieren = vergr��ern der Datendadteien geschieht ohne Ausnullen (loak Sicherheitsrichtlinie

--Maxdop
wird auf max 8 Kerne begrenzt. Evtl in der Praxis nochmal nach unten regulieren
fr�her wurde alle (=0) Kerne f�r teuere (5 Kosten) Abfragen verwendet


--Arbeitsspeicher
kann beim Setup abzgl OS gleich eingesch�tzt und verwendet werden




*/

--Nun k�nnen wir aber auch pro DB folgendes entschieden

--MAXDOP pro DB
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;

begin tran

select * from customers
update customers set city = 'XYZ'
select @@TRANCOUNT

commit
rollback

USE [master]
GO
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

GO
ALTER DATABASE [Northwind] SET ALLOW_SNAPSHOT_ISOLATION ON
GO
--man liest die aktuellen g�litgen Datens�tze
--es gibt nicht mehr die Schreiben st�rt lesen Sperre
--aber massive Traffic auf temepdb