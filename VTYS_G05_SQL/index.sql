USE  f1Veritabani 
GO

DROP INDEX IF EXISTS pilotAdIndex
ON Pilot
GO

CREATE NONCLUSTERED INDEX pilotAdIndex ON Pilot
        (
        Ad� ASC
        )
		GO

		SET STATISTICS IO ON
		SET STATISTICS TIME ON

SELECT Ad� FROM Pilot WHERE Ad� = 'Lewis'
GO
