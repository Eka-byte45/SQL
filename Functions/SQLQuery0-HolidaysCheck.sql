--SQLQuery0-HolidaysCheck.sql

USE PV_521_Import;
SET DATEFIRST 1;

--PRINT dbo.GetNewYearHolidayStartDate(2026);
--PRINT dbo.GetSummerHolidaysStartDate(2026);
--PRINT dbo.GetMayHolidaysStartDate(2026);

--EXEC sp_AddHolidays 2026, 'Новогодние каникулы';
--EXEC sp_AddHolidays 2026, 'Майские каникулы';
--EXEC sp_AddHolidays 2026, 'Летние каникулы';
--EXEC sp_AddHolidays 2026, '23 Февраля';
--EXEC sp_AddHolidays 2026, '8 Марта';
--EXEC sp_AddHolidays 2026, 'День народного единства';
PRINT dbo.GetSummerHolidaysStartDate(2023);
--SELECT *FROM DaysOFF;