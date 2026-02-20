--SQLQuery4 INSERT SCHEDULE.sql

USE PV_521_Import;
SELECT* FROM Schedule;
--SELECT *FROM Teachers;
--SELECT *FROM Disciplines;
--SELECT *FROM Holidays;

--SELECT* FROM Groups;

--INSERT INTO Groups (group_id, group_name,direction,weekdays,start_time)
--VALUES (521,'PV_521',1,42,'18:30');

--DELETE FROM Groups
--WHERE group_id = 320;

--Вставка в расписание одного занятия

--INSERT INTO Schedule([group], discipline, teacher, [date], [time], spent)
--VALUES
--(
--    (SELECT group_id FROM Groups WHERE group_name = 'PV_521'),
--    (SELECT discipline_id FROM Disciplines WHERE discipline_name='Теория баз данных, программирование MS SQL Server'),
--    (SELECT teacher_id FROM Teachers WHERE last_name = 'Ковтун'),
--    '2026-02-18',
--    '18:30',
--    0
--);

--DELETE FROM Schedule
--WHERE lesson_id =12815

--DELETE FROM Schedule
--WHERE lesson_id BETWEEN 12985 AND 13032;


--Вставка в расписание одной дисциплины
--DECLARE @StartDate DATETIME = '2026-01-26';
--DECLARE @EndDate DATETIME = '2026-02-20';
--DECLARE @CurrentDate DATETIME = @StartDate;
--DECLARE @LessonCount INT = 0;
--DECLARE @TotalLesson INT = 24;

--WHILE @LessonCount < @TotalLesson
--BEGIN
--    IF DATENAME(WEEKDAY, @CurrentDate) IN ('Monday', 'Wednesday', 'Friday') BEGIN
--        -- Проверяем, не является ли текущий день праздником
--        IF NOT EXISTS (
--            SELECT 1 FROM Holidays 
--            WHERE duration > 1
--               AND @CurrentDate BETWEEN 
--                   DATEADD(MONTH, COALESCE(month, MONTH(@CurrentDate)), 
--                           DATEADD(YEAR, YEAR(@CurrentDate)-YEAR('2000'), 
--                                   DATEPART(dd, COALESCE(day, DAY(@CurrentDate)))))
--                       AND DATEADD(DAY, duration-1, 
--                                  DATEADD(MONTH, COALESCE(month, MONTH(@CurrentDate)), 
--                                          DATEADD(YEAR, YEAR(@CurrentDate)-YEAR('2000'), 
--                                                  DATEPART(dd, COALESCE(day, DAY(@CurrentDate))))))
--           OR (duration = 1
--               AND month = MONTH(@CurrentDate)
--               AND day = DAY(@CurrentDate))
--        )
--        BEGIN
--            -- Первая пара
--            INSERT INTO Schedule([group], discipline, teacher, [date], [time], spent)
--            VALUES
--            (
--                (SELECT group_id FROM Groups WHERE group_name = 'PV_521'),
--                (SELECT discipline_id FROM Disciplines WHERE discipline_name='Теория баз данных, программирование MS SQL Server'),
--                (SELECT teacher_id FROM Teachers WHERE last_name = 'Ковтун'),
--                @CurrentDate,
--                '18:30',
--                0
--            );
            
--            -- Вторая пара
--            INSERT INTO Schedule([group], discipline, teacher, [date], [time], spent)
--            VALUES
--            (
--                (SELECT group_id FROM Groups WHERE group_name = 'PV_521'),
--                (SELECT discipline_id FROM Disciplines WHERE discipline_name='Теория баз данных, программирование MS SQL Server'),
--                (SELECT teacher_id FROM Teachers WHERE last_name = 'Ковтун'),
--                @CurrentDate,
--                '20:00',
--                0
--            );
            
--            -- Увеличиваем счётчик пар на 2
--            SET @LessonCount += 2;
--        END
--    END
--    -- Переход к следующему дню
--    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
--END