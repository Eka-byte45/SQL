--SQLQuery7 - sp_InsertALLHolidaysFor.sql

USE PV_521_Import;
SET DATEFIRST 1;
GO
CREATE OR ALTER PROCEDURE sp_InsertAllHolidaysFor @year AS SMALLINT
AS 
BEGIN
	EXEC sp_InsertHolidaysFor @year, N'Новогодние каникулы';
	EXEC sp_InsertHolidaysFor @year, N'23 Февраля';
	EXEC sp_InsertHolidaysFor @year, N'8 Марта';
	EXEC sp_InsertHolidaysFor @year, N'Майские каникулы';
	EXEC sp_InsertHolidaysFor @year, N'Пасха';
	EXEC sp_InsertHolidaysFor @year, N'Летние каникулы';
	EXEC sp_InsertHolidaysFor @year, N'День%';
END