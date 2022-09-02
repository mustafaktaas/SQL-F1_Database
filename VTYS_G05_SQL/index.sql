USE  f1Veritabani 
GO

DROP INDEX IF EXISTS pilotAdIndex
ON Pilot
GO

CREATE NONCLUSTERED INDEX pilotAdIndex ON Pilot
        (
        Adý ASC
        )
		GO

		SET STATISTICS IO ON
		SET STATISTICS TIME ON

SELECT Adý FROM Pilot WHERE Adý = 'Lewis'
GO
