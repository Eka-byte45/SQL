--SQLQuery1 - HW.sql
USE PV_521_Import;

--Пишу запрос, который будет возвращать мне дату последнего занятия из таблицы Schedule по названию группы
--SELECT MAX([date]) FROM Schedule WHERE [group]=521;
--EXEC sp_SelectScheduleFor N'PV_521';

--ФУНКЦИЯ,КОТОРАЯ ВОЗВРАЩАЕТ ДАТУ ПОСЛЕДНЕГО ЗАНЯТИЯ У ДАННОЙ ГРУППЫ
--GO
--CREATE OR ALTER FUNCTION dbo.GetLastLearningDate(@group_id AS INT) RETURNS DATE
--AS
--BEGIN
--	RETURN (SELECT MAX([date]) FROM Schedule WHERE [group]=@group_id);
--END


--SELECT dbo.GetlastLearningDate(521);

----Запрос, который возвращает учебные дни по битовой маске для группы 521
--SELECT weekdays FROM Groups WHERE group_name ='PV_521';

--ФУНКЦИЯ, КОТОРАЯ ВОЗВРАЩАЕТ БИТОВУЮ МАСКУ ПО КОТОРОЙ ПРЕДСТАВЛЕНЫ ДНИ НЕДЕЛИ, В КОТОРОЙ ОБУЧАЮТС СТУДЕНТЫ
--GO
--CREATE OR ALTER FUNCTION dbo.GetStudyDaysMask(@group_id AS INT) RETURNS TINYINT
--AS BEGIN
--	DECLARE @study_days_mask TINYINT;
--	SELECT @study_days_mask = weekdays FROM Groups WHERE group_id=@group_id;
--	RETURN @study_days_mask;
--END

--ФУНКЦИЯ, КОТОРАЯ ОПРЕДЕЛЯЕТ В КАКОЙ ДЕНЬ НЕДЕЛИ БУДЕТ СЛЕДУЮЩЕЕ ЗАНЯТИЕ У ГРУППЫ
--GO
--CREATE OR ALTER FUNCTION dbo.GetNextLearningDay (@group_id AS INT) RETURNS TINYINT
--AS
--BEGIN
--    DECLARE @last_lesson_date DATE;--ДАТА ПОСЛЕДНЕГО ЗАНЯТИЯ У ГРУППЫ
--    DECLARE @study_days_mask TINYINT;--БИТОВАЯ МАСКА УЧЕБНЫХ ДНЕЙ ГРУППЫ
--    DECLARE @next_lesson_date DATE; --ДАТА СЛЕДУЮЩЕГО ЗАНЯТИЯ

--    -- Здесь находим последнюю дату занятия группы
--    SET @last_lesson_date = dbo.GetLastLearningDate(@group_id);

--    SET @study_days_mask = dbo.GetStudyDaysMask(@group_id);

--    -- Следующий день после последнего занятия
--    DECLARE @current_date DATE = DATEADD(DAY, 1, @last_lesson_date);

--    WHILE 1=1--бесконечный цикл
--    BEGIN
--        DECLARE @week_day_number TINYINT = DATEPART(WEEKDAY, @current_date);

--        -- Проверяем, соответствует ли день маске учебных дней
--        IF ((@study_days_mask & POWER(2, @week_day_number)) > 0)
--        BEGIN
--            SET @next_lesson_date = @current_date;
--            BREAK;
--        END

--        -- Перебераем далее
--        SET @current_date = DATEADD(DAY, 1, @current_date);
--    END

--    --Здесь возвращаем название дня недели
--    RETURN DATEPART(WEEKDAY, @next_lesson_date);
--END
--GO

--SELECT dbo.GetNextLearningDay(521); 

--ФУНКЦИЯ, КОТОРАЯ ОПРЕДЕЛЯЕТ ДАТУ СЛЕДУЮЩЕГО ЗАНЯТИЯ У ГРУППЫ

--GO
--CREATE OR ALTER FUNCTION dbo.GetNextLearningDate (@group_id AS INT) RETURNS DATE
--AS
--BEGIN
--    DECLARE @last_lesson_date DATE;--ДАТА ПОСЛЕДНЕГО ЗАНЯТИЯ У ГРУППЫ
--    DECLARE @study_days_mask TINYINT;--БИТОВАЯ МАСКА УЧЕБНЫХ ДНЕЙ ГРУППЫ
--    DECLARE @next_lesson_date DATE; --ДАТА СЛЕДУЮЩЕГО ЗАНЯТИЯ

--    -- Здесь находим последнюю дату занятия группы
--    SET @last_lesson_date = dbo.GetLastLearningDate(@group_id);

--    SET @study_days_mask = dbo.GetStudyDaysMask(@group_id);

--    -- Следующий день после последнего занятия
--    DECLARE @current_date DATE = DATEADD(DAY, 1, @last_lesson_date);

--    WHILE 1=1--бесконечный цикл
--    BEGIN
--        DECLARE @week_day_number TINYINT = DATEPART(WEEKDAY, @current_date);

--        -- Проверяем, соответствует ли день маске учебных дней
--        IF ((@study_days_mask & POWER(2, @week_day_number)) > 0)
--        BEGIN
--            SET @next_lesson_date = @current_date;
--            BREAK;
--        END
--        SET @current_date = DATEADD(DAY, 1, @current_date);
--    END
--    RETURN @next_lesson_date;
--END
--GO

--SELECT dbo.GetNextLearningDate(521); 