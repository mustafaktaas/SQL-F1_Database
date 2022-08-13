USE f1Veritabani
GO

--1-) Ara� Tablosunda bir arac�n ad�n� g�ncelleyelim.
UPDATE Ara� 
SET Marka = 'Aston Martin-Mercedes'
WHERE Marka = 'Aston Martin'

--2-) 2016 y�l�ndan �inde yap�lan yar���n tarihlerini g�ncelle.
UPDATE Yar��
SET Yar��Tarihi = '2016-10-12', S�ralamaTurTarihi = '2016-10-11' , AntrenmanTarihi = '2016-10-10'
WHERE Ad� = 'CHINA 2016'

--3-) Nico Rosberg adl� pilotun numaras�n� 6'dan 60 yap.
UPDATE Pilot
SET Numara = 60
WHERE Ad� = 'Nico' AND Soyad� = 'Rosberg'

--4-) Petronas sponsorunun tak�m� ile olan y�ll�k s�zle�me fiyat�n� 100.000 tl artt�r.
UPDATE Tak�mSponsorlar�
SET Y�ll�kS�zle�meFiyat� = 41100000
FROM Tak�mSponsorlar�
INNER JOIN Sponsor ON Tak�mSponsorlar�.SponsorID = Sponsor.ID
WHERE Sponsor.Ad� = 'Petronas'

--5-) Lewis Hamiltonun Styrian GP 2020 yar���ndaki s�resini 10 saniye d���r.
UPDATE HangiPilotHangiYar��HangiAra�
SET S�re = '01:23:40.2850000'
FROM HangiPilotHangiYar��HangiAra�
INNER JOIN Pilot ON HangiPilotHangiYar��HangiAra�.PilotID = Pilot.ID 
INNER JOIN Yar�� ON HangiPilotHangiYar��HangiAra�.Yar��ID = Yar��.ID
WHERE Pilot.Ad� = 'Lewis' AND Pilot.Soyad� = 'Hamilton' AND Yar��.Ad� = 'STYRIAN GP 2020'

--6-) Daniel Ricciardo pilotuna Renault tak�m�n�n verdi�i y�ll�k fiyat� 200.000 artt�r.
UPDATE Tak�mlarvePilotlar�
SET Y�ll�kS�zle�meFiyat� = 32200000
FROM Tak�mlarvePilotlar�
INNER JOIN Pilot ON Tak�mlarvePilotlar�.PilotID = Pilot.ID
INNER JOIN Tak�m ON Tak�mlarvePilotlar�.Tak�mID = Tak�m.ID
WHERE Pilot.Ad� = 'Daniel' AND Pilot.Soyad� = 'Ricciardo' AND Tak�m.Ad� = 'Renault'