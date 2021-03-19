--Setup

/*
--TEMPDB


es wird automatisch fogendes erledig

Traceflag -T1117 alle Datendateien wachsen glecihmässig an
				-- SQL würde sonst immer die größere beschreiben wolen
		  -T1118  Uniform Extent .kein Streit um eine Blockressource

es werden soviele DAteien wie Kerne angelegt, nicht mehr als 8
evtl andere / weiter HDDs in Spiuel bringen



--Volemwartungstask
aktivieren = vergrößern der Datendadteien geschieht ohne Ausnullen (loak Sicherheitsrichtlinie

--Maxdop
wird auf max 8 Kerne begrenzt. Evtl in der Praxis nochmal nach unten regulieren
früher wurde alle (=0) Kerne für teuere (5 Kosten) Abfragen verwendet


--Arbeitsspeicher
kann beim Setup abzgl OS gleich eingeschätzt und verwendet werden




*/

--Nun können wir aber auch pro DB folgendes entschieden

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
--man liest die aktuellen gülitgen Datensätze
--es gibt nicht mehr die Schreiben stört lesen Sperre
--aber massive Traffic auf temepdb