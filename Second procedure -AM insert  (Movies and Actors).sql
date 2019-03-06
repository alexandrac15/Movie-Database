USE LMDB
GO

--insert in the AM table : actors and movies .  The procedure will take 3 arguments,
--the name of the actor, the name of the movie, and the year of the movie, as there can be 2 movies with the same name,
--but rarely 2 movies with thesame name produced in the same year.

--The functions : there will be 3 functions to test the parameters: 2 for the names (checkStringActor, checkStringMovie )
--and 1 for testing the year (checkYear)


DROP PROCEDURE insertinAM;  
GO  
DROP FUNCTION checkStringActor;
DROP FUNCTION checkStringMovie;
GO

--The functions:
create function checkYear(@n int)
returns int as
begin
declare @r int
   if 1890<@n  and @n<2020
            set @r=1
   else
	         set @r=0

	return @r
end
go

create function checkStringActor(@n vARCHAR(50))
returns int as
begin
declare @r int
   if @n  like '[a-z]%[a-z]'
            set @r=1
   else
	         set @r=0

	return @r
end
go

create function checkStringMovie(@n vARCHAR(50))
returns int as
begin
declare @r int
   if @n  like '[a-z]%[a-z]'
            set @r=1
   else
	         set @r=0

	return @r
end
go


--The procedure:

create procedure insertinAM @Actor VARCHAR(50) , @Movie VARCHAR(50), @year int
AS
begin
if dbo.checkStringActor(@Actor)=1 and dbo.checkStringMovie(@Movie)=1 and dbo.checkYear(@year)=1
   begin
   INSERT AM VALUES ((SELECT m.MID FROM Movie m WHERE m.Title like @Movie and m.Year=@year),(SELECT a.AID FROM Actors a WHERE a.AName like @Actor))
   print 'Value added'
   end
   else
   begin
   print 'Check parameters again!'
   end

end
go


-- (Clear tha table before running the exec-s)
DELETE FROM AM 
WHERE MID in (1,3,6,10)



exec insertinAM 'Morgan Freeman','Shawshank Redemption',1994
exec insertinAM 'Christian Bale','The Dark Night',2008
exec insertinAM 'Uma Thurman','Pulp Fiction',1994
exec insertinAM 'John Travolta','Pulp Fiction',1994
exec insertinAM 'Christian Bale','The Prestige',2006


SELECT* 
FROM AM


SELECT m.Title ,k.AName
FROM Movies m  JOIN AM  j ON j.MID=m.MID  JOIN Actors k ON k.AID=j.AID
SELECT *
FROM Actors