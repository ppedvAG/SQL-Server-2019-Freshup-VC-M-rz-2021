/*

MAXDOP

SQL Server verwendet entweder einen oder alle CPUS für Abfragen
..ausser man ändert den KOstenschwellwert, ab wann dies passiert
..und man die Anzahl der CPUs anpasst..

Seit SQL 2019 wird im Setup der default Wert auf 8 CPUs festgelegt 
oder alternativ auf Anzahl der CPUs falls weniger


Wichtig: Mehr CPUs zu verwenden macht oft keinen Sinn, da diese verwaltet werden müssen
der Aufwand diese CPUs zu verwalten ist groß.
Oft macht auch nur die hälfte Sinn...


Neu : man kann den MAXDOP Wert pro DB festlegen

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 4;

Im Plan läßt sich das gut feststellen: 
Repartition Stream und Gather Stream sind ein guter Hinweis darauf, dass 
weniger CPUs hilfreich sein könnte

--Messen: CXPACKET und CXPACKETCONSUMER


*/