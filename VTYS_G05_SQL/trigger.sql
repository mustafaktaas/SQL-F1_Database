USE f1Veritabani
GO

--!!!!!!  �NEML�  !!!!!
--TRIGGER'dan �nce Tak�m adl� tabloya Kay�tTarihi kolonunu ekliyoruz.

ALTER TABLE Tak�m
ADD Kay�tTarihi DATE
GO

IF OBJECT_ID ('trgtakimDuzenle') IS NOT NULL
	BEGIN
		DROP TRIGGER trgtakimDuzenle
	END
GO

/* Tak�mlar�n ilk kat�l�m tarihi g�n�m�zden ileri bir tarih olmas� durumunda yeni bir tak�m eklenmesi veya tak�mlar�n g�ncellenmesini engelleyen trigger� yaz�n�z.
E�er do�ru tarih ile veri eklenir veya g�ncellenirse bu i�lemin yap�ld��� tarihi getiriniz. */

CREATE OR ALTER TRIGGER trgtakimDuzenle ON Tak�m FOR INSERT , UPDATE  AS

DECLARE @Tak�mID TABLE ( ID INT )
DECLARE @ilkKat�l�mTarihi DATE = (SELECT IlkKat�l�mY�l� FROM inserted)

INSERT INTO @Tak�mID SELECT ID FROM inserted

IF (@ilkKat�l�mTarihi > GETDATE())
	BEGIN
		ROLLBACK	 
		PRINT('�lk kat�l�m tarihi g�n�m�z tarihinden sonra olamaz.')
	END
ELSE
	UPDATE Tak�m SET Kay�tTarihi=GETDATE() WHERE ID IN (SELECT ID FROM @Tak�mID)
GO

-- �ncelikle do�ru bir �rnek deneyelim. Burada veri yine ayn� �ekilde tabloya eklenir ve kay�t tarihi de kolonuna yaz�l�r.

EXEC takimDuzenle 'Tesla', '2020-12-30', 'USA'
GO

-- �imdi ise ilkKat�l�mTarihi s�tununa g�n�m�zden ileri bir tarih yazarak yanl�� bir �rnek deneyelim.

EXEC takimDuzenle 'Tesla', '2023-12-30', 'USA'
GO


--Ek olarak SP'de bulunan catch blo�u ek bir hata f�rlat�yor. Ancak bizim procedurumuz ve trigger�m�zda bir sorun yaratm�yor.
