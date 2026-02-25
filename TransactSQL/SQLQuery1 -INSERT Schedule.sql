--SQLQuery1 -INSERT Schedule.sql
  USE PV_521_Import;
--SET DATEFIRST 1; --Для правильной интерпритации дней недели(Пн-1,Вт-2, ..., Вс-7)
----Объявляем переменные:    
--DECLARE @group				 INT		 =	(SELECT group_id		  FROM Groups		 WHERE group_name = N'PV_521');
--DECLARE @discipline			 AS SMALLINT =	(SELECT discipline_id	  FROM Disciplines   WHERE discipline_name LIKE N'%MS SQL%');
--DECLARE @number_of_lessons	 AS TINYINT  =  (SELECT number_of_lessons FROM Disciplines   WHERE discipline_id=@discipline);
--DECLARE @teacher			 AS INT		 =	(SELECT teacher_id		  FROM Teachers	     WHERE first_name = N'Олег');
--DECLARE @start_date			 AS DATE	 =	N'2025-12-24';
--DECLARE @start_time			 AS TIME	 =	(SELECT start_time        FROM Groups        WHERE group_id=@group);

--PRINT(@group);
--PRINT(@discipline);
--PRINT(@number_of_lessons);
--PRINT(@teacher);
--PRINT(@start_date);
--PRINT(@start_time);

----В цикле перебираем занятие по номеру, определяем дату и время каждого занятия
--DECLARE @date			AS DATE		= @start_date;
--DECLARE @lesson_number  AS TINYINT  = 1;

--WHILE @lesson_number < @number_of_lessons
--BEGIN
--		--SET @time=@start_time;
--		DECLARE @time AS TIME	=	@start_time;
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
--		IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
--			INSERT Schedule VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
--		SET @lesson_number = @lesson_number + 1;
--		SET @time = DATEADD(MINUTE,95,@start_time);

--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
--		IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
--			INSERT Schedule VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
--		SET @lesson_number = @lesson_number + 1;

--		DECLARE @day AS TINYINT = DATEPART(WEEKDAY,@date);
--		--PRINT(@day);
--		SET @date	=	DATEADD(DAY,IIF(@day=5,3,2),@date);

--END

--Домашнее задание без использования процедуры вставки урока

SET DATEFIRST 1;

DECLARE @group								INT			=	(SELECT group_id			FROM Groups			WHERE group_name=N'PV_521');
DECLARE @discipline_hardware				SMALLINT	=	(SELECT discipline_id		FROM Disciplines    WHERE discipline_name LIKE N'%Hardware%');
DECLARE @discipline_c_plus_plus				SMALLINT	=	(SELECT discipline_id		FROM Disciplines    WHERE discipline_name LIKE N'%Процедурное%');
DECLARE @hardware_lessons_count				TINYINT		=	(SELECT number_of_lessons	FROM Disciplines    WHERE discipline_id=@discipline_hardware);
DECLARE @cpp_lessons_count					TINYINT		=	(SELECT number_of_lessons	FROM Disciplines    WHERE discipline_id=@discipline_c_plus_plus);
DECLARE @teacher_hardware					INT			=	(SELECT teacher_id			FROM Teachers		WHERE last_name=N'Свищев');
DECLARE @teacher_c_plus_plus				INT			=	(SELECT teacher_id			FROM Teachers		WHERE last_name=N'Ковтун');
DECLARE @start_date_hardware				DATE		=	N'2024-03-04'; -- Дата начала занятий по железу
--DECLARE @start_date_c_plus_plus				DATE		=	N'2024-03-06'; -- Дата начала занятий по C++
DECLARE @start_time							TIME		=	(SELECT start_time			FROM Groups			WHERE group_id=@group);

PRINT(@hardware_lessons_count); -- Количество занятий по железу
PRINT(@cpp_lessons_count);      -- Количество занятий по C++

