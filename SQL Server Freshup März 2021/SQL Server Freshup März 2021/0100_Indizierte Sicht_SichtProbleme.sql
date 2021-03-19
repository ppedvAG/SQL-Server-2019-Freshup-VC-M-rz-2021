set statistics io, time on

select country, count(*) from ku
group by country


--Um Sichten zu indizieren müssen diese schemagebunden sein und 
--und einen count_big enthalten

--schemabindung: kein * erlaubt und genau Angabe des Tabellennamens.. dbo.tabelle


ALTER view v1 with schemabinding--kein *  und genau
AS
select country, count_big(*)AS Anzahl from dbo.ku
group by country

select * from v1


--der IX legt die Eregbisdaten ab und indziert diese..
--super bei Aggregatsberechnungen
--aber: Update auf Tabelle ist auch Update auf SichtIndex

create table slf (id int, sp1 int, sp2 int)

insert into slf 
select 1,10,100
UNION
select 2,20,200
union
select 3,30,300

select * from slf


alter view v2 --with schemabinding
as
select * from slf

select * from v2


alter table slf add Stadt int 
update slf set Stadt = id *1000

select * from v2 --nicht mehr alle Spalten

alter table slf drop column sp2

select * from v2

--VIEW...

--Peter darf employees nicht lesen
--Peter darf in IT Sichten anlegen


create view it.v1
as
select * from dbo.employees

select * from it.v1--geht
dbo   dbo dbo MAX dbo dbo
--t1--v1--v2--v3--v4--v5



select * from dbo.employees




create table slf (id int, sp1 int, sp2 int)









