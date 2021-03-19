drop table if exists dbo.votesx
select * into votesx from stackoverflow2010..votes

create nonclustered index ix1 
on dbo.votesx(id)
with( online = on , resumable = on)
GO

USE [StackOverflow2010]
GO
ALTER INDEX [ix1] ON [dbo].[votesx]
REBUILD PARTITION = ALL 
with( online = on , resumable = on, MAX_DURATION =1 MINUTES)

ALTER INDEX [ix1] ON [dbo].[votesx] Resume WITH (MAX_DURATION =1 MINUTES)


--other session
waitfor delay '00:00:02'
GO

Alter Index ix1 on dbo.votesx abort--pause
GO
select * from sys.index_resumable_operations

GO
Alter Index ix1 on dbo.votes resume