-- Объявляем переменные для текущего состояния расписания
DECLARE @current_date   DATE     = @start_date_hardware;
DECLARE @hw_counter     TINYINT  = 1;  -- Счётчик занятий по железу
DECLARE @cpp_counter    TINYINT  = 1;  -- Счётчик занятий по C++
DECLARE @global_counter TINYINT  = 1;  -- Общий последовательный счётчик всех занятий

WHILE @hw_counter <= @hardware_lessons_count OR @cpp_counter <= @cpp_lessons_count 
BEGIN
    DECLARE @time       TIME    = @start_time;
    DECLARE @week_num   INT     = DATEDIFF(WEEK, @start_date_hardware, @current_date) + 1; -- Номер учебной недели
    DECLARE @day        TINYINT = DATEPART(WEEKDAY, @current_date); -- День недели

    IF @week_num % 2 <> 0 -- Нечётная учебная неделя
    BEGIN
        IF @day = 1 -- Понедельник
        BEGIN
            IF @hw_counter <= @hardware_lessons_count -- Занятия по железу ещё остались
            BEGIN
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Hardware_PC');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_hardware,@teacher_hardware,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @hw_counter += 1;
                SET @global_counter += 1;
                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Hardware_PC');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_hardware,@teacher_hardware,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @hw_counter += 1;
                SET @global_counter += 1;
            END
            ELSE -- Если все занятия по железу закончились, ставим пару по C++
            BEGIN
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @cpp_counter += 1;
                SET @global_counter += 1;
                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @cpp_counter += 1;
                SET @global_counter += 1;
            END
        END
        ELSE IF @day IN (3, 5) -- Среда и пятница
        BEGIN
            --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
            IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

            SET @cpp_counter += 1;
            SET @global_counter += 1;
            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
            --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
            IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

            SET @cpp_counter += 1;
            SET @global_counter += 1;
        END
    END
    ELSE -- Четная учебная неделя
    BEGIN
        IF @day = 1 -- Понедельник
        BEGIN
            IF @hw_counter <= @hardware_lessons_count -- Есть занятия по железу
            BEGIN
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Hardware_PC');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_hardware,@teacher_hardware,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @hw_counter += 1;
                SET @global_counter += 1;
                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Hardware_PC');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_hardware,@teacher_hardware,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @hw_counter += 1;
                SET @global_counter += 1;
            END
            ELSE -- Если все занятия по железу закончились, ставим пару по C++
            BEGIN
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @cpp_counter += 1;
                SET @global_counter += 1;
                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @cpp_counter += 1;
                SET @global_counter += 1;
            END
        END
        ELSE IF @day = 3 -- Среда
        BEGIN
            IF @hw_counter <= @hardware_lessons_count -- Остались занятия по железу
            BEGIN
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Hardware_PC');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_hardware,@teacher_hardware,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @hw_counter += 1;
                SET @global_counter += 1;
                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Hardware_PC');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_hardware,@teacher_hardware,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @hw_counter += 1;
                SET @global_counter += 1;
            END
            ELSE -- Если все занятия по железу закончились, ставим пару по C++
            BEGIN
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @cpp_counter += 1;
                SET @global_counter += 1;
                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
                --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
                IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

                SET @cpp_counter += 1;
                SET @global_counter += 1;
            END
        END
        ELSE IF @day = 5 -- Пятница
        BEGIN
            --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
            IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

            SET @cpp_counter += 1;
            SET @global_counter += 1;
            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
            --PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
            IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@time AND [group]=@group)
			    INSERT Schedule VALUES(@group,@discipline_c_plus_plus,@teacher_c_plus_plus,@current_date,@time,IIF(@current_date<GETDATE(),1,0));

            SET @cpp_counter += 1;
            SET @global_counter += 1;
        END
    END
    
    -- Переходим на следующий день
    --SET @current_date = DATEADD(DAY, IIF(DATEPART(WEEKDAY, @current_date) = 5, 3, 1), @current_date);
    SET @current_date = DATEADD(DAY, CASE WHEN DATEPART(WEEKDAY, @current_date) = 5 THEN 3 ELSE 1 END, @current_date);
END


