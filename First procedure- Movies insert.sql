USE LMDB
GO

DROP PROCEDURE insertMovies;  
GO  
DROP FUNCTION checkRating;
DROP FUNCTION checkTitle;
GO

--Functions for the first procedure: (checkRating and checkTitle)
create function checkRating(@n float)
returns int as
begin
declare @r int
   if 0<@n  and @n<10
            set @r=1
   else
	         set @r=0

	return @r
end
go

create function checkTitle(@n vARCHAR(50))
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



--create a procedure (first one (1/2))

create proc insertMovies @id int ,@title VARCHAR(50),@genre VARCHAR(50),@rating float,@year int, @name VARCHAR(50)
AS
begin
if dbo.checkRating(@rating)=1 and dbo.checkTitle(@title)=1
   begin
   INSERT Movie VALUES (@id,@title,@genre,@rating,@year,(SELECT d.idD
FROM Director d WHERE Name Like @name))
   print'Value added!'
   end
   else
   begin
   print'Check the parameters again!'
   end

   end
go


--Procedure call:
exec insertMovies 10,'The Prestige','Mystery',8.5,2006,'David Fincher'
--Verify if the procedure adds to the table:

SELECT*
FROM Movie

SELECT * 
FROM Director
 
 --DELETE FROM Movies
 --WHERE MID=10