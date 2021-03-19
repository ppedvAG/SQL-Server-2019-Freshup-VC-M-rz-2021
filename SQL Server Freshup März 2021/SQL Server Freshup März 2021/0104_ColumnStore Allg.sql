/*
IX

Nicht gr IX ca 1000

eindeutiger IX
abdeckender IX
part IX
ind Sicht
realer hypoth IX
gefilterter IX
zusammengesetzter IX kaum mehr als 4 Spalten ..wAarum
IX mit eingeschlossenen Spalten vermeiden Lookup


Gr IX pro Tab nur 1 mal.. PK immer reichl überlegen-- CL IX eindeutig
	 besondere Fähigkeiten : Bereichsabfragen

Columnstore IX gr und ngr

--Vorteil: Spalten bleiben "liegen"-- IO weniger
--         Kompression...Seiten/Zeilen: 40% 60%
--                   SNAPSHOT



--KU1 (row) ...  30ms  40 Seiten
--ku2 (cs)  ....  5ms  ??????

Columnstore Probleme: INS UP DE.. Heapstrukturen





*/

select * from sys.dm_db_column_store_row_group_physical_stats
---HEAP: Delta Store.. Segemente 
select * from ku2 where id = 100
select db_id()
--Usage: 
--SCAN A bis Z durchsuchen
--SEEK Herauspicken

---TABLE SCAN 
--IX SCAN.. NCL komplett durchsuchen
--IX SEEK.. NCL IX ..super Verwendung
--CL IX SCAN -- komplett
--CL IX SEEK -- Herauspicken

--TSCAN vs IX SCAN... IX SCAN ist besser
--IX SEEK IX SCAN...  Immer der SEEK
--CL IX SCAN vs TSCAN ...egal
--CL IX SEEK vs IX SEEK.. gleich schnell
--Lookup vermeiden (CL IX hat nie Lookup)
--- TAB:LOOKUP.... CL IX: RID LOOKUP

--NCL IX SEEK auf eine CL IX
--NCL IX auf HEAP ..schneller

--IXID= 0  HEAP
--IXID=1     CL IX
--IXID über1 .. NCL IX

select * from orders where orderid = 10249



select * from sys.dm_db_index_usage_stats where database_id=5

--überlappende Indizes

--A B C
-- A B C
--AB ABC BAC  BCA CAb CA BC CB C

--sp_blitzIndex

--Architektur der Seiten...

--Seiten 8192bytes
--8073 bytes dürfen für DS 
--1 DS darf nicht mehr als 8060bytes
--max 700 Slots
--ganze DS muss in Seite passen: Leerräume
--Seiten kommen 1:1 in RAM

dbcc showcontig('ku2') --..: 43323 --Vorsicht kann teuer werden
						--ohne Angabe der Tabelle wird die gesamte DB gescannt


set statistics io, time on

select * from ku2 where id = 100 -- 58120

select * from sys.dm_db_index_physical_stats(db_id(),object_id('ku2'),NULL,NULL,'detailed')

--Forward_Record_Counts: CL IX haben das nie


delete from customers where customerid = 'ALFKI'

select * from ku2 where  freight =0.01 and 

--Statistiken

--wann werden Stst angelegt: bei Abfrage mit where, bei IX anlegen
--wann werden werden sie aktualisiert: 20%+500+Abfrage auf Spalte
--Table Scan vs IX Sceen
--Kardinalsschätzung

-- 1,1 Mio 1% 11000.. 50 20000

--Wartung Indizes und Stats


--Regeln:

--IX Frag < 10% nix
--        < 30 Reorg
----------   Rebuild

select * from sys.dm_db_index_usage_stats


200MB HEAP
1 CL 2 NCL    360MB


Rebuild mit tempdb und online--1100

Rebuild ohne tempdb und online

Rebuild mit tempdb und offline

Rebuild ohne tempdb und offline--860MB













