--inMemoryTabellen benötigen keine Latches bei Inserts
--inMemoryTabellen benötigen inMmemory Filegroups

--https://docs.microsoft.com/de-de/sql/relational-databases/in-memory-oltp/altering-memory-optimized-tables?view=sql-server-ver15


drop database if exists IMDB
GO
create database IMDB
GO

use IMDB

Use Master
GO

ALTER DATABASE IMDB ADD FILEGROUP [IM] CONTAINS MEMORY_OPTIMIZED_DATA 
GO
ALTER DATABASE IMDB ADD FILE ( NAME = N'imVerzeichnis', FILENAME = N'D:\_SQLDB\imVerzeichnis' ) TO FILEGROUP [IM]
GO

use IMDB
GO

CREATE TABLE imTabelle
(
	id int identity, 
	sp1 varchar(50),
	sp2 money INDEX IXIM NONCLUSTERED (sp2), 
	   CONSTRAINT PK_IM PRIMARY KEY NONCLUSTERED (sp1),
	   INDEX IXhash HASH (id) WITH (BUCKET_COUNT = 131072) --<----- in etwa Slots
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = Schema_only)   --> nach Neustart werden Daten rekonstruiert
GO



select top 100000 Customerid, freight into #t from nwindbig..orders


insert into imTabelle
select * from #t

drop table #t


--Bucketcount
--Wird auf die nächste 2er Potenz gerundet
--> 1 MIo --> 1.048.576
--> Bucket Count *8 bytes
-- + 8 bytes mal Anzahl der zeilen

---> 1,073,741,824 ---> 8.589.934.592 bytes

--Formel für Bucket Count Berechnung auf der Basis einer bestehenden Tabelle
SELECT
  POWER(
    2,
    CEILING( LOG( COUNT( 0)) / LOG( 2)))
    AS 'BUCKET_COUNT'
FROM
  (SELECT DISTINCT orderid FROM nwindbig..orders) T


select * from  sys.dm_db_xtp_hash_index_stats

ALTER TABLE imTabelle
       ALTER INDEX ixHash  
              REBUILD WITH (BUCKET_COUNT=4);  
GO