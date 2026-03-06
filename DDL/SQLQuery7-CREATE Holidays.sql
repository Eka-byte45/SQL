--SQLQuery7-CREATE Holidays.sql
USE PV_521_Import;

--CREATE TABLE Holidays
--(
--	holiday_id	TINYINT PRIMARY KEY,


--);

CREATE TABLE DaysOFF
(
	[date] DATE PRIMARY KEY,
	holiday TINYINT NOT NULL CONSTRAINT FK_DaysOFF_Holidays FOREIGN KEY REFERENCES Holidays(holiday_id)
);