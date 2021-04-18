/* MoonMissions G-del */

/* Anv�nd �select into� f�r att ta ut kolumnerna �Spacecraft�, �Launch date�,
�Carrier rocket�, �Operator�, samt �Mission type� f�r alla lyckade uppdrag
(Successful outcome) och s�tt in i en ny tabell med namn �SuccessfulMissions�. */

SELECT [Spacecraft], [Launch date], [Carrier rocket], [Operator], [Mission type]
INTO SuccessfulMissions FROM MoonMissions WHERE [Outcome] = 'Successful' 

GO

/*I kolumnen �Operator� har det smugit sig in ett eller flera mellanslag f�re
operat�rens namn. Skriv en query som uppdaterar �SuccessfulMissions� och tar
bort mellanslagen kring operat�r */

UPDATE SuccessfulMissions SET Operator = TRIM(Operator)

GO

/* Users G-del */

/* Ta ut samtliga rader och kolumner fr�n tabellen �Users�, men sl� ihop �Firstname�
och �Lastname� till en ny kolumn �Name�, samt l�gg till en extra kolumn �Gender�
som du ger v�rdet �Female� f�r alla anv�ndare vars n�st sista siffra i personnumret
�r j�mn, och v�rdet �Male� f�r de anv�ndare d�r siffran �r udda. S�tt in resultatet i
en ny tabell �NewUsers�. */

SELECT Users.*, [FirstName] + ' ' + [LastName] AS 'Name',
  CASE
      WHEN substring([ID], 10,1) % 2 = 0
	  THEN 'Female'
      ELSE 'Male'
  END AS 'Gender'
INTO NewUsers
FROM Users

GO

/* Skriv en query som returnerar en tabell med alla anv�ndarnamn i �NewUsers�
som inte �r unika i den f�rsta kolumnen, och antalet g�nger de �r duplicerade i
den andra kolumnen. */

SELECT UserName, COUNT(UserName) AS 'Duplicates'
FROM NewUsers
GROUP BY UserName
HAVING COUNT(UserName) > 1

GO

/*Skriv en f�ljd av queries som uppdaterar de anv�ndare med dubblerade
anv�ndarnamn som du fann ovan, s� att alla anv�ndare f�r ett unikt
anv�ndarnamn. D.v.s du kan hitta p� nya anv�ndarnamn f�r de anv�ndarna, s�
l�nge du ser till att alla i �NewUsers� har unika v�rden p� �Username�.*/

SET ANSI_WARNINGS  OFF;
UPDATE NewUsers SET [UserName] = 'sigpet01' WHERE [ID] = '630303-4894'
UPDATE NewUsers SET [UserName] = 'sigpet02' WHERE [ID] = '811008-5301'
UPDATE NewUsers SET [UserName] = 'sigpet03' WHERE [ID] = '580802-4175'
UPDATE NewUsers SET [UserName] = 'felber01' WHERE [ID] = '890701-1480'
UPDATE NewUsers SET [UserName] = 'felber02' WHERE [ID] = '880706-3713'
SET ANSI_WARNINGS ON;

GO

/*Skapa en query som tar bort alla kvinnor f�dda f�re 1970 fr�n �NewUsers�.  */

DELETE FROM NewUsers WHERE [ID] < '7' AND [Gender] = 'Female'

GO

/* L�gg till en ny anv�ndare i tabellen �NewUsers� */

INSERT INTO NewUsers ([ID], [UserName], [password], [FirstName], [LastName], [Email], [Phone], [Name], Gender)
VALUES ('301412-0173', 
'zaki1', 
 CONVERT(nvarchar(28), HASHBYTES('SHA2_512', 'Zaki�rB�st2021!'), 2), 
'Zakarie', 
'Isse', 
'zakki96@hotmail.com',
'073-213728', 
'Zakarie Isse', 
'Male');

GO


