USE f1Veritabani
GO

--1)Lewis Hamilton ve Max Verstappen'in birlikte bulunduðu yarýþlarýn adý, sezonun adý, pistlerin adý ve yarýþýn yapýldýðý ülkeleri getiriniz.
SELECT GP.Adý YarýþAdý, ÞMP.Adý ÞampiyonaAdý, PS.Adý PistAdý, C.Adý ÜlkeAdý
FROM HangiPilotHangiYarýþHangiAraç YRS INNER JOIN Yarýþ GP
    ON YRS.YarýþID=GP.ID INNER JOIN Araç AR
        ON YRS.AraçID=AR.ID INNER JOIN Pilot PL
            ON YRS.PilotID=PL.ID INNER JOIN Þampiyona ÞMP
                ON GP.ÞampiyonaID=ÞMP.ID INNER JOIN Pist PS
                    ON GP.PistID=PS.ID INNER JOIN Ulke C
                        ON PS.UlkeID=C.ID
WHERE PL.Adý='Lewis'
INTERSECT
SELECT GP.Adý YarýþAdý, ÞMP.Adý ÞampiyonaAdý, PS.Adý PistAdý, C.Adý ÜlkeAdý
FROM HangiPilotHangiYarýþHangiAraç YRS INNER JOIN Yarýþ GP
    ON YRS.YarýþID=GP.ID INNER JOIN Araç AR
        ON YRS.AraçID=AR.ID INNER JOIN Pilot PL
            ON YRS.PilotID=PL.ID INNER JOIN Þampiyona ÞMP
                ON GP.ÞampiyonaID=ÞMP.ID INNER JOIN Pist PS
                    ON GP.PistID=PS.ID INNER JOIN Ulke C
                        ON PS.UlkeID=C.ID
WHERE PL.Adý='Max'

--2)Takýmlarýn yaptýðý yýllýk sözleþme fiyatý en yüksek olan sponsorluk anlaþmasýný takýmlara göre getiriniz.
WITH teams AS(SELECT T.Adý TakýmAdý, S.Adý, TS.YýllýkSözleþmeFiyatý, ROW_NUMBER() OVER (PARTITION BY T.Adý ORDER BY TS.YýllýkSözleþmeFiyatý DESC) AS rowNumber
FROM TakýmSponsorlarý TS INNER JOIN Takým T
	ON TS.TakýmID=T.ID INNER JOIN Sponsor S
					ON S.ID=TS.SponsorID)
SELECT * FROM teams
WHERE teams.rowNumber = 1

--3)Þampiyonalarda toplam olarak en fazla puan toplamýþ pilotun ülkesini ve yaþýný getiriniz.
SELECT PL.Adý,DATEDIFF(YEAR,PL.DoðumTarihi,GETDATE()) PilotYaþý, U.Adý
FROM Pilot PL INNER JOIN Ulke U
	ON PL.UlkeID=U.ID
WHERE PL.ID = (SELECT TOP 1 P.ID
FROM PilotÞampiyonalarý PÞ INNER JOIN Pilot P 
	ON PÞ.PilotID = P.ID
GROUP BY P.ID
ORDER BY SUM(PÞ.Puan) DESC)

--4)Pist rekoru 1 dakika 20 saniyeden düþük olan pistlerde düzenlenen yarýþlarda yarýþan pilotlarý ve o yarýþta kullandýklarý aracý getiriniz.
SELECT PL.Adý, PL.Soyadý, A.Þasi, Y.Adý
FROM Pist P INNER JOIN Yarýþ Y
	ON P.ID=Y.PistID INNER JOIN HangiPilotHangiYarýþHangiAraç YRÞ
		ON YRÞ.YarýþID=Y.ID INNER JOIN Araç A
			ON YRÞ.AraçID=A.ID INNER JOIN Pilot PL
				ON YRÞ.PilotID=PL.ID
WHERE P.PistRekoru<'00:01:20.00'

--5)Hiçbir yarýþa katýlmayan pilotlarýn yaþlarýný büyükten küçüðe doðru getiriniz.
SELECT PL.Adý, PL.Soyadý, DATEDIFF(YEAR,PL.DoðumTarihi,GETDATE()) PilotYaþý
FROM Pilot PL
WHERE PL.ID NOT IN (SELECT YRS.PilotID FROM HangiPilotHangiYarýþHangiAraç YRS)
ORDER BY PilotYaþý DESC

--6)Pist rekoru kýran pilotlarý rekor sayýsýyla birlikte getiriniz.
SELECT PL.Adý, PL.Soyadý, COUNT(PS.PistRekoruPilotu) RekorSayisi
FROM Pist PS INNER JOIN Pilot PL
	ON PS.PistRekoruPilotu=PL.ID
GROUP BY PL.Adý, PL.Soyadý
ORDER BY RekorSayisi DESC













