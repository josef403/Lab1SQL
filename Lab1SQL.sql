/* MoonMissions */

/* Använd ”select into” för att ta ut kolumnerna ’Spacecraft’, ’Launch date’,
’Carrier rocket’, ’Operator’, samt ’Mission type’ för alla lyckade uppdrag
(Successful outcome) och sätt in i en ny tabell med namn ”SuccessfulMissions”. */

SELECT [Spacecraft], [Launch date], [Carrier rocket], [Operator], [Mission type]
INTO SuccessfulMissions FROM MoonMissions WHERE [Outcome] = 'Successful' 

GO

/*I kolumnen ’Operator’ har det smugit sig in ett eller flera mellanslag före
operatörens namn. Skriv en query som uppdaterar ”SuccessfulMissions” och tar
bort mellanslagen kring operatör */

UPDATE SuccessfulMissions SET Operator = TRIM(Operator)

GO

/* Users */

/* Ta ut samtliga rader och kolumner från tabellen ”Users”, men slå ihop ’Firstname’
och ’Lastname’ till en ny kolumn ’Name’, samt lägg till en extra kolumn ’Gender’
som du ger värdet ’Female’ för alla användare vars näst sista siffra i personnumret
är jämn, och värdet ’Male’ för de användare där siffran är udda. Sätt in resultatet i
en ny tabell ”NewUsers”. */

SELECT Users.*, [FirstName] + ' ' + [LastName] AS 'Name',
  CASE
      WHEN substring([ID], 10,1) % 2 = 0
	  THEN 'Female'
      ELSE 'Male'
  END AS 'Gender'
INTO NewUsers
FROM Users

GO

/* Skriv en query som returnerar en tabell med alla användarnamn i ”NewUsers”
som inte är unika i den första kolumnen, och antalet gånger de är duplicerade i
den andra kolumnen. */

SELECT UserName, COUNT(UserName) AS 'Duplicates'
FROM NewUsers
GROUP BY UserName
HAVING COUNT(UserName) > 1

GO

/*Skriv en följd av queries som uppdaterar de användare med dubblerade
användarnamn som du fann ovan, så att alla användare får ett unikt
användarnamn. D.v.s du kan hitta på nya användarnamn för de användarna, så
länge du ser till att alla i ”NewUsers” har unika värden på ’Username’.
*/

SET ANSI_WARNINGS  OFF;
UPDATE NewUsers SET [UserName] = 'sigpet01' WHERE [ID] = '630303-4894'
UPDATE NewUsers SET [UserName] = 'sigpet02' WHERE [ID] = '811008-5301'
UPDATE NewUsers SET [UserName] = 'sigpet03' WHERE [ID] = '580802-4175'
UPDATE NewUsers SET [UserName] = 'felber01' WHERE [ID] = '890701-1480'
UPDATE NewUsers SET [UserName] = 'felber02' WHERE [ID] = '880706-3713'
SET ANSI_WARNINGS ON;

GO

/*Skapa en query som tar bort alla kvinnor födda före 1970 från ”NewUsers”.  */

DELETE FROM NewUsers WHERE [ID] < '7' AND [Gender] = 'Female'

GO

/* Lägg till en ny användare i tabellen ”NewUsers” */

INSERT INTO NewUsers ([ID], [UserName], [password], [FirstName], [LastName], [Email], [Phone], [Name], Gender)
VALUES ('301412-0173', 
'zaki1', 
 CONVERT(nvarchar(28), HASHBYTES('SHA2_512', 'ZakiÄrBäst2021!'), 2), 
'Zakarie', 
'Isse', 
'zakki96@hotmail.com',
'073-213728', 
'Zakarie Isse', 
'Male');

GO


