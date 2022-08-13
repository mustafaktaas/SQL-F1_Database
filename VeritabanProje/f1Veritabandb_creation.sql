CREATE DATABASE f1Veritabani
ON PRIMARY (
               NAME = 'f1Veritabanidb',
			   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\.mdf',
			   SIZE = 20MB,
			   MAXSIZE = 100MB,
			   FILEGROWTH = 5MB
           )
   LOG ON  (
               NAME = 'f1Veritabanidb_log',
			   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\.ldf',
			   SIZE = 5MB,
			   MAXSIZE = 50MB,
			   FILEGROWTH = 2MB
           )
 GO

 USE f1Veritabani

 CREATE TABLE Motor
 (
 Ad� VARCHAR(30) PRIMARY KEY,
 Marka VARCHAR(20) 
 )
 GO

  CREATE TABLE Ulke
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(20) NOT NULL
 )
 GO

    CREATE TABLE Sponsor
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(20) NOT NULL
 )
 GO

    CREATE TABLE Tak�m
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(20) NOT NULL,
 IlkKat�l�mY�l� DATE NOT NULL,
 UlkeID INT FOREIGN KEY REFERENCES Ulke(ID)
 )
 GO

     CREATE TABLE Ara�
 (
 ID INT PRIMARY KEY NOT NULL,
 Marka VARCHAR(20) NOT NULL,
 �asi VARCHAR(20) NOT NULL,
 MotorAd� VARCHAR(30) FOREIGN KEY REFERENCES Motor(Ad�),
 Tak�mID INT FOREIGN KEY REFERENCES Tak�m(ID)
 )
 GO

 ALTER TABLE Ara�
ALTER COLUMN Marka VARCHAR(35)

  CREATE TABLE Pilot
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(20) NOT NULL,
 Soyad� VARCHAR(20) NOT NULL,
 Numara INT NOT NULL,
 Do�umTarihi DATE NOT NULL,
 IlkYar��Tarihi DATE NOT NULL,
 UlkeID INT FOREIGN KEY REFERENCES Ulke(ID)
 )
 GO

   CREATE TABLE Pist
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(50) NOT NULL,
 Uzunluk FLOAT NOT NULL,
 IlkYar��Tarihi DATE NOT NULL,
 PistRekoru TIME NOT NULL,                 --sor
 ToplamYar��Uzunlu�u FLOAT NOT NULL,             --sor
 UlkeID INT FOREIGN KEY REFERENCES Ulke(ID),
 PistRekoruPilotu INT FOREIGN KEY REFERENCES Pilot(ID) --sor
 )
 GO

  CREATE TABLE �ampiyona
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(20) NOT NULL,
 SezonY�l� INT NOT NULL,
 GalipPilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 GalipTak�mID INT FOREIGN KEY REFERENCES Tak�m(ID)
 )
 GO

--�ampiyonan�n ad� 20 karakterden uzun ��kabilece�i i�in karakter giri�ini 50 ye ��kard�k
ALTER TABLE �ampiyona
ALTER COLUMN Ad� VARCHAR(50)

   CREATE TABLE Yar��
 (
 ID INT PRIMARY KEY NOT NULL,
 Ad� VARCHAR(20) NOT NULL,
 Yar��Tarihi DATE NOT NULL,
 S�ralamaTurTarihi DATE NOT NULL,
 AntrenmanTarihi DATE NOT NULL,
 �ampiyonaID INT FOREIGN KEY REFERENCES �ampiyona(ID),
 PistID INT FOREIGN KEY REFERENCES Pist(ID)
 )
 GO

ALTER TABLE Yar��
ALTER COLUMN Ad� VARCHAR(50)

  CREATE TABLE Tak�mSponsorlar�
 (
 Tak�mID INT FOREIGN KEY REFERENCES Tak�m(ID),
 SponsorID INT FOREIGN KEY REFERENCES Sponsor(ID),
-- CONSTRAINT tak�mSponsorlar� PRIMARY KEY (Tak�mID,SponsorID), --sor
 Y�ll�kS�zle�meFiyat� INT NOT NULL,
 S�zle�meBa�lang��Tarihi DATE NOT NULL,
 S�zle�meBiti�Tarihi DATE NOT NULL
 )
 GO

ALTER TABLE Tak�mSponsorlar�
ALTER COLUMN  Y�ll�kS�zle�meFiyat� FLOAT

   CREATE TABLE Tak�m�ampiyonalar�
 (
 Tak�mID INT FOREIGN KEY REFERENCES Tak�m(ID),
 �ampiyonaID INT FOREIGN KEY REFERENCES �ampiyona(ID),
-- CONSTRAINT tak�m�ampiyonalar� PRIMARY KEY (Tak�mID,�ampiyonaID),
 Puan INT NOT NULL
 )
 GO

    CREATE TABLE Pilot�ampiyonalar�
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 �ampiyonaID INT FOREIGN KEY REFERENCES �ampiyona(ID),
-- CONSTRAINT pilot�ampiyonalar� PRIMARY KEY (PilotID,�ampiyonaID), 
 Puan INT NOT NULL
 )
 GO

    CREATE TABLE Tak�mlarvePilotlar�
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 Tak�mID INT FOREIGN KEY REFERENCES Tak�m(ID),
-- CONSTRAINT tak�mlarvePilotlar� PRIMARY KEY (PilotID,Tak�mID), 
 Y�ll�kS�zle�meFiyat� INT NOT NULL,
 S�zle�meBa�lang��Tarihi DATE NOT NULL,
 S�zle�meBiti�Tarihi DATE NOT NULL
 )
 GO


     CREATE TABLE PilotYar��Turlar�  --SOR
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 Yar��ID INT FOREIGN KEY REFERENCES Yar��(ID),
-- CONSTRAINT pilotYar��Turlar� PRIMARY KEY (PilotID,Yar��ID), 
 S�re TIME NOT NULL,
 TurNo INT NOT NULL
 )
 GO

      CREATE TABLE HangiPilotHangiYar��HangiAra�
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 Yar��ID INT FOREIGN KEY REFERENCES Yar��(ID),
 Ara�ID INT FOREIGN KEY REFERENCES Ara�(ID),
-- CONSTRAINT pilotYar��Ara� PRIMARY KEY (PilotID,Yar��ID,Ara�ID), 
 Puan INT NOT NULL,
 S�re TIME NOT NULL,
 S�ra INT NOT NULL
 )
 GO






