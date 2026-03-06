--SQLQuery0 - Chek.sql
USE PV_521_Import;

SET DATEFIRST 1;

--EXEC sp_SelectScheduleFor N'PV_521'
--PRINT dbo.GetNextLearningDay(N'PV_521',DEFAULT);
--PRINT dbo.GetNextLearningDay(N'PV_521',N'2026-03-05');
--PRINT dbo.GetNextLearningDate(N'VPU_311',N'2026-03-07')

--PRINT dbo.GetNextLearningDate(N'PV_521',N'2026-03-09');
--EXEC sp_SelectScheduleFor N'PV_319'
--PRINT dbo.GetNextLearningDay(N'PV_319');

--EXEC sp_SelectScheduleFor N'java_326'
--PRINT dbo.GetNextLearningDay(N'java_326');

PRINT dbo.GetEasterDate(2025);

