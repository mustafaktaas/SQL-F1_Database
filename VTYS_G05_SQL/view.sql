USE f1Veritabani
GO

/*Pilotlar�n �zellikleri(isim,soyisim,ya� fonksiyonu kullanarak) , bulundu�u g�ncel tak�mlar�n isimleri , pilotlar�n ilk yar�� tarihini 'Mar 18 2007' �eklinde
ve �ampiyonalarda  ald�klar� puanlara g�re iyi,orta ve k�t� olarak s�n�fland�ran view� yaz�n�z. */

IF OBJECT_ID('dbo.WidePilotInfo') IS NOT NULL
	BEGIN
		DROP VIEW WidePilotInfo
	END
GO

CREATE OR ALTER VIEW WidePilotInfo AS 

SELECT P.ID AS PilotID ,�.ID AS �ampiyonaID, T.ID AS Tak�mID , P.Ad� + ' ' + P.Soyad� AS [Ad Soyad] ,
[dbo].[AgePilot](P.Do�umTarihi) AS Yas , T.Ad� AS Tak�mAd�, P�.Puan AS �ampiyonaPuan , CONVERT(varchar,P.IlkYar��Tarihi,100) AS IlkYarisTarihi ,
CASE
	WHEN P�.Puan BETWEEN 0 AND 50 THEN 'K�T�'
	WHEN P�.Puan BETWEEN 50 AND 150 THEN 'ORTA'
	ELSE '�Y�'
	END AS �ampiyonaPuanS�n�fland�rmas�
FROM Pilot P INNER JOIN Tak�mlarvePilotlar� TP 
ON P.ID = TP.PilotID INNER JOIN Pilot�ampiyonalar� P� 
ON P.ID = P�.PilotID INNER JOIN �ampiyona �
ON P�.�ampiyonaID = �.ID INNER JOIN Tak�m T
ON TP.Tak�mID = T.ID
WHERE �.Ad� = 'F1 2019 World Championship'
 
GO

/* Bu viewa ek olarak pilotlar�n �ampiyonadaki ara�lar�n�n �asilerini ve tak�mlar�n ait oldu�u �lkeleri getirelim.  */

SELECT WPI.* , A.�asi as Arac�asi, U.Ad� as Tak�mUlkesi
FROM dbo.WidePilotInfo WPI INNER JOIN Ara� A 
    ON WPI.Tak�mID=A.Tak�mID inner join Tak�m T 
        ON WPI.Tak�mID = T.ID inner join Ulke U 
            ON T.UlkeID = U.ID
GO