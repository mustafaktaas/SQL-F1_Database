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
 Adý VARCHAR(30) PRIMARY KEY,
 Marka VARCHAR(20) 
 )
 GO

  CREATE TABLE Ulke
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(20) NOT NULL
 )
 GO

    CREATE TABLE Sponsor
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(20) NOT NULL
 )
 GO

    CREATE TABLE Takým
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(20) NOT NULL,
 IlkKatýlýmYýlý DATE NOT NULL,
 UlkeID INT FOREIGN KEY REFERENCES Ulke(ID)
 )
 GO

     CREATE TABLE Araç
 (
 ID INT PRIMARY KEY NOT NULL,
 Marka VARCHAR(20) NOT NULL,
 Þasi VARCHAR(20) NOT NULL,
 MotorAdý VARCHAR(30) FOREIGN KEY REFERENCES Motor(Adý),
 TakýmID INT FOREIGN KEY REFERENCES Takým(ID)
 )
 GO

 ALTER TABLE Araç
ALTER COLUMN Marka VARCHAR(35)

  CREATE TABLE Pilot
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(20) NOT NULL,
 Soyadý VARCHAR(20) NOT NULL,
 Numara INT NOT NULL,
 DoðumTarihi DATE NOT NULL,
 IlkYarýþTarihi DATE NOT NULL,
 UlkeID INT FOREIGN KEY REFERENCES Ulke(ID)
 )
 GO

   CREATE TABLE Pist
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(50) NOT NULL,
 Uzunluk FLOAT NOT NULL,
 IlkYarýþTarihi DATE NOT NULL,
 PistRekoru TIME NOT NULL,                 --sor
 ToplamYarýþUzunluðu FLOAT NOT NULL,             --sor
 UlkeID INT FOREIGN KEY REFERENCES Ulke(ID),
 PistRekoruPilotu INT FOREIGN KEY REFERENCES Pilot(ID) --sor
 )
 GO

  CREATE TABLE Þampiyona
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(20) NOT NULL,
 SezonYýlý INT NOT NULL,
 GalipPilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 GalipTakýmID INT FOREIGN KEY REFERENCES Takým(ID)
 )
 GO

--Þampiyonanýn adý 20 karakterden uzun çýkabileceði için karakter giriþini 50 ye çýkardýk
ALTER TABLE Þampiyona
ALTER COLUMN Adý VARCHAR(50)

   CREATE TABLE Yarýþ
 (
 ID INT PRIMARY KEY NOT NULL,
 Adý VARCHAR(20) NOT NULL,
 YarýþTarihi DATE NOT NULL,
 SýralamaTurTarihi DATE NOT NULL,
 AntrenmanTarihi DATE NOT NULL,
 ÞampiyonaID INT FOREIGN KEY REFERENCES Þampiyona(ID),
 PistID INT FOREIGN KEY REFERENCES Pist(ID)
 )
 GO

ALTER TABLE Yarýþ
ALTER COLUMN Adý VARCHAR(50)

  CREATE TABLE TakýmSponsorlarý
 (
 TakýmID INT FOREIGN KEY REFERENCES Takým(ID),
 SponsorID INT FOREIGN KEY REFERENCES Sponsor(ID),
-- CONSTRAINT takýmSponsorlarý PRIMARY KEY (TakýmID,SponsorID), --sor
 YýllýkSözleþmeFiyatý INT NOT NULL,
 SözleþmeBaþlangýçTarihi DATE NOT NULL,
 SözleþmeBitiþTarihi DATE NOT NULL
 )
 GO

ALTER TABLE TakýmSponsorlarý
ALTER COLUMN  YýllýkSözleþmeFiyatý FLOAT

   CREATE TABLE TakýmÞampiyonalarý
 (
 TakýmID INT FOREIGN KEY REFERENCES Takým(ID),
 ÞampiyonaID INT FOREIGN KEY REFERENCES Þampiyona(ID),
-- CONSTRAINT takýmÞampiyonalarý PRIMARY KEY (TakýmID,ÞampiyonaID),
 Puan INT NOT NULL
 )
 GO

    CREATE TABLE PilotÞampiyonalarý
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 ÞampiyonaID INT FOREIGN KEY REFERENCES Þampiyona(ID),
-- CONSTRAINT pilotÞampiyonalarý PRIMARY KEY (PilotID,ÞampiyonaID), 
 Puan INT NOT NULL
 )
 GO

    CREATE TABLE TakýmlarvePilotlarý
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 TakýmID INT FOREIGN KEY REFERENCES Takým(ID),
-- CONSTRAINT takýmlarvePilotlarý PRIMARY KEY (PilotID,TakýmID), 
 YýllýkSözleþmeFiyatý INT NOT NULL,
 SözleþmeBaþlangýçTarihi DATE NOT NULL,
 SözleþmeBitiþTarihi DATE NOT NULL
 )
 GO


     CREATE TABLE PilotYarýþTurlarý  --SOR
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 YarýþID INT FOREIGN KEY REFERENCES Yarýþ(ID),
-- CONSTRAINT pilotYarýþTurlarý PRIMARY KEY (PilotID,YarýþID), 
 Süre TIME NOT NULL,
 TurNo INT NOT NULL
 )
 GO

      CREATE TABLE HangiPilotHangiYarýþHangiAraç
 (
 PilotID INT FOREIGN KEY REFERENCES Pilot(ID),
 YarýþID INT FOREIGN KEY REFERENCES Yarýþ(ID),
 AraçID INT FOREIGN KEY REFERENCES Araç(ID),
-- CONSTRAINT pilotYarýþAraç PRIMARY KEY (PilotID,YarýþID,AraçID), 
 Puan INT NOT NULL,
 Süre TIME NOT NULL,
 Sýra INT NOT NULL
 )
 GO






