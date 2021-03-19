--Kompressionsschätzung
--geht aktuell noch nicht im SSMS ....

	 --> tempdb
ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = off;
--Restart
select * into cs from StackOverflow2010..votes

EXEC sys.sp_estimate_data_compression_savings
     @schema_name      = N'dbo',
     @object_name      = N'votesx',
     @index_id         = NULL,
     @partition_number = NULL, 
     @data_compression = N'COLUMNSTORE_ARCHIVE'; 

	 --ROW, PAGE, COLUMNSTORE, COLUMNSTORE_ARCHIVE
