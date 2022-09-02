USE f1Veritabani
GO

--!!!!!!  ÖNEMLÝ  !!!!!
--TRIGGER'dan önce Takým adlý tabloya KayýtTarihi kolonunu ekliyoruz.

ALTER TABLE Takým
ADD KayýtTarihi DATE
GO

IF OBJECT_ID ('trgtakimDuzenle') IS NOT NULL
	BEGIN
		DROP TRIGGER trgtakimDuzenle
	END
GO

/* Takýmlarýn ilk katýlým tarihi günümüzden ileri bir tarih olmasý durumunda yeni bir takým eklenmesi veya takýmlarýn güncellenmesini engelleyen triggerý yazýnýz.
Eðer doðru tarih ile veri eklenir veya güncellenirse bu iþlemin yapýldýðý tarihi getiriniz. */

CREATE OR ALTER TRIGGER trgtakimDuzenle ON Takým FOR INSERT , UPDATE  AS

DECLARE @TakýmID TABLE ( ID INT )
DECLARE @ilkKatýlýmTarihi DATE = (SELECT IlkKatýlýmYýlý FROM inserted)

INSERT INTO @TakýmID SELECT ID FROM inserted

IF (@ilkKatýlýmTarihi > GETDATE())
	BEGIN
		ROLLBACK	 
		PRINT('Ýlk katýlým tarihi günümüz tarihinden sonra olamaz.')
	END
ELSE
	UPDATE Takým SET KayýtTarihi=GETDATE() WHERE ID IN (SELECT ID FROM @TakýmID)
GO

-- Öncelikle doðru bir örnek deneyelim. Burada veri yine ayný þekilde tabloya eklenir ve kayýt tarihi de kolonuna yazýlýr.

EXEC takimDuzenle 'Tesla', '2020-12-30', 'USA'
GO

-- Þimdi ise ilkKatýlýmTarihi sütununa günümüzden ileri bir tarih yazarak yanlýþ bir örnek deneyelim.

EXEC takimDuzenle 'Tesla', '2023-12-30', 'USA'
GO


--Ek olarak SP'de bulunan catch bloðu ek bir hata fýrlatýyor. Ancak bizim procedurumuz ve triggerýmýzda bir sorun yaratmýyor.
