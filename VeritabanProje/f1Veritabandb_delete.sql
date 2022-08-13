USE f1Veritabani
GO

--1)Yar�� tablomuzdan 2017 sezon �ampiyonas�ndaki yap�lm�� yar��lar� siliyoruz.
DELETE 
FROM Yar�� 
WHERE �ampiyonaID = (SELECT ID FROM �ampiyona WHERE Ad� = 'F1 2017 World Championship')

--2)Pilot tablomuzdan ya�� 60 dan b�y�k pilotlar�m�z� siliyoruz.
DELETE 
FROM Pilot 
WHERE DATEDIFF(YEAR,Do�umTarihi,GETDATE()) > 60

--3)2019 sezon y�l� �ampiyonas�nda 4 puan alan tak�m� tak�m �ampiyona tablomuzdan ��kar�yoruz.
DELETE 
FROM Tak�m�ampiyonalar�
WHERE �ampiyonaID = (SELECT �ampiyonaID FROM �ampiyona WHERE Ad� = 'F1 2019 World Championship') AND Puan = 4

--4)Y�ll�k s�zle�me fiyat� 100000'den az olan tak�m sponsorluklar�n� siliniz.
DELETE TS
FROM Tak�m T INNER JOIN Tak�mSponsorlar� TS ON T.ID = TS.Tak�mID
WHERE TS.Tak�mID IN (SELECT T.ID FROM Tak�m T INNER JOIN Tak�mSponsorlar� TS ON T.ID = TS.Tak�mID WHERE TS.Y�ll�kS�zle�meFiyat� < 100000) 

--5)Tak�mlar ile pilotlar�n y�ll�k s�zle�me fiyatlar� 500000 ile 700000 aras� olan verileri siliniz.
DELETE 
FROM Tak�mlarvePilotlar� 
WHERE Y�ll�kS�zle�meFiyat� BETWEEN 500000 AND 700000

--6)�ampiyona tablosunda olmayan tak�mlar� siliniz.
DELETE 
FROM Tak�m
WHERE NOT EXISTS (SELECT* FROM Tak�m�ampiyonalar� T� WHERE T�.Tak�mID=Tak�m.ID)
