--SQLQuery1 - GetHolidayStartDate.sql

USE PV_521_Import;
SET DATEFIRST 1;

GO
CREATE OR ALTER FUNCTION GetHolidayStartDate(@holiday NVARCHAR(50),@year SMALLINT) RETURNS DATE
AS
BEGIN
	DECLARE @day AS TINYINT		= (SELECT [day] FROM Holidays WHERE holiday_name = @holiday);
	DECLARE @month AS TINYINT	= (SELECT [month] FROM Holidays WHERE holiday_name = @holiday);
	DECLARE @start_date AS DATE = 
	(
		CASE
		WHEN @holiday = N'Новогодние каникулы'	THEN dbo.GetNewYearHolidayStartDate(@year)
		WHEN @holiday = N'Летние каникулы'		THEN dbo.GetSummerHolidaysStartDate(@year)
		--Добавить Пасху
		WHEN @day!=0 AND @month!=0				THEN DATEFROMPARTS(@year,@month,@day)
		END
	)
	RETURN @start_date;
END