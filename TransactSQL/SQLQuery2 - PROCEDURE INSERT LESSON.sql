--SQLQuery2 - PROCEDURE INSERT LESSON.sql

USE PV_521_Import;

-- Удаляем существующую процедуру
--IF OBJECT_ID('dbo.sp_InsertLesson') IS NOT NULL
--DROP PROCEDURE dbo.sp_InsertLesson;
--GO
GO

---- Создаем процедуру
CREATE PROCEDURE sp_InsertLesson
    @group INT,
    @discipline SMALLINT,
    @teacher INT,
    @lesson_date DATE,
    @lesson_time TIME,
    @spent BIT
AS
BEGIN
    IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@lesson_date AND [time]=@lesson_time AND [group]=@group)
    BEGIN
        INSERT INTO Schedule([group],discipline,teacher,date,time,spent)
        VALUES(@group,@discipline,@teacher,@lesson_date,@lesson_time,@spent);
    END
END
GO

SET DATEFIRST 1;

DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
DECLARE @discipline_hardware SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
DECLARE @discipline_c_plus_plus SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
DECLARE @hardware_lessons_count TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_hardware);
DECLARE @cpp_lessons_count TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
DECLARE @teacher_hardware INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Свищев');
DECLARE @teacher_c_plus_plus INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Ковтун');
DECLARE @start_date_hardware DATE = N'2024-03-04';
DECLARE @start_time TIME = (SELECT start_time FROM Groups WHERE group_id=@group);

PRINT(@hardware_lessons_count); -- Количество занятий по железу
PRINT(@cpp_lessons_count);      -- Количество занятий по C++

-- Объявляем переменные для текущего состояния расписания
DECLARE @current_date DATE = @start_date_hardware;
DECLARE @hw_counter TINYINT = 1;  -- Счётчик занятий по железу
DECLARE @cpp_counter TINYINT = 1;  -- Счётчик занятий по C++
DECLARE @global_counter TINYINT = 1;  -- Общий последовательный счётчик всех занятий

WHILE @hw_counter <= @hardware_lessons_count OR @cpp_counter <= @cpp_lessons_count 
BEGIN
    DECLARE @time TIME = @start_time;
    DECLARE @week_num INT = DATEDIFF(WEEK, @start_date_hardware, @current_date) + 1; -- Номер учебной недели
    DECLARE @day TINYINT = DATEPART(WEEKDAY, @current_date); -- День недели

    IF @week_num % 2 <> 0 -- Нечётная учебная неделя
    BEGIN
        IF @day = 1 -- Понедельник
        BEGIN
            IF @hw_counter <= @hardware_lessons_count -- Занятия по железу ещё остались
            BEGIN
                EXEC sp_InsertLesson @group, @discipline_hardware, @teacher_hardware, @current_date, @time, IIF(@current_date < GETDATE(), 1, 0);
                EXEC sp_InsertLesson @group, @discipline_hardware, @teacher_hardware, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date < GETDATE(), 1, 0);

                SET @hw_counter += 2;
                SET @global_counter += 2;
            END
            ELSE -- Если все занятия по железу закончились, ставим пару по C++
            BEGIN
                EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
                EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

                SET @cpp_counter += 2;
                SET @global_counter += 2;
            END
        END
        ELSE IF @day IN (3, 5) -- Среда и пятница
        BEGIN
            EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
            EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

            SET @cpp_counter += 2;
            SET @global_counter += 2;
        END
    END
    ELSE -- Четная учебная неделя
    BEGIN
        IF @day = 1 -- Понедельник
        BEGIN
            IF @hw_counter <= @hardware_lessons_count -- Занятия по железу ещё остались
            BEGIN
                EXEC sp_InsertLesson @group, @discipline_hardware, @teacher_hardware, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
                EXEC sp_InsertLesson @group, @discipline_hardware, @teacher_hardware, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

                SET @hw_counter += 2;
                SET @global_counter += 2;
            END
            ELSE -- Если все занятия по железу закончились, ставим пару по C++
            BEGIN
                EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
                EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

                SET @cpp_counter += 2;
                SET @global_counter += 2;
            END
        END
        ELSE IF @day = 3 -- Среда
        BEGIN
            IF @hw_counter <= @hardware_lessons_count -- Занятия по железу ещё остались
            BEGIN
                EXEC sp_InsertLesson @group, @discipline_hardware, @teacher_hardware, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
                EXEC sp_InsertLesson @group, @discipline_hardware, @teacher_hardware, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

                SET @hw_counter += 2;
                SET @global_counter += 2;
            END
            ELSE -- Если все занятия по железу закончились, ставим пару по C++
            BEGIN
                EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
                EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

                SET @cpp_counter += 2;
                SET @global_counter += 2;
            END
        END
        ELSE IF @day = 5 -- Пятница
        BEGIN
            EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, @time, IIF(@current_date<GETDATE(),1,0);
            EXEC sp_InsertLesson @group, @discipline_c_plus_plus, @teacher_c_plus_plus, @current_date, DATEADD(MINUTE, 95, @time), IIF(@current_date<GETDATE(),1,0);

            SET @cpp_counter += 2;
            SET @global_counter += 2;
        END
    END
    
    -- Переходим на следующий день
    SET @current_date = DATEADD(DAY, CASE WHEN DATEPART(WEEKDAY, @current_date) = 5 THEN 3 ELSE 1 END, @current_date);
END

--SELECT * FROM sys.procedures WHERE name = 'sp_InsertLesson';