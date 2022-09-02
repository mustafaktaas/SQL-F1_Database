USE f1Veritabani
GO

IF OBJECT_ID('dbo.takimDuzenle') IS NOT NULL
	BEGIN
		DROP PROCEDURE takimDuzenle
	END
GO

/* Tabloda bulunan herhangi bir takýmý düzenlemek için bir procedur yazýnýz. Eðer düzenlenmek istenen takým tabloda yoksa ekleyiniz. */

CREATE or ALTER PROCEDURE takimDuzenle(
@takimAdi VARCHAR(30),
@takimIlkKatilimYili DATE,
@ulkeAdi VARCHAR(30))
AS 
BEGIN
SET NOCOUNT ON; 
 
 BEGIN TRAN
   BEGIN TRY       
			  --Kullanýcýnýn verdiði takým adý db'de var mý kontrol ediliyor.
					IF @takimAdi NOT IN (SELECT T.Adý FROM Takým T WHERE T.Adý= @takimAdi)
					BEGIN
						--Kullanýcýnýn verdiði ülke adý db'de var mý kontrol ediliyor.
						IF @ulkeAdi NOT IN (SELECT U.Adý FROM Ulke U WHERE U.Adý= @ulkeAdi)
						BEGIN
						--Kullanýcýnýn verdiði ülke adý db'de yoksa yeni bir ülke olarak insert ediliyor.
						INSERT INTO Ulke (Adý)
						VALUES(@ulkeAdi)
						END

						--Kullanýcýnýn verdiði ülke adý db'de var fakat takýmýn adý db'de bulunmadýðý için kullanýcýnýn verdiði bilgiler doðrultusunda takým db'ye insert ediliyor.
						DECLARE @UlkeID int
						SET @UlkeID = (SELECT U.ID FROM Ulke U WHERE U.Adý = @ulkeAdi)
							INSERT INTO Takým (Adý,IlkKatýlýmYýlý,UlkeID)
							VALUES (@takimAdi,@takimIlkKatilimYili,@UlkeID);
					END

					--Kullanýcýnýn verdiði takým adý db'de varsa else kýsmý çalýþýyor.
					ELSE BEGIN

					--Kullanýcýnýn verdiði ülke adý db'de var mý kontrol ediliyor.
					IF @ulkeAdi NOT IN (SELECT U.Adý FROM Ulke U WHERE U.Adý= @ulkeAdi)
						BEGIN
						INSERT INTO Ulke (Adý)
						VALUES(@ulkeAdi)
						END
					
					--Kullanýcýnýn verdiði  bilgiler doðrultusunda takým db'de update ediliyor.
					UPDATE Takým
					SET IlkKatýlýmYýlý = @takimIlkKatilimYili , UlkeID = (SELECT U.ID FROM Ulke U WHERE U.Adý=@ulkeAdi)
					WHERE Adý = @takimAdi
					END
               
			   --Hata olmadýðý takdirde bu iþlemler commit edilir.
              COMMIT TRANSACTION
       END TRY
       BEGIN CATCH
			--Hata yakalanýldýðý takdirde rollback ile iþlemler geri alýnýr.
              ROLLBACK TRANSACTION
       END CATCH
END
GO

-- Takým tablosundaki Mercedes takýmýnýn ilk katýlým tarihi ve ülkesi deðiþtirildi.

EXEC takimDuzenle 'Mercedes', '2021-12-10', 'Turkey'
GO

-- Takým tablosunda bulunmayan Tesla takýmý tabloya eklendi. 

EXEC takimDuzenle 'Tesla', '2021-12-10', 'USA'
GO

-- Takým tablosunda bulunmayan Audi takýmý tabloya eklendi ve Ulke tablosunda bulunmayan Norway tabloya eklendi.

EXEC takimDuzenle 'Audi', '2021-12-10', 'Norway'
GO

