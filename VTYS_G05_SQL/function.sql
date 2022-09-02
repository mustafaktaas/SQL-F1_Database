USE f1Veritabani
GO

--Pilotun �uanki tarihden do�um tarihini ��kar�p ka� ya��nda oldu�unu hesaplayan fonksiyonu yaz�n�z.

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

SELECT P.Ad�+ ' ' + P.Soyad� AS [Ad Soyad],dbo.AgePilot(P.Do�umTarihi) AS Yas FROM Pilot P 
GO
