USE f1Veritabani
GO

--Pilotun þuanki tarihden doðum tarihini çýkarýp kaç yaþýnda olduðunu hesaplayan fonksiyonu yazýnýz.

IF OBJECT_ID('dbo.AgePilot') IS NOT NULL
	BEGIN
		DROP FUNCTION AgePilot
	END
GO

CREATE OR ALTER FUNCTION AgePilot(@TARIH DATE)
RETURNS INT
AS
	BEGIN

	DECLARE @yas INT = DATEDIFF(YY,@TARIH,GETDATE())
	
	RETURN @yas

END
GO

SELECT P.Adý+ ' ' + P.Soyadý AS [Ad Soyad],dbo.AgePilot(P.DoðumTarihi) AS Yas FROM Pilot P 
GO
