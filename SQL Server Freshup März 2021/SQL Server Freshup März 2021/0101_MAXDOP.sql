/*

MAXDOP

SQL Server verwendet entweder einen oder alle CPUS f�r Abfragen
..ausser man �ndert den KOstenschwellwert, ab wann dies passiert
..und man die Anzahl der CPUs anpasst..

Seit SQL 2019 wird im Setup der default Wert auf 8 CPUs festgelegt 
oder alternativ auf Anzahl der CPUs falls weniger


Wichtig: Mehr CPUs zu verwenden macht oft keinen Sinn, da diese verwaltet werden m�ssen
der Aufwand diese CPUs zu verwalten ist gro�.
Oft macht auch nur die h�lfte Sinn...


Neu : man kann den MAXDOP Wert pro DB festlegen

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 4;

Im Plan l��t sich das gut feststellen: 
Repartition Stream und Gather Stream sind ein guter Hinweis darauf, dass 
weniger CPUs hilfreich sein k�nnte

--Messen: CXPACKET und CXPACKETCONSUMER


*/