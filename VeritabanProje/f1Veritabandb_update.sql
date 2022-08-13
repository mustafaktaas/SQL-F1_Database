USE f1Veritabani
GO

--1-) Araç Tablosunda bir aracýn adýný güncelleyelim.
UPDATE Araç 
SET Marka = 'Aston Martin-Mercedes'
WHERE Marka = 'Aston Martin'

--2-) 2016 yýlýndan çinde yapýlan yarýþýn tarihlerini güncelle.
UPDATE Yarýþ
SET YarýþTarihi = '2016-10-12', SýralamaTurTarihi = '2016-10-11' , AntrenmanTarihi = '2016-10-10'
WHERE Adý = 'CHINA 2016'

--3-) Nico Rosberg adlý pilotun numarasýný 6'dan 60 yap.
UPDATE Pilot
SET Numara = 60
WHERE Adý = 'Nico' AND Soyadý = 'Rosberg'

--4-) Petronas sponsorunun takýmý ile olan yýllýk sözleþme fiyatýný 100.000 tl arttýr.
UPDATE TakýmSponsorlarý
SET YýllýkSözleþmeFiyatý = 41100000
FROM TakýmSponsorlarý
INNER JOIN Sponsor ON TakýmSponsorlarý.SponsorID = Sponsor.ID
WHERE Sponsor.Adý = 'Petronas'

--5-) Lewis Hamiltonun Styrian GP 2020 yarýþýndaki süresini 10 saniye düþür.
UPDATE HangiPilotHangiYarýþHangiAraç
SET Süre = '01:23:40.2850000'
FROM HangiPilotHangiYarýþHangiAraç
INNER JOIN Pilot ON HangiPilotHangiYarýþHangiAraç.PilotID = Pilot.ID 
INNER JOIN Yarýþ ON HangiPilotHangiYarýþHangiAraç.YarýþID = Yarýþ.ID
WHERE Pilot.Adý = 'Lewis' AND Pilot.Soyadý = 'Hamilton' AND Yarýþ.Adý = 'STYRIAN GP 2020'

--6-) Daniel Ricciardo pilotuna Renault takýmýnýn verdiði yýllýk fiyatý 200.000 arttýr.
UPDATE TakýmlarvePilotlarý
SET YýllýkSözleþmeFiyatý = 32200000
FROM TakýmlarvePilotlarý
INNER JOIN Pilot ON TakýmlarvePilotlarý.PilotID = Pilot.ID
INNER JOIN Takým ON TakýmlarvePilotlarý.TakýmID = Takým.ID
WHERE Pilot.Adý = 'Daniel' AND Pilot.Soyadý = 'Ricciardo' AND Takým.Adý = 'Renault'