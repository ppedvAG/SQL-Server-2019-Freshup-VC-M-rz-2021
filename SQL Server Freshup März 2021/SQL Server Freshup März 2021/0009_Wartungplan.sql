/*


regelm  Backup (V D T)
--sichern in einz Dateien und nicht in eine Datei

IX und Stats



<10% nix
> 10% Reorg  (Blattebene)
>30% Rebuild

--Statistiken

Histogramm pro Spalten

--Stat sind wichtig, um den besten Plan finen zu k�nnen

IX Seek : dann m�ssen aber rel wenige Datens�tze herauskommen, kommt mehr raus dann lueber scan
--Wehsel von Seek zu Scan bereits bei 1% beginnt 

--SCAN 50000 seiten... IX Seek mit 100 Seiten

--Stat m�ssen eigtl t�gl altualisiert werden
Wann werden die Stat aktualisert
---> 20% �nderungen + 500 + Abfrage (where)
*/
select * from sys.dm_db_index_usage_stats

--bsP.  HEAP 200 MB--> 1 CL + 2 NCL --> 363 MB
--Rebuild: ON/Offline  mit und ohne with sort in tempdb 
--geringster Platzbedarf: OFF + ohneTempdbd--> ca 860
--max Aufwand: Online + temdb ---> ca 1100MB

---was wenn kein SQL 2016--> Ola Hallengren

--Sicherungen : Pr�fsummen, Sicherungsintegrit�t, Kompression, bei Fehler fortsetzen
