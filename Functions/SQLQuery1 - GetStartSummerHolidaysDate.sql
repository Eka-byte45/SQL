--SQLQuery1 - GetSummerHolidaysStartDate.sql

USE PV_521_Import;

SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetSummerHolidaysStartDate(@year AS SMALLINT) RETURNS DATE
AS
BEGIN
	DECLARE @august		AS DATE		= DATEFROMPARTS(@year,08,01);
	DECLARE @weekday	AS TINYINT	= DATEPART(WEEKDAY,@august);
	DECLARE @start_date AS DATE		= DATEADD(DAY,-@weekday+1,@august);
	RETURN @start_date;
END