USE f1Veritabani
GO

IF OBJECT_ID('dbo.takimDuzenle') IS NOT NULL
	BEGIN
		DROP PROCEDURE takimDuzenle
	END
GO

/* Tabloda bulunan herhangi bir tak�m� d�zenlemek i�in bir procedur yaz�n�z. E�er d�zenlenmek istenen tak�m tabloda yoksa ekleyiniz. */

CREATE or ALTER PROCEDURE takimDuzenle(
@takimAdi VARCHAR(30),
@takimIlkKatilimYili DATE,
@ulkeAdi VARCHAR(30))
AS 
BEGIN
SET NOCOUNT ON; 
 
 BEGIN TRAN
   BEGIN TRY       
			  --Kullan�c�n�n verdi�i tak�m ad� db'de var m� kontrol ediliyor.
					IF @takimAdi NOT IN (SELECT T.Ad� FROM Tak�m T WHERE T.Ad�= @takimAdi)
					BEGIN
						--Kullan�c�n�n verdi�i �lke ad� db'de var m� kontrol ediliyor.
						IF @ulkeAdi NOT IN (SELECT U.Ad� FROM Ulke U WHERE U.Ad�= @ulkeAdi)
						BEGIN
						--Kullan�c�n�n verdi�i �lke ad� db'de yoksa yeni bir �lke olarak insert ediliyor.
						INSERT INTO Ulke (Ad�)
						VALUES(@ulkeAdi)
						END

						--Kullan�c�n�n verdi�i �lke ad� db'de var fakat tak�m�n ad� db'de bulunmad��� i�in kullan�c�n�n verdi�i bilgiler do�rultusunda tak�m db'ye insert ediliyor.
						DECLARE @UlkeID int
						SET @UlkeID = (SELECT U.ID FROM Ulke U WHERE U.Ad� = @ulkeAdi)
							INSERT INTO Tak�m (Ad�,IlkKat�l�mY�l�,UlkeID)
							VALUES (@takimAdi,@takimIlkKatilimYili,@UlkeID);
					END

					--Kullan�c�n�n verdi�i tak�m ad� db'de varsa else k�sm� �al���yor.
					ELSE BEGIN

					--Kullan�c�n�n verdi�i �lke ad� db'de var m� kontrol ediliyor.
					IF @ulkeAdi NOT IN (SELECT U.Ad� FROM Ulke U WHERE U.Ad�= @ulkeAdi)
						BEGIN
						INSERT INTO Ulke (Ad�)
						VALUES(@ulkeAdi)
						END
					
					--Kullan�c�n�n verdi�i  bilgiler do�rultusunda tak�m db'de update ediliyor.
					UPDATE Tak�m
					SET IlkKat�l�mY�l� = @takimIlkKatilimYili , UlkeID = (SELECT U.ID FROM Ulke U WHERE U.Ad�=@ulkeAdi)
					WHERE Ad� = @takimAdi
					END
               
			   --Hata olmad��� takdirde bu i�lemler commit edilir.
              COMMIT TRANSACTION
       END TRY
       BEGIN CATCH
			--Hata yakalan�ld��� takdirde rollback ile i�lemler geri al�n�r.
              ROLLBACK TRANSACTION
       END CATCH
END
GO

-- Tak�m tablosundaki Mercedes tak�m�n�n ilk kat�l�m tarihi ve �lkesi de�i�tirildi.

EXEC takimDuzenle 'Mercedes', '2021-12-10', 'Turkey'
GO

-- Tak�m tablosunda bulunmayan Tesla tak�m� tabloya eklendi. 

EXEC takimDuzenle 'Tesla', '2021-12-10', 'USA'
GO

-- Tak�m tablosunda bulunmayan Audi tak�m� tabloya eklendi ve Ulke tablosunda bulunmayan Norway tabloya eklendi.

EXEC takimDuzenle 'Audi', '2021-12-10', 'Norway'
GO

