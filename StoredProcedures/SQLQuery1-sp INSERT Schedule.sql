--SQLQuery1-sp INSERT Schedule.sq
--USE PV_521_Import;
--GO--Применить
--ALTER PROCEDURE sp_InsertScheduleStacionar
--	@group_name				 NCHAR(10),
--	@discipline_name		 AS NVARCHAR(150),
--	@teacher_first_name		 AS NVARCHAR(50),
--	@start_date				 AS DATE
--AS
--BEGIN
--	DECLARE @group				AS INT		=	(SELECT group_id			FROM Groups		 WHERE group_name		LIKE @group_name);
--	DECLARE @teacher			AS SMALLINT	=	(SELECT teacher_id			FROM Teachers	 WHERE first_name		LIKE @teacher_first_name);
--	DECLARE @discipline			AS SMALLINT =	(SELECT discipline_id		FROM Disciplines WHERE discipline_name	LIKE @discipline_name);
--	DECLARE @number_of_lessons  AS TINYINT	=	(SELECT number_of_lessons	FROM Disciplines WHERE discipline_name	LIKE @discipline_name);
--	--DECLARE @lesson_number      AS TINYINT = 0;
--	--DECLARE @date               AS DATE = @start_date;
--	DECLARE @start_time         AS TIME = (SELECT start_time FROM Groups WHERE group_id=@group);
--END
--PRINT(@group);
--PRINT(@discipline);
--PRINT(@number_of_lessons);
--PRINT(@teacher);
--PRINT(@start_date);
--PRINT(@start_time);

----В цикле перебираем занятие по номеру, определяем дату и время каждого занятия
--DECLARE @date			AS DATE		= @start_date;
--DECLARE @lesson_number  AS TINYINT  = 1;
----DECLARE @time AS TIME = @start_time;
--WHILE @lesson_number < @number_of_lessons
--BEGIN
--		--SET @time=@start_time;
--		DECLARE @time AS TIME	=	@start_time;
--		--PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
--		--IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
--			--INSERT Schedule VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
--		EXEC sp_InsertLesson @group,@discipline,@teacher,@date,@time OUTPUT,NULL;

--		SET @lesson_number = @lesson_number + 1;
--		--SET @time = DATEADD(MINUTE,95,@start_time);

--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
--		--IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
--			--INSERT Schedule VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
--		EXEC sp_InsertLesson @group,@discipline,@teacher,@date,@time OUTPUT,NULL;
--		SET @lesson_number = @lesson_number + 1;

--		DECLARE @day AS TINYINT = DATEPART(WEEKDAY,@date);
--		--PRINT(@day);
--		SET @date	=	DATEADD(DAY,IIF(@day=5,3,2),@date);

--END



USE PV_521_Import;
SET DATEFIRST 1;
GO--Применить
ALTER PROCEDURE sp_InsertScheduleStacionar
	@group_name				 NCHAR(10),
	@discipline_name		 AS NVARCHAR(150),
	@teacher_first_name		 AS NVARCHAR(50),
	@start_date				 AS DATE = N'1900-01-01'	
AS
BEGIN
	DECLARE @group				AS INT		=	(SELECT group_id			FROM Groups		 WHERE group_name		LIKE @group_name);
	DECLARE @teacher			AS SMALLINT	=	(SELECT teacher_id			FROM Teachers	 WHERE first_name		LIKE @teacher_first_name);
	DECLARE @discipline			AS SMALLINT =	(SELECT discipline_id		FROM Disciplines WHERE discipline_name	LIKE @discipline_name);
	DECLARE @number_of_lessons  AS TINYINT	=	(SELECT number_of_lessons	FROM Disciplines WHERE discipline_name	LIKE @discipline_name);
	--DECLARE @lesson_number      AS TINYINT = 0;
	--DECLARE @date               AS DATE = @start_date;
	DECLARE @start_time         AS TIME = (SELECT start_time FROM Groups WHERE group_id=@group);
END
PRINT(@group);
PRINT(@discipline);
PRINT(@number_of_lessons);
PRINT(@teacher);
PRINT(@start_date);
PRINT(@start_time);

