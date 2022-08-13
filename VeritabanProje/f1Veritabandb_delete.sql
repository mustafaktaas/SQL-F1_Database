USE f1Veritabani
GO

--1)Yarýþ tablomuzdan 2017 sezon þampiyonasýndaki yapýlmýþ yarýþlarý siliyoruz.
DELETE 
FROM Yarýþ 
WHERE ÞampiyonaID = (SELECT ID FROM Þampiyona WHERE Adý = 'F1 2017 World Championship')

--2)Pilot tablomuzdan yaþý 60 dan büyük pilotlarýmýzý siliyoruz.
DELETE 
FROM Pilot 
WHERE DATEDIFF(YEAR,DoðumTarihi,GETDATE()) > 60

--3)2019 sezon yýlý þampiyonasýnda 4 puan alan takýmý takým þampiyona tablomuzdan çýkarýyoruz.
DELETE 
FROM TakýmÞampiyonalarý
WHERE ÞampiyonaID = (SELECT ÞampiyonaID FROM Þampiyona WHERE Adý = 'F1 2019 World Championship') AND Puan = 4

--4)Yýllýk sözleþme fiyatý 100000'den az olan takým sponsorluklarýný siliniz.
DELETE TS
FROM Takým T INNER JOIN TakýmSponsorlarý TS ON T.ID = TS.TakýmID
WHERE TS.TakýmID IN (SELECT T.ID FROM Takým T INNER JOIN TakýmSponsorlarý TS ON T.ID = TS.TakýmID WHERE TS.YýllýkSözleþmeFiyatý < 100000) 

--5)Takýmlar ile pilotlarýn yýllýk sözleþme fiyatlarý 500000 ile 700000 arasý olan verileri siliniz.
DELETE 
FROM TakýmlarvePilotlarý 
WHERE YýllýkSözleþmeFiyatý BETWEEN 500000 AND 700000

--6)Þampiyona tablosunda olmayan takýmlarý siliniz.
DELETE 
FROM Takým
WHERE NOT EXISTS (SELECT* FROM TakýmÞampiyonalarý TÞ WHERE TÞ.TakýmID=Takým.ID)
