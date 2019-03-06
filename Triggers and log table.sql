USE LMBD
GO


--Trigger for first table (Movies)  for the insert operation. The trigger will print the inserted row.
--CREATE TABLE logs (TriggerDate date, TriggerType VARCHAR(50), NameAffectedTable VARCHAR(50), NoAMDRows int)
alter trigger trgMoviesInsert on Movies for insert 
as
begin
print 'The movie '
select Title,Genre
from inserted
print 'was added to this list of awesome movies'
declare @var as int
 set @var=@@ROWCOUNT
INSERT INTO logs VALUES (GETDATE(),'INSERT','Movies',@var)
end

go


--The only update that can be done to the table movies is the change of the rating.






alter trigger trgMoviesUpdate on Movies for update
as
begin
select Rating
from deleted
declare @var as int
 set @var=@@ROWCOUNT
INSERT INTO logs VALUES (GETDATE(),'UPDATE','Movies',@var)
end
go






alter trigger trgAMDelete5  on AM for delete 
as
begin
select AName,Title
from dbo.movieactordirector
declare @var as int
 set @var=@@ROWCOUNT
INSERT INTO logs VALUES (GETDATE(),'DELETE','AM',@var)
end
go


alter trigger trgAMInsert  on AM for insert
as
begin
select AName,Title 
from dbo.movieactordirector
declare @var as int
 set @var=@@ROWCOUNT
INSERT INTO logs VALUES (GETDATE(),'INSERT','AM',@var)
end
go






--to test:


--3 trigger (delete)
SELECT * FROM AM
DELETE FROM AM
WHERE MID=1



--2 trigger
UPDATE Movies
set Rating=9.9
WHERE MID=11




--1 trigger 
SELECT * FROM Directors
SELECT * FROM Movies
INSERT Directors VALUES (8,'Bryan Singer')
INSERT Movies VALUES (11,'Bohemian Rhapsody','Biography',8.3,2018,8)
DELETE FROM Movies
WHERE MID=11


--create log here

CREATE TABLE logs (TriggerDate datetime, TriggerType VARCHAR(50), NameAffectedTable VARCHAR(50), NoAMDRows int)
SELECT*FROM logs
