USE f1Veritabani
GO

--1)Lewis Hamilton ve Max Verstappen'in birlikte bulundu�u yar��lar�n ad�, sezonun ad�, pistlerin ad� ve yar���n yap�ld��� �lkeleri getiriniz.
SELECT GP.Ad� Yar��Ad�, �MP.Ad� �ampiyonaAd�, PS.Ad� PistAd�, C.Ad� �lkeAd�
FROM HangiPilotHangiYar��HangiAra� YRS INNER JOIN Yar�� GP
    ON YRS.Yar��ID=GP.ID INNER JOIN Ara� AR
        ON YRS.Ara�ID=AR.ID INNER JOIN Pilot PL
            ON YRS.PilotID=PL.ID INNER JOIN �ampiyona �MP
                ON GP.�ampiyonaID=�MP.ID INNER JOIN Pist PS
                    ON GP.PistID=PS.ID INNER JOIN Ulke C
                        ON PS.UlkeID=C.ID
WHERE PL.Ad�='Lewis'
INTERSECT
SELECT GP.Ad� Yar��Ad�, �MP.Ad� �ampiyonaAd�, PS.Ad� PistAd�, C.Ad� �lkeAd�
FROM HangiPilotHangiYar��HangiAra� YRS INNER JOIN Yar�� GP
    ON YRS.Yar��ID=GP.ID INNER JOIN Ara� AR
        ON YRS.Ara�ID=AR.ID INNER JOIN Pilot PL
            ON YRS.PilotID=PL.ID INNER JOIN �ampiyona �MP
                ON GP.�ampiyonaID=�MP.ID INNER JOIN Pist PS
                    ON GP.PistID=PS.ID INNER JOIN Ulke C
                        ON PS.UlkeID=C.ID
WHERE PL.Ad�='Max'

--2)Tak�mlar�n yapt��� y�ll�k s�zle�me fiyat� en y�ksek olan sponsorluk anla�mas�n� tak�mlara g�re getiriniz.
WITH teams AS(SELECT T.Ad� Tak�mAd�, S.Ad�, TS.Y�ll�kS�zle�meFiyat�, ROW_NUMBER() OVER (PARTITION BY T.Ad� ORDER BY TS.Y�ll�kS�zle�meFiyat� DESC) AS rowNumber
FROM Tak�mSponsorlar� TS INNER JOIN Tak�m T
	ON TS.Tak�mID=T.ID INNER JOIN Sponsor S
					ON S.ID=TS.SponsorID)
SELECT * FROM teams
WHERE teams.rowNumber = 1

--3)�ampiyonalarda toplam olarak en fazla puan toplam�� pilotun �lkesini ve ya��n� getiriniz.
SELECT PL.Ad�,DATEDIFF(YEAR,PL.Do�umTarihi,GETDATE()) PilotYa��, U.Ad�
FROM Pilot PL INNER JOIN Ulke U
	ON PL.UlkeID=U.ID
WHERE PL.ID = (SELECT TOP 1 P.ID
FROM Pilot�ampiyonalar� P� INNER JOIN Pilot P 
	ON P�.PilotID = P.ID
GROUP BY P.ID
ORDER BY SUM(P�.Puan) DESC)

--4)Pist rekoru 1 dakika 20 saniyeden d���k olan pistlerde d�zenlenen yar��larda yar��an pilotlar� ve o yar��ta kulland�klar� arac� getiriniz.
SELECT PL.Ad�, PL.Soyad�, A.�asi, Y.Ad�
FROM Pist P INNER JOIN Yar�� Y
	ON P.ID=Y.PistID INNER JOIN HangiPilotHangiYar��HangiAra� YR�
		ON YR�.Yar��ID=Y.ID INNER JOIN Ara� A
			ON YR�.Ara�ID=A.ID INNER JOIN Pilot PL
				ON YR�.PilotID=PL.ID
WHERE P.PistRekoru<'00:01:20.00'

--5)Hi�bir yar��a kat�lmayan pilotlar�n ya�lar�n� b�y�kten k����e do�ru getiriniz.
SELECT PL.Ad�, PL.Soyad�, DATEDIFF(YEAR,PL.Do�umTarihi,GETDATE()) PilotYa��
FROM Pilot PL
WHERE PL.ID NOT IN (SELECT YRS.PilotID FROM HangiPilotHangiYar��HangiAra� YRS)
ORDER BY PilotYa�� DESC

--6)Pist rekoru k�ran pilotlar� rekor say�s�yla birlikte getiriniz.
SELECT PL.Ad�, PL.Soyad�, COUNT(PS.PistRekoruPilotu) RekorSayisi
FROM Pist PS INNER JOIN Pilot PL
	ON PS.PistRekoruPilotu=PL.ID
GROUP BY PL.Ad�, PL.Soyad�
ORDER BY RekorSayisi DESC













