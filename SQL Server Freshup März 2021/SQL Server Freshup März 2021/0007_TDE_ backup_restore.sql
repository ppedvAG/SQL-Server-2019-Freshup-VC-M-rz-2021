use master
go

backup certificate tdeZert --name des Zertifikats
	to file ='D:\_BACKUP\TDEZEertx.cer'
	with private key
		(file='D:\_BACKUP\tdezertprivx.pvk', 
		encryption by password='ppedvAG01!')
	go


backup database tdedemo to disk='D:\_HRBACKUP\tde.bak'


---Restore------ auf anderen Server
use master
go
drop master key

create master key encryption by password='ppedvAG01!'
go

create certificate tdeZert
	from file='D:\_HRBACKUP\TDEZEertx.cer'
	with private key 
	(file='D:\_HRBACKUP\tdezertprivx.pvk', 
	decryption by password='ppedvAG01!')