--В цикле перебираем занятие по номеру, определяем дату и время каждого занятия
DECLARE @date			AS DATE		= 
IIF(@start_date<>N'1900-01-01',@start_date,(SELECT MAX([date])FROM Schedule WHERE [group]=@group));
DECLARE @lesson_number  AS TINYINT  = dbo.CountLessons(@group,@discipline);
DECLARE @time AS TIME = @start_time;
WHILE @lesson_number < @number_of_lessons
BEGIN
		  SET @date = dbo.GetNextLearningDate(@group_name,@date);
		  SET @time=@start_time;
		  --IF EXISTS (SELECT holiday FROM DaysOFF WHERE [date]=@date)CONTINUE;
		  
		--DECLARE @time AS TIME	=	@start_time;
		--PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
		--IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
			--INSERT Schedule VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
		--EXEC sp_InsertLesson @group,@discipline,@teacher,@date,@time OUTPUT,NULL, @lesson_number = @lesson_number OUTPUT;
		EXEC	sp_InsertLesson @group,@discipline,@teacher,@date,@time OUTPUT,@lesson_number OUTPUT;

		--SET @lesson_number = @lesson_number + 1;
		--SET @time = DATEADD(MINUTE,95,@start_time);

		--PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
		--IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
			--INSERT Schedule VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
		--EXEC sp_InsertLesson @group,@discipline,@teacher,@date,@time OUTPUT,NULL, @lesson_number = @lesson_number OUTPUT;
		--SET @lesson_number = @lesson_number + 1;
		EXEC	sp_InsertLesson @group,@discipline,@teacher,@date,@time OUTPUT,@lesson_number OUTPUT;


		--DECLARE @day AS TINYINT = DATEPART(WEEKDAY,@date);
		--PRINT(@day);
		--SET @date	=	DATEADD(DAY,IIF(@day=5,3,2),@date);
		--SET @date  = dbo.GetNextLearningDate(@group_name,@date);

	END


	--ВАРИАНТ ДОМАШНЯЯ РАБОТА РАСПИСАНИЕ
--	USE PV_521_Import;
--GO

--CREATE OR ALTER PROCEDURE sp_InsertScheduleStacionar2
--    @group_name          NCHAR(10),
--    @discipline_name     NVARCHAR(150),
--    @teacher_first_name  NVARCHAR(50),
--    @start_date          DATE
--AS
--BEGIN
--    DECLARE @group           AS INT       = (SELECT group_id            FROM Groups            WHERE group_name LIKE @group_name);
--    DECLARE @teacher        AS SMALLINT   = (SELECT teacher_id         FROM Teachers         WHERE first_name LIKE @teacher_first_name);
--    DECLARE @discipline     AS SMALLINT   = (SELECT discipline_id      FROM Disciplines      WHERE discipline_name LIKE @discipline_name);
--    DECLARE @number_of_lessons AS TINYINT  = (SELECT number_of_lessons FROM Disciplines      WHERE discipline_name LIKE @discipline_name);
--    DECLARE @start_time      AS TIME      = (SELECT start_time         FROM Groups            WHERE group_id = @group);

--    PRINT(@group);
--    PRINT(@discipline);
--    PRINT(@number_of_lessons);
--    PRINT(@teacher);
--    PRINT(@start_date);
--    PRINT(@start_time);

--    -- Начинаем цикл формирования расписания
--    DECLARE @date           AS DATE      = @start_date;
--    DECLARE @lesson_number  AS TINYINT   = dbo.CountLessons(@group, @discipline);
--    DECLARE @time           AS TIME      = @start_time;

--    WHILE @lesson_number <= @number_of_lessons
--    BEGIN
--        -- Перебор урока по номеру, определение даты и времени каждого занятия
--        SET @time = @start_time;
        
--        -- Проверка на праздничный день
--        IF EXISTS (SELECT *FROM Holidays WHERE [month] = MONTH(@date) AND [day] = DAY(@date))
--        BEGIN
--            -- Дата попадает на праздник, пропускаем её
--            SET @date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @date)=5, 3, 2), @date);
--            CONTINUE;
--        END
        
--        -- Первая запись урока
--        EXEC sp_InsertLesson @group, @discipline, @teacher, @date, @time OUTPUT, @lesson_number OUTPUT;
        
--        -- Вторая запись урока (если надо повторить на той же дате)
--        EXEC sp_InsertLesson @group, @discipline, @teacher, @date, @time OUTPUT, @lesson_number OUTPUT;
        
--        -- Переход к следующей неделе
--        DECLARE @day AS TINYINT = DATEPART(WEEKDAY, @date);
--        SET @date = DATEADD(DAY, IIF(@day=5, 3, 2), @date);
--    END
--END

--ФУНКЦИЯ ПОЛУЧЕНИЯ ДЛИТЕЛЬНОСТИ ПРАЗДНИКА
--GO
--CREATE OR ALTER FUNCTION dbo.GetHolidayDurationForDate (@date DATE)
--RETURNS INT
--AS
--BEGIN
--    DECLARE @holiday_duration INT;

--    -- Получаем продолжительность праздника, если дата находится в пределах праздника
--    SELECT @holiday_duration = duration
--    FROM Holidays
--    WHERE [month] = MONTH(@date) AND [day] = DAY(@date);

--    RETURN @holiday_duration;
--END


--SELECT dbo.GetHolidayDurationForDate ('2026-06-12');