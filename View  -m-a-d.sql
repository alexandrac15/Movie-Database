USE LMBD
GO


--The view.  The view will show corrsponding to each movie it's actors and director


create view movieactordirector
as
SELECT m.Title,s.AName, d.DName
FROM Movie m INNER JOIN AM k ON m.MID=k.MID INNER JOIN Actors s ON k.AID=s.AID INNER JOIN Directors d ON d.DID=m.DID
go





SELECT * FROM movieactordirector