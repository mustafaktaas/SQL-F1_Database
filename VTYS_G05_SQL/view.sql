USE f1Veritabani
GO

/*Pilotlarýn özellikleri(isim,soyisim,yaþ fonksiyonu kullanarak) , bulunduðu güncel takýmlarýn isimleri , pilotlarýn ilk yarýþ tarihini 'Mar 18 2007' þeklinde
ve þampiyonalarda  aldýklarý puanlara göre iyi,orta ve kötü olarak sýnýflandýran viewý yazýnýz. */

IF OBJECT_ID('dbo.WidePilotInfo') IS NOT NULL
	BEGIN
		DROP VIEW WidePilotInfo
	END
GO

CREATE OR ALTER VIEW WidePilotInfo AS 

SELECT P.ID AS PilotID ,Þ.ID AS ÞampiyonaID, T.ID AS TakýmID , P.Adý + ' ' + P.Soyadý AS [Ad Soyad] ,
[dbo].[AgePilot](P.DoðumTarihi) AS Yas , T.Adý AS TakýmAdý, PÞ.Puan AS ÞampiyonaPuan , CONVERT(varchar,P.IlkYarýþTarihi,100) AS IlkYarisTarihi ,
CASE
	WHEN PÞ.Puan BETWEEN 0 AND 50 THEN 'KÖTÜ'
	WHEN PÞ.Puan BETWEEN 50 AND 150 THEN 'ORTA'
	ELSE 'ÝYÝ'
	END AS ÞampiyonaPuanSýnýflandýrmasý
FROM Pilot P INNER JOIN TakýmlarvePilotlarý TP 
ON P.ID = TP.PilotID INNER JOIN PilotÞampiyonalarý PÞ 
ON P.ID = PÞ.PilotID INNER JOIN Þampiyona Þ
ON PÞ.ÞampiyonaID = Þ.ID INNER JOIN Takým T
ON TP.TakýmID = T.ID
WHERE Þ.Adý = 'F1 2019 World Championship'
 
GO

/* Bu viewa ek olarak pilotlarýn þampiyonadaki araçlarýnýn þasilerini ve takýmlarýn ait olduðu ülkeleri getirelim.  */

SELECT WPI.* , A.Þasi as AracÞasi, U.Adý as TakýmUlkesi
FROM dbo.WidePilotInfo WPI INNER JOIN Araç A 
    ON WPI.TakýmID=A.TakýmID inner join Takým T 
        ON WPI.TakýmID = T.ID inner join Ulke U 
            ON T.UlkeID = U.ID
GO