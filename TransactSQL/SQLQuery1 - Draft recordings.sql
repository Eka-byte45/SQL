--SQLQuery1 - Draft recordings.sql


--SELECT *FROM Disciplines;
--SELECT *FROM Teachers;

--SET DATEFIRST 1;

--DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @number_of_lessons_hardware AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware AS DATE = N'2026-03-02';
--DECLARE @start_date_c_plus_plus AS DATE = N'2026-03-04';
--DECLARE @start_time AS TIME = (SELECT start_time FROM Groups WHERE group_id=@group);

--DECLARE @hardware_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cplus_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);

---- Переменные для отслеживания состояния расписания
--DECLARE @current_date AS DATE = @start_date_hardware;
--DECLARE @lesson_counter AS TINYINT = 1;

---- Общее количество уроков
--DECLARE @total_lessons AS TINYINT = @number_of_lessons_hardware + @number_of_lessons_c_plus_plus;

---- Цикл формирования расписания
--WHILE @lesson_counter <= @total_lessons
--BEGIN
--    DECLARE @week_day TINYINT = DATEPART(WEEKDAY, @current_date);

--    -- Проверка дня недели
--    IF @week_day IN (1, 3, 5) BEGIN
--        -- Если понедельник (должна идти дисциплина Hardware)
--        IF @week_day = 1 BEGIN
--            IF @lesson_counter <= @number_of_lessons_hardware BEGIN
--                PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@hardware_name, CAST(@start_time AS NVARCHAR(24)))); 
--                --INSERT INTO Schedule 
--                SET @lesson_counter += 1;
--                SET @start_time = DATEADD(MINUTE,95,@start_time);
--                PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@hardware_name, CAST(@start_time AS NVARCHAR(24)))); 
--                SET @lesson_counter += 1;
--            END ELSE BEGIN
--                PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@cplus_name, CAST(@start_time AS NVARCHAR(24))));
--                SET @lesson_counter += 1;
--                --INSERT INTO Schedule ...
--            END
--        END
--        -- Если пятница (только C++)
--        ELSE IF @week_day = 5 BEGIN
--            PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@cplus_name, CAST(@start_time AS NVARCHAR(24)))); 
--            SET @lesson_counter += 1;
--            SET @start_time = DATEADD(MINUTE,95,@start_time);
--            PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s) %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@cplus_name, CAST(@start_time AS NVARCHAR(24)))); 
--            SET @lesson_counter += 1;
--            --INSERT INTO Schedule ...
--        END
--        -- Если среда (чередуются Hardware/C++, потом только C++)
--        ELSE IF @week_day = 3 BEGIN
--            IF @lesson_counter <= @number_of_lessons_hardware BEGIN
--                IF @lesson_counter % 2 = 1 BEGIN
--                    PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@hardware_name, CAST(@start_time AS NVARCHAR(24)))); 
--                    SET @lesson_counter += 1;
--                    SET @start_time = DATEADD(MINUTE,95,@start_time);
--                    PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s) %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@hardware_name, CAST(@start_time AS NVARCHAR(24)))); 
--                    SET @lesson_counter += 1;
--                    --INSERT INTO Schedule ...
--                END ELSE BEGIN
--                    PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@cplus_name, CAST(@start_time AS NVARCHAR(24)))); 
--                    SET @lesson_counter += 1;
--                    SET @start_time = DATEADD(MINUTE,95,@start_time);
--                    PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date),@cplus_name, CAST(@start_time AS NVARCHAR(24)))); 
--                    SET @lesson_counter += 1;
--                    --INSERT INTO Schedule ...
--                END
--            END ELSE BEGIN
--                PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @cplus_name,CAST(@start_time AS NVARCHAR(24)))); 
--                SET @lesson_counter += 1;
--                SET @start_time = DATEADD(MINUTE,95,@start_time);
--                PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @cplus_name,CAST(@start_time AS NVARCHAR(24)))); 
--                SET @lesson_counter += 1;
--                --INSERT INTO Schedule ...
--            END
--        END
--    END

--    -- Сброс времени на начало дня после обработки всех уроков
--    SET @start_time = (SELECT start_time FROM Groups WHERE group_id=@group);

--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN @week_day = 5 THEN 3 ELSE 1 END, @current_date);
--END
--SET DATEFIRST 1;

--DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @number_of_lessons_hardware AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware AS DATE = N'2026-03-02'; -- Начинаем с понедельника
--DECLARE @start_date_c_plus_plus AS DATE = N'2026-03-04'; -- Начало занятий по "C++"

---- Название дисциплин
--DECLARE @hardware_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cplus_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);

---- Переменные для отслеживания состояния расписания
--DECLARE @current_date AS DATE = @start_date_hardware;
--DECLARE @lesson_counter AS TINYINT = 1;

---- Переменная для отслеживания чередования (счетчик недель)
--DECLARE @week_count TINYINT = 0; -- счетчик прошедших недель

---- Общее количество уроков
--DECLARE @total_lessons AS TINYINT = @number_of_lessons_hardware + @number_of_lessons_c_plus_plus;

---- Текущие остатки уроков по дисциплинам
--DECLARE @remaining_hardware_lessons AS TINYINT = @number_of_lessons_hardware;
--DECLARE @remaining_cplusplus_lessons AS TINYINT = @number_of_lessons_c_plus_plus;

---- Цикл формирования расписания
--WHILE @lesson_counter <= @total_lessons
--BEGIN
--    DECLARE @week_day TINYINT = DATEPART(WEEKDAY, @current_date);

--    -- Определение выбранной дисциплины на основе дня недели и остатков уроков
--    DECLARE @selected_discipline NVARCHAR(MAX) =
--        CASE
--            WHEN @week_day = 1 THEN -- понедельник всегда "Hardware"
--                CASE
--                    WHEN @remaining_hardware_lessons > 0 THEN @hardware_name
--                    ELSE @cplus_name
--                END
--            WHEN @week_day = 5 THEN -- пятница всегда "C++"
--                @cplus_name
--            ELSE -- среда чередуется
--                CASE
--                    WHEN @remaining_hardware_lessons > 0 THEN
--                        CASE
--                            WHEN @week_count % 2 = 0 THEN @cplus_name -- если week_count чётное, ставим C++
--                            ELSE @hardware_name -- если нечётное, ставим железо
--                        END
--                    ELSE -- если уроки железа закончились, ставим только C++
--                        @cplus_name
--                END
--        END;

--    -- Проверка дня недели
--    IF @week_day IN (1, 3, 5) BEGIN
--        -- Первая пара в день (всегда с 18:00)
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, '18:00')); 
--        SET @lesson_counter += 1;

--        -- Отнимаем урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END

--        -- Вторая пара в день (фиксированно в 20:05)
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, '20:05')); 
--        SET @lesson_counter += 1;

--        -- Отнимаем еще один урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END
--    END

--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN @week_day = 5 THEN 3 ELSE 1 END, @current_date);

--    -- Каждые две недели меняем состояние средней смены (четная-нечетная неделя)
--    IF DATEDIFF(DAY, @start_date_hardware, @current_date) >= 6 BEGIN
--        SET @week_count += 1; -- увеличивает счетчик недель каждые две недели
--    END
--END



--SET DATEFIRST 1;

--DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @number_of_lessons_hardware AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware AS DATE = N'2026-03-02'; -- Начинаем с понедельника
--DECLARE @start_date_c_plus_plus AS DATE = N'2026-03-04'; -- Начало занятий по "C++"

---- Название дисциплин
--DECLARE @hardware_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cplus_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);

---- Переменные для отслеживания состояния расписания
--DECLARE @current_date AS DATE = @start_date_hardware;
--DECLARE @lesson_counter AS TINYINT = 1;

---- Переменная для отслеживания чередования (счетчик недель)
--DECLARE @week_count TINYINT = 0; -- счетчик прошедших недель

---- Общее количество уроков
--DECLARE @total_lessons AS TINYINT = @number_of_lessons_hardware + @number_of_lessons_c_plus_plus;

---- Текущие остатки уроков по дисциплинам
--DECLARE @remaining_hardware_lessons AS TINYINT = @number_of_lessons_hardware;
--DECLARE @remaining_cplusplus_lessons AS TINYINT = @number_of_lessons_c_plus_plus;

---- Цикл формирования расписания
--WHILE @lesson_counter <= @total_lessons
--BEGIN
--    DECLARE @week_day TINYINT = DATEPART(WEEKDAY, @current_date);

--    -- Определение выбранной дисциплины
--    DECLARE @selected_discipline NVARCHAR(MAX) =
--        CASE
--            WHEN @week_day = 1 THEN -- понедельник всегда "Hardware"
--                IIF(@remaining_hardware_lessons > 0, @hardware_name, @cplus_name)
--            WHEN @week_day = 5 THEN -- пятница всегда "C++"
--                @cplus_name
--            ELSE -- среда чередуется
--                IIF(@remaining_hardware_lessons > 0,
--                    IIF(@week_count % 2 = 0, @cplus_name, @hardware_name),
--                    @cplus_name)
--        END;

--    -- Проверка дня недели
--    IF @week_day IN (1, 3, 5) BEGIN
--        -- Первая пара в день (всегда с 18:00)
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, '18:00')); 
--        SET @lesson_counter += 1;

--        -- Отнимаем урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END

--        -- Вторая пара в день (фиксированно в 20:05)
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, '20:05')); 
--        SET @lesson_counter += 1;

--        -- Отнимаем еще один урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END
--    END

--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN @week_day = 5 THEN 3 ELSE 1 END, @current_date);

--    -- Каждые две недели меняем состояние средней смены (четная-нечетная неделя)
--    IF DATEDIFF(DAY, @start_date_hardware, @current_date) >= 6 BEGIN
--        SET @week_count += 1; -- увеличивает счетчик недель каждые две недели
--    END
--END

--SET DATEFIRST 1;

--DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @number_of_lessons_hardware AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware AS DATE = N'2026-03-02'; -- Начинаем с понедельника
--DECLARE @start_date_c_plus_plus AS DATE = N'2026-03-04'; -- Начало занятий по "C++"

---- Название дисциплин
--DECLARE @hardware_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cplus_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);

---- Переменные для отслеживания состояния расписания
--DECLARE @current_date AS DATE = @start_date_hardware;
--DECLARE @lesson_counter AS TINYINT = 1;

---- Переменная для отслеживания чередования (счетчик недель)
--DECLARE @week_count TINYINT = 0; -- счетчик прошедших недель

---- Общее количество уроков
--DECLARE @total_lessons AS TINYINT = @number_of_lessons_hardware + @number_of_lessons_c_plus_plus;

---- Текущие остатки уроков по дисциплинам
--DECLARE @remaining_hardware_lessons AS TINYINT = @number_of_lessons_hardware;
--DECLARE @remaining_cplusplus_lessons AS TINYINT = @number_of_lessons_c_plus_plus;

---- Получаем время начала занятий из таблицы Group
--DECLARE @start_time AS TIME = (SELECT start_time FROM Groups WHERE group_id=@group);

---- Интервал между парами
--DECLARE @pair_interval AS TIME = '01:35:00'; -- 95 минут

---- Переменная для текущей пары
--DECLARE @current_pair_time AS TIME = @start_time;

---- Цикл формирования расписания
--WHILE @lesson_counter <= @total_lessons
--BEGIN
--    DECLARE @week_day TINYINT = DATEPART(WEEKDAY, @current_date);

--    -- Определение выбранной дисциплины
--    DECLARE @selected_discipline NVARCHAR(MAX) =
--        CASE
--            WHEN @week_day = 1 THEN -- понедельник всегда "Hardware"
--                IIF(@remaining_hardware_lessons > 0, @hardware_name, @cplus_name)
--            WHEN @week_day = 5 THEN -- пятница всегда "C++"
--                @cplus_name
--            ELSE -- среда чередуется
--                IIF(@remaining_hardware_lessons > 0,
--                    IIF(@week_count % 2 = 0, @cplus_name, @hardware_name),
--                    @cplus_name)
--        END;

--    -- Проверка дня недели
--    IF @week_day IN (1, 3, 5) BEGIN
--        -- Первая пара в день
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, CONVERT(NVARCHAR(5), @current_pair_time))); 
--         IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@current_pair_time AND [group]=@group)
--        BEGIN
--            INSERT INTO Schedule([group], discipline_id, teacher_id, date, time, is_archived)
--            VALUES (@group, CASE WHEN @selected_discipline = @hardware_name THEN @discipline_hardware ELSE @discipline_c_plus_plus END,
--                   CASE WHEN @selected_discipline = @hardware_name THEN @teacher_hardware ELSE @teacher_c_plus_plus END,
--                   @current_date, @current_pair_time, IIF(@current_date < GETDATE(), 1, 0));
--        END
--        SET @lesson_counter += 1;

--        -- Отнимаем урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END

--        -- Сдвигаем время на следующую пару
--        SET @current_pair_time = DATEADD(MINUTE, 95, @current_pair_time);

--        -- Вторая пара в день
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, CONVERT(NVARCHAR(5), @current_pair_time))); 
--        -- Вставка второй пары в расписание
--        IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@current_pair_time AND [group]=@group)
--        BEGIN
--            INSERT INTO Schedule([group], discipline_id, teacher_id, date, time, is_archived)
--            VALUES (@group, CASE WHEN @selected_discipline = @hardware_name THEN @discipline_hardware ELSE @discipline_c_plus_plus END,
--                   CASE WHEN @selected_discipline = @hardware_name THEN @teacher_hardware ELSE @teacher_c_plus_plus END,
--                   @current_date, @current_pair_time, IIF(@current_date < GETDATE(), 1, 0));
--        END
--        SET @lesson_counter += 1;

--        -- Отнимаем еще один урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END

--        -- Возвращаем время на начало дня
--        SET @current_pair_time = @start_time;
--    END

--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN @week_day = 5 THEN 3 ELSE 1 END, @current_date);

--    -- Каждые две недели меняем состояние средней смены (четная-нечетная неделя)
--    IF DATEDIFF(DAY, @start_date_hardware, @current_date) >= 6 BEGIN
--        SET @week_count += 1; -- увеличивает счетчик недель каждые две недели
--    END
--END

--SET DATEFIRST 1;

--DECLARE @group INT = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus AS SMALLINT = (SELECT discipline_id FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @number_of_lessons_hardware AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus AS TINYINT = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus AS INT = (SELECT teacher_id FROM Teachers WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware AS DATE = N'2026-03-02'; -- Начинаем с понедельника
--DECLARE @start_date_c_plus_plus AS DATE = N'2026-03-04'; -- Начало занятий по "C++"

---- Название дисциплин
--DECLARE @hardware_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cplus_name NVARCHAR(MAX) = (SELECT discipline_name FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);

---- Переменные для отслеживания состояния расписания
--DECLARE @current_date AS DATE = @start_date_hardware;
--DECLARE @lesson_counter AS TINYINT = 1;

---- Переменная для отслеживания чередования (счетчик недель)
--DECLARE @week_count TINYINT = 0; -- счетчик прошедших недель

---- Общее количество уроков
--DECLARE @total_lessons AS TINYINT = @number_of_lessons_hardware + @number_of_lessons_c_plus_plus;

---- Текущие остатки уроков по дисциплинам
--DECLARE @remaining_hardware_lessons AS TINYINT = @number_of_lessons_hardware;
--DECLARE @remaining_cplusplus_lessons AS TINYINT = @number_of_lessons_c_plus_plus;

---- Получаем время начала занятий из таблицы Group
--DECLARE @start_time AS TIME = (SELECT start_time FROM Groups WHERE group_id=@group);

---- Интервал между парами
--DECLARE @pair_interval AS TIME = '01:35:00'; -- 95 минут

---- Переменная для текущей пары
--DECLARE @current_pair_time AS TIME = @start_time;

---- Цикл формирования расписания
--WHILE @lesson_counter <= @total_lessons
--BEGIN
--    DECLARE @week_day TINYINT = DATEPART(WEEKDAY, @current_date);

--    -- Определение выбранной дисциплины
--    DECLARE @selected_discipline NVARCHAR(MAX) =
--        CASE
--            WHEN @week_day = 1 THEN -- понедельник всегда "Hardware"
--                IIF(@remaining_hardware_lessons > 0, @hardware_name, @cplus_name)
--            WHEN @week_day = 5 THEN -- пятница всегда "C++"
--                @cplus_name
--            ELSE -- среда чередуется
--                IIF(@remaining_hardware_lessons > 0,
--                    IIF(@week_count % 2 = 0, @cplus_name, @hardware_name),
--                    @cplus_name)
--        END;

--    -- Проверка дня недели
--    IF @week_day IN (1, 3, 5) BEGIN
--        -- Первая пара в день
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, CONVERT(NVARCHAR(5), @current_pair_time))); 
--        IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@current_pair_time AND [group]=@group)
--	    INSERT Schedule VALUES(@group,CASE WHEN @selected_discipline = @hardware_name THEN @discipline_hardware ELSE @discipline_c_plus_plus END, -- Используем числовой ID дисциплины
--        CASE WHEN @selected_discipline = @hardware_name THEN @teacher_hardware ELSE @teacher_c_plus_plus END,@current_date,@current_pair_time,IIF(@current_date<GETDATE(),1,0));
--        SET @lesson_counter += 1;

--        -- Отнимаем урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END

--        -- Сдвигаем время на следующую пару
--        SET @current_pair_time = DATEADD(MINUTE, 95, @current_pair_time);

--        -- Вторая пара в день
--        PRINT(FORMATMESSAGE(N'%i  %s  %s  (%s)  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), @selected_discipline, CONVERT(NVARCHAR(5), @current_pair_time))); 
--         IF NOT EXISTS (SELECT lesson_id FROM Schedule WHERE [date]=@current_date AND [time]=@current_pair_time AND [group]=@group)
--	    INSERT Schedule VALUES(@group,CASE WHEN @selected_discipline = @hardware_name THEN @discipline_hardware ELSE @discipline_c_plus_plus END, -- Используем числовой ID дисциплины
--        CASE WHEN @selected_discipline = @hardware_name THEN @teacher_hardware ELSE @teacher_c_plus_plus END,@current_date,@current_pair_time,IIF(@current_date<GETDATE(),1,0));
--        SET @lesson_counter += 1;

--        -- Отнимаем еще один урок от остаточной дисциплины
--        IF @selected_discipline = @hardware_name BEGIN
--            SET @remaining_hardware_lessons -= 1;
--        END ELSE BEGIN
--            SET @remaining_cplusplus_lessons -= 1;
--        END

--        -- Возвращаем время на начало дня
--        SET @current_pair_time = @start_time;
--    END

--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN @week_day = 5 THEN 3 ELSE 1 END, @current_date);

--    -- Каждые две недели меняем состояние средней смены (четная-нечетная неделя)
--    IF DATEDIFF(DAY, @start_date_hardware, @current_date) >= 6 BEGIN
--        SET @week_count += 1; -- увеличивает счетчик недель каждые две недели
--    END
--END

--SET DATEFIRST 1;

---- Выбор нужной группы студентов
--DECLARE @group                           AS INT              = (SELECT group_id           FROM Groups          WHERE group_name = N'PV_521');

---- Получение ID нужных дисциплин
--DECLARE @discipline_hardware             AS SMALLINT          = (SELECT discipline_id      FROM Disciplines     WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus           AS SMALLINT          = (SELECT discipline_id      FROM Disciplines     WHERE discipline_name LIKE N'%Процедурное%');

---- Количество планируемых занятий по каждой дисциплине
--DECLARE @number_of_lessons_hardware      AS TINYINT          = (SELECT number_of_lessons  FROM Disciplines     WHERE discipline_id = @discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus    AS TINYINT          = (SELECT number_of_lessons  FROM Disciplines     WHERE discipline_id = @discipline_c_plus_plus);

---- Преподаватели
--DECLARE @teacher_hardware                AS INT              = (SELECT teacher_id         FROM Teachers        WHERE last_name = N'Свищев');
--DECLARE @teacher_c_plus_plus              AS INT              = (SELECT teacher_id         FROM Teachers        WHERE last_name = N'Ковтун');

---- Даты начала занятий
--DECLARE @start_date_hardware             AS DATE             = N'2026-03-02'; -- Начало занятий по железу
--DECLARE @start_date_c_plus_plus           AS DATE             = N'2026-03-04'; -- Начало занятий по C++

---- Стартовое время занятий (предположительно, оно фиксировано)
--DECLARE @start_time                      AS TIME             = (SELECT start_time        FROM Groups          WHERE group_id = @group);

---- Переменные для управления циклом построения расписания
--DECLARE @current_date                    AS DATE             = @start_date_hardware;
--DECLARE @lesson_counter_hardware         AS TINYINT          = 1;
--DECLARE @lesson_counter_c_plus_plus      AS TINYINT          = 1;

---- Основной цикл формирования расписания
--WHILE @lesson_counter_hardware <= @number_of_lessons_hardware OR @lesson_counter_c_plus_plus <= @number_of_lessons_c_plus_plus
--BEGIN
--    -- Определяем номер учебной недели и текущий день недели
--    DECLARE @week                        AS INT              = DATEPART(WEEK, @current_date);
--    DECLARE @week_day                    AS INT              = DATEPART(WEEKDAY, @current_date);

--    -- Проверяем какая дисциплина должна идти следующим уроком
--    IF @week % 2 <> 0 -- Нечётная неделя
--    BEGIN
--        IF @week_day = 1 AND @lesson_counter_hardware <= @number_of_lessons_hardware -- Понедельник (железо)
--        BEGIN
--            -- Первая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_hardware,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_hardware += 1;
--            SET @start_time = DATEADD(MINUTE, 95, @start_time); -- Временной сдвиг на вторую пару

--            -- Вторая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_hardware,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_hardware += 1;
--            SET @current_date = DATEADD(DAY, 2, @current_date); -- Переходим на среду
--            SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group); -- Возвращаем время к первоначальному значению
--        END
--        ELSE IF @week_day = 3 AND @lesson_counter_c_plus_plus <= @number_of_lessons_c_plus_plus -- Среда (C++)
--        BEGIN
--            -- Первая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_c_plus_plus,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_c_plus_plus += 1;
--            SET @start_time = DATEADD(MINUTE, 95, @start_time); -- Временной сдвиг на вторую пару

--            -- Вторая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_c_plus_plus,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_c_plus_plus += 1;
--            SET @current_date = DATEADD(DAY, 2, @current_date); -- Переходим на пятницу
--            SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group); -- Возвращаем время к первоначальному значению
--        END
--        ELSE IF @week_day = 5 AND @lesson_counter_c_plus_plus <= @number_of_lessons_c_plus_plus -- Пятница (C++)
--        BEGIN
--            -- Первая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_c_plus_plus,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_c_plus_plus += 1;
--            SET @start_time = DATEADD(MINUTE, 95, @start_time); -- Временной сдвиг на вторую пару

--            -- Вторая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_c_plus_plus,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_c_plus_plus += 1;
--            SET @current_date = DATEADD(DAY, 3, @current_date); -- Переходим на следующую неделю
--            SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group); -- Возвращаем время к первоначальному значению
--        END
--    END
--    ELSE -- Четная неделя
--    BEGIN
--        IF @week_day = 1 AND @lesson_counter_hardware <= @number_of_lessons_hardware -- Понедельник (железо)
--        BEGIN
--            -- Первая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_hardware,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_hardware += 1;
--            SET @start_time = DATEADD(MINUTE, 95, @start_time); -- Временной сдвиг на вторую пару

--            -- Вторая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_hardware,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_hardware += 1;
--            SET @current_date = DATEADD(DAY, 2, @current_date); -- Переходим на среду
--            SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group); -- Возвращаем время к первоначальному значению
--        END
--        ELSE IF @week_day = 3 AND @lesson_counter_hardware <= @number_of_lessons_hardware -- Среда (железо)
--        BEGIN
--            -- Первая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_hardware,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_hardware += 1;
--            SET @start_time = DATEADD(MINUTE, 95, @start_time); -- Временной сдвиг на вторую пару

--            -- Вторая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_hardware,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_hardware += 1;
--            SET @current_date = DATEADD(DAY, 2, @current_date); -- Переходим на пятницу
--            SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group); -- Возвращаем время к первоначальному значению
--        END
--        ELSE IF @week_day = 5 AND @lesson_counter_c_plus_plus <= @number_of_lessons_c_plus_plus -- Пятница (C++)
--        BEGIN
--            -- Первая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_c_plus_plus,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_c_plus_plus += 1;
--            SET @start_time = DATEADD(MINUTE, 95, @start_time); -- Временной сдвиг на вторую пару

--            -- Вторая пара
--            PRINT FORMATMESSAGE('%i  %s  %s  %s', 
--                                @lesson_counter_c_plus_plus,
--                                CONVERT(VARCHAR(24), @current_date, 120),
--                                DATENAME(WEEKDAY, @current_date),
--                                CONVERT(VARCHAR(8), @start_time));
--            SET @lesson_counter_c_plus_plus += 1;
--            SET @current_date = DATEADD(DAY, 3, @current_date); -- Переходим на следующую неделю
--            SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group); -- Возвращаем время к первоначальному значению
--        END
--    END
--END

--SET DATEFIRST 1;

---- Выбор нужной группы студентов
--DECLARE @group                         AS INT               = (SELECT group_id       FROM Groups   WHERE group_name = N'PV_521');

---- Получение ID нужных дисциплин
--DECLARE @discipline_hardware           AS SMALLINT          = (SELECT discipline_id  FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus         AS SMALLINT          = (SELECT discipline_id  FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');

---- Количество планируемых занятий по каждой дисциплине
--DECLARE @number_of_lessons_hardware    AS TINYINT          = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus  AS TINYINT          = (SELECT number_of_lessons FROM Disciplines WHERE discipline_id = @discipline_c_plus_plus);

---- Преподаватели
--DECLARE @teacher_hardware              AS INT               = (SELECT teacher_id     FROM Teachers   WHERE last_name = N'Свищев');
--DECLARE @teacher_c_plus_plus            AS INT               = (SELECT teacher_id     FROM Teachers   WHERE last_name = N'Ковтун');

---- Даты начала занятий
--DECLARE @start_date_hardware           AS DATE              = N'2026-03-02'; -- Начало занятий по железу
--DECLARE @start_date_c_plus_plus         AS DATE              = N'2026-03-04'; -- Начало занятий по C++

---- Стартовое время занятий (предположительно, оно фиксировано)
--DECLARE @start_time                    AS TIME              = (SELECT start_time    FROM Groups   WHERE group_id = @group);

---- Переменные для управления циклом построения расписания
--DECLARE @current_date                  AS DATE              = @start_date_hardware;
--DECLARE @lesson_counter_hardware       AS TINYINT          = 1;
--DECLARE @lesson_counter_c_plus_plus    AS TINYINT          = 1;

---- Основной цикл формирования расписания
--WHILE @lesson_counter_hardware <= @number_of_lessons_hardware OR @lesson_counter_c_plus_plus <= @number_of_lessons_c_plus_plus
--BEGIN
--    -- Определение номера учебной недели и текущего дня недели
--    DECLARE @week                       AS INT               = DATEPART(WEEK, @current_date);
--    DECLARE @week_day                   AS INT               = DATEPART(WEEKDAY, @current_date);
    
--    -- Распределение пар в зависимости от дня недели
--    IF @week_day IN (1, 3, 5) -- Занятия проводятся только в понедельник, среду и пятницу
--    BEGIN
--        -- Первая пара
--        PRINT FORMATMESSAGE('%i  %s  %s  %s',
--                            CASE WHEN @week % 2 <> 0 THEN @lesson_counter_hardware ELSE @lesson_counter_c_plus_plus END,
--                            CONVERT(VARCHAR(24), @current_date, 120),
--                            DATENAME(WEEKDAY, @current_date),
--                            CONVERT(VARCHAR(8), @start_time));
        
--        -- Обновляем счётчик уроков
--        IF @week % 2 <> 0 -- нечётная неделя (железо)
--            SET @lesson_counter_hardware += 1;
--        ELSE -- чётная неделя (C++)
--            SET @lesson_counter_c_plus_plus += 1;
            
--        -- Временной сдвиг на вторую пару
--        SET @start_time = DATEADD(MINUTE, 95, @start_time);
        
--        -- Вторая пара
--        PRINT FORMATMESSAGE('%i  %s  %s  %s',
--                            CASE WHEN @week % 2 <> 0 THEN @lesson_counter_hardware ELSE @lesson_counter_c_plus_plus END,
--                            CONVERT(VARCHAR(24), @current_date, 120),
--                            DATENAME(WEEKDAY, @current_date),
--                            CONVERT(VARCHAR(8), @start_time));
        
--        -- Обновляем счётчик уроков
--        IF @week % 2 <> 0 -- нечётная неделя (железо)
--            SET @lesson_counter_hardware += 1;
--        ELSE -- чётная неделя (C++)
--            SET @lesson_counter_c_plus_plus += 1;
            
--        -- Переход на следующий учебный день
--        IF @week_day = 1 -- понедельник
--            SET @current_date = DATEADD(DAY, 2, @current_date); -- переходим на среду
--        ELSE IF @week_day = 3 -- среда
--            SET @current_date = DATEADD(DAY, 2, @current_date); -- переходим на пятницу
--        ELSE -- пятница
--            SET @current_date = DATEADD(DAY, 3, @current_date); -- переходим на следующую неделю
            
--        -- Возвращаем время к первоначальному значению
--        SET @start_time = (SELECT start_time FROM Groups WHERE group_id = @group);
--    END
--END


--SET DATEFIRST 1;

--DECLARE @group									INT			=	 (SELECT group_id			FROM Groups		 WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware			AS		SMALLINT	=	 (SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus			AS		SMALLINT	=	 (SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @number_of_lessons_hardware		AS		TINYINT		=	 (SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @number_of_lessons_c_plus_plus	AS		TINYINT		=	 (SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware				AS		INT			=	 (SELECT teacher_id			FROM Teachers	 WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus			AS		INT			=	 (SELECT teacher_id			FROM Teachers	 WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware			AS		DATE		=	 N'2024-03-04';
--DECLARE @start_date_c_plus_plus			AS		DATE		=	 N'2024-03-06';
--DECLARE @start_time						AS		TIME		=	 (SELECT start_time			FROM Groups		 WHERE group_id=@group);

--DECLARE @current_date AS DATE = @start_date_hardware;
--DECLARE @lesson_counter AS TINYINT = 1;

--WHILE @lesson_counter < @number_of_lessons_c_plus_plus
--BEGIN
--	DECLARE @time AS TIME = @start_time;
--	DECLARE @day AS TINYINT = DATEPART(WEEKDAY,@current_date);
--	DECLARE @current_week INT = DATEPART(WEEK,GETDATE());
--	IF @current_week % 2 <> 0
--	BEGIN

--	IF @day=1

--	IF @lesson_counter <  @number_of_lessons_hardware 
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'Hardware'));
--		SET @lesson_counter+=1;
--		SET @time = DATEADD(MINUTE,95,@start_time);
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'Hardware'));
--		SET @lesson_counter+=1;
--	ELSE
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--		SET @lesson_counter+=1;
--		SET @time = DATEADD(MINUTE,95,@start_time);
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--		SET @lesson_counter+=1;

--	IF @day=3
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--	SET @lesson_counter+=1;
--	SET @time = DATEADD(MINUTE,95,@start_time);
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--	SET @lesson_counter+=1;

--	IF @day=5
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--	SET @lesson_counter+=1;
--	SET @time = DATEADD(MINUTE,95,@start_time);
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--	SET @lesson_counter+=1;
	
	
--	END
--	ELSE
--	BEGIN
--	IF @day=1

--	IF @lesson_counter <  @number_of_lessons_hardware 
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'Hardware'));
--		SET @lesson_counter+=1;
--		SET @time = DATEADD(MINUTE,95,@start_time);
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'Hardware'));
--		SET @lesson_counter+=1;
--	ELSE
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--		SET @lesson_counter+=1;
--		SET @time = DATEADD(MINUTE,95,@start_time);
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--		SET @lesson_counter+=1;

--	IF @day=3
--	IF @lesson_counter <  @number_of_lessons_hardware 
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'Hardware'));
--	SET @lesson_counter+=1;
--	SET @time = DATEADD(MINUTE,95,@start_time);
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'Hardware'));
--	SET @lesson_counter+=1;
--	ELSE
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--		SET @lesson_counter+=1;
--		SET @time = DATEADD(MINUTE,95,@start_time);
--		PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--		SET @lesson_counter+=1;

--	IF @day=5
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--	SET @lesson_counter+=1;
--	SET @time = DATEADD(MINUTE,95,@start_time);
--	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24)),'C++'));
--	SET @lesson_counter+=1;



--	END
--	SET @current_date = DATEADD(DAY,IIF(@current_date = 5,3,2),@current_date);
--END

-- Установка первого дня недели на понедельник
--SET DATEFIRST 1;
--DECLARE @group									INT			=	 (SELECT group_id			FROM Groups		 WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware			AS		SMALLINT	=	 (SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus			AS		SMALLINT	=	 (SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @hardware_lessons_count		AS		TINYINT		=	 (SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cpp_lessons_count	AS		TINYINT		=	 (SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware				AS		INT			=	 (SELECT teacher_id			FROM Teachers	 WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus			AS		INT			=	 (SELECT teacher_id			FROM Teachers	 WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware			AS		DATE		=	 N'2024-03-04';
--DECLARE @start_date_c_plus_plus			AS		DATE		=	 N'2024-03-06';
--DECLARE @start_time						AS		TIME		=	 (SELECT start_time			FROM Groups		 WHERE group_id=@group);



---- Начало цикла
--DECLARE @current_date DATE = @start_date_hardware;
--DECLARE @lesson_counter TINYINT = 1;

----WHILE @lesson_counter <= @cpp_lessons_count OR @lesson_counter <= @hardware_lessons_count BEGIN
--WHILE @lesson_counter <= @cpp_lessons_count + @hardware_lessons_count BEGIN
--    DECLARE @time TIME = @start_time;
--    DECLARE @week_num INT = DATEDIFF(WEEK, @start_date_hardware, @current_date) + 1; -- Номер учебной недели
--    DECLARE @day TINYINT = DATEPART(WEEKDAY, @current_date); -- День недели

--    IF @week_num % 2 != 0 -- Нечетная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @lesson_counter <= @hardware_lessons_count -- Проверьте, есть ли еще занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter += 1;
--            END
--            ELSE -- Все занятия по железу закончились, добавляем пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter += 1;
--            END
--        END
--        ELSE IF @day IN (3, 5) -- Среда и пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter += 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter += 1;
--        END
--    END
--    ELSE -- Четная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @lesson_counter <= @hardware_lessons_count -- Проверьте, есть ли еще занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter += 1;
--            END
--            ELSE -- Все занятия по железу закончились, добавляем пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter += 1;
--            END
--        END
--        ELSE IF @day = 3 -- Среда
--        BEGIN
--            IF @lesson_counter <= @hardware_lessons_count -- Проверьте, есть ли еще занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter += 1;
--            END
--            ELSE -- Все занятия по железу закончились, добавляем пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter += 1;
--            END
--        END
--        ELSE IF @day = 5 -- Пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter += 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter += 1;
--        END
--    END
    
--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN DATEPART(WEEKDAY, @current_date) = 5 THEN 3 ELSE 1 END, @current_date);
--END

 --Установка первого дня недели на понедельник
--SET DATEFIRST 1;
--DECLARE @group									INT			=	 (SELECT group_id			FROM Groups		 WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware			AS		SMALLINT	=	 (SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus			AS		SMALLINT	=	 (SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @hardware_lessons_count		AS		TINYINT		=	 (SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cpp_lessons_count	AS		TINYINT		=	 (SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware				AS		INT			=	 (SELECT teacher_id			FROM Teachers	 WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus			AS		INT			=	 (SELECT teacher_id			FROM Teachers	 WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware			AS		DATE		=	 N'2024-03-04';
--DECLARE @start_date_c_plus_plus			AS		DATE		=	 N'2024-03-06';
--DECLARE @start_time						AS		TIME		=	 (SELECT start_time			FROM Groups		 WHERE group_id=@group);

--PRINT(@hardware_lessons_count);
--PRINT(@cpp_lessons_count);

---- Начало цикла
--DECLARE @current_date DATE = @start_date_hardware;
--DECLARE @lesson_counter TINYINT = 1;


--    WHILE @lesson_counter <= @cpp_lessons_count + @hardware_lessons_count BEGIN
--    DECLARE @time TIME = @start_time;
--    DECLARE @week_num INT = DATEDIFF(WEEK, @start_date_hardware, @current_date) + 1; -- Номер учебной недели
--    DECLARE @day TINYINT = DATEPART(WEEKDAY, @current_date); -- День недели

--    IF @week_num % 2 <> 0 -- Нечетная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @lesson_counter <= @hardware_lessons_count -- Проверяем, есть ли еще занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter = @lesson_counter+1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter = @lesson_counter+1;
--            END
--            ELSE -- Все занятия по железу закончились, добавляем пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter =@lesson_counter+ 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter =@lesson_counter+ 1;
--            END
--        END
--        ELSE IF @day IN (3, 5) -- Среда и пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter =@lesson_counter+ 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter =@lesson_counter+ 1;
--        END
--    END
--    ELSE -- Четная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @lesson_counter <= @hardware_lessons_count -- Проверяем, есть ли еще занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter =@lesson_counter+ 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter = @lesson_counter+1;
--            END
--            ELSE -- Все занятия по железу закончились, добавляем пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter =@lesson_counter+ 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter =@lesson_counter+ 1;
--            END
--        END
--        ELSE IF @day = 3 -- Среда
--        BEGIN
--            IF @lesson_counter <= @hardware_lessons_count -- Проверяем, есть ли еще занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter =@lesson_counter+ 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @lesson_counter =@lesson_counter+ 1;
--            END
--            ELSE -- Все занятия по железу закончились, добавляем пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter =@lesson_counter+ 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @lesson_counter = @lesson_counter+1;
--            END
--        END
--        ELSE IF @day = 5 -- Пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter =@lesson_counter+ 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @lesson_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @lesson_counter =@lesson_counter+ 1;
--        END
--    END
    
--    -- Переход на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN DATEPART(WEEKDAY, @current_date) = 5 THEN 3 ELSE 1 END, @current_date);
--END
-- Установка первого дня недели на понедельник
--SET DATEFIRST 1;

--DECLARE @group					INT			=	(SELECT group_id			FROM Groups			WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware	SMALLINT	=	(SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus	SMALLINT	=	(SELECT discipline_id		FROM Disciplines WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @hardware_lessons_count	TINYINT		=	(SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_hardware);
--DECLARE @cpp_lessons_count		TINYINT		=	(SELECT number_of_lessons	FROM Disciplines WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware		INT			=	(SELECT teacher_id			FROM Teachers		WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus		INT			=	(SELECT teacher_id			FROM Teachers		WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware		DATE		=	N'2024-03-04'; -- Дата начала занятий по железу
--DECLARE @start_date_c_plus_plus	DATE		=	N'2024-03-06'; -- Дата начала занятий по C++
--DECLARE @start_time				TIME		=	(SELECT start_time			FROM Groups			WHERE group_id=@group);

--PRINT(@hardware_lessons_count); -- Количество занятий по железу
--PRINT(@cpp_lessons_count);      -- Количество занятий по C++

---- Объявляем переменные для текущего состояния расписания
--DECLARE @current_date DATE = @start_date_hardware;
--DECLARE @hw_counter TINYINT = 1;   -- Счётчик занятий по железу
--DECLARE @cpp_counter TINYINT = 1;  -- Счётчик занятий по C++

--WHILE @hw_counter <= @hardware_lessons_count OR @cpp_counter <= @cpp_lessons_count BEGIN
--    DECLARE @time TIME = @start_time;
--    DECLARE @week_num INT = DATEDIFF(WEEK, @start_date_hardware, @current_date) + 1; -- Номер учебной недели
--    DECLARE @day TINYINT = DATEPART(WEEKDAY, @current_date); -- День недели

--    IF @week_num % 2 <> 0 -- Нечётная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @hw_counter <= @hardware_lessons_count -- Занятия по железу ещё остались
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @hw_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @hw_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--            END
--            ELSE -- Если все занятия по железу закончились, ставим пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--            END
--        END
--        ELSE IF @day IN (3, 5) -- Среда и пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--        END
--    END
--    ELSE -- Четная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @hw_counter <= @hardware_lessons_count -- Есть занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @hw_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @hw_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--            END
--            ELSE -- Если все занятия по железу закончились, ставим пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--            END
--        END
--        ELSE IF @day = 3 -- Среда
--        BEGIN
--            IF @hw_counter <= @hardware_lessons_count -- Остались занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @hw_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @hw_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--            END
--            ELSE -- Если все занятия по железу закончились, ставим пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--            END
--        END
--        ELSE IF @day = 5 -- Пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @cpp_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--        END
--    END
    
--    -- Переходим на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN DATEPART(WEEKDAY, @current_date) = 5 THEN 3 ELSE 1 END, @current_date);
--END

--Решение домашнего задания
-- Установка первого дня недели на понедельник
--SET DATEFIRST 1;

--DECLARE @group								INT			=	(SELECT group_id			FROM Groups			WHERE group_name=N'PV_521');
--DECLARE @discipline_hardware				SMALLINT	=	(SELECT discipline_id		FROM Disciplines    WHERE discipline_name LIKE N'%Hardware%');
--DECLARE @discipline_c_plus_plus				SMALLINT	=	(SELECT discipline_id		FROM Disciplines    WHERE discipline_name LIKE N'%Процедурное%');
--DECLARE @hardware_lessons_count				TINYINT		=	(SELECT number_of_lessons	FROM Disciplines    WHERE discipline_id=@discipline_hardware);
--DECLARE @cpp_lessons_count					TINYINT		=	(SELECT number_of_lessons	FROM Disciplines    WHERE discipline_id=@discipline_c_plus_plus);
--DECLARE @teacher_hardware					INT			=	(SELECT teacher_id			FROM Teachers		WHERE last_name=N'Свищев');
--DECLARE @teacher_c_plus_plus				INT			=	(SELECT teacher_id			FROM Teachers		WHERE last_name=N'Ковтун');
--DECLARE @start_date_hardware				DATE		=	N'2024-03-04'; -- Дата начала занятий по железу
--DECLARE @start_date_c_plus_plus				DATE		=	N'2024-03-06'; -- Дата начала занятий по C++
--DECLARE @start_time							TIME		=	(SELECT start_time			FROM Groups			WHERE group_id=@group);

--PRINT(@hardware_lessons_count); -- Количество занятий по железу
--PRINT(@cpp_lessons_count);      -- Количество занятий по C++

---- Объявляем переменные для текущего состояния расписания
--DECLARE @current_date   DATE     = @start_date_hardware;
--DECLARE @hw_counter     TINYINT  = 1;  -- Счётчик занятий по железу
--DECLARE @cpp_counter    TINYINT  = 1;  -- Счётчик занятий по C++
--DECLARE @global_counter TINYINT  = 1;  -- Общий последовательный счётчик всех занятий

--WHILE @hw_counter <= @hardware_lessons_count OR @cpp_counter <= @cpp_lessons_count 
--BEGIN
--    DECLARE @time       TIME    = @start_time;
--    DECLARE @week_num   INT     = DATEDIFF(WEEK, @start_date_hardware, @current_date) + 1; -- Номер учебной недели
--    DECLARE @day        TINYINT = DATEPART(WEEKDAY, @current_date); -- День недели

--    IF @week_num % 2 <> 0 -- Нечётная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @hw_counter <= @hardware_lessons_count -- Занятия по железу ещё остались
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @global_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @global_counter += 1;
--            END
--            ELSE -- Если все занятия по железу закончились, ставим пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @global_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @global_counter += 1;
--            END
--        END
--        ELSE IF @day IN (3, 5) -- Среда и пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--            SET @global_counter += 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--            SET @global_counter += 1;
--        END
--    END
--    ELSE -- Четная учебная неделя
--    BEGIN
--        IF @day = 1 -- Понедельник
--        BEGIN
--            IF @hw_counter <= @hardware_lessons_count -- Есть занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @global_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @global_counter += 1;
--            END
--            ELSE -- Если все занятия по железу закончились, ставим пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @global_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @global_counter += 1;
--            END
--        END
--        ELSE IF @day = 3 -- Среда
--        BEGIN
--            IF @hw_counter <= @hardware_lessons_count -- Остались занятия по железу
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @global_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Аппаратное обеспечение');
--                SET @hw_counter += 1;
--                SET @global_counter += 1;
--            END
--            ELSE -- Если все занятия по железу закончились, ставим пару по C++
--            BEGIN
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @global_counter += 1;
--                SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--                PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--                SET @cpp_counter += 1;
--                SET @global_counter += 1;
--            END
--        END
--        ELSE IF @day = 5 -- Пятница
--        BEGIN
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--            SET @global_counter += 1;
--            SET @time = DATEADD(MINUTE, 95, @time); -- Интервал между парами 95 минут
--            PRINT FORMATMESSAGE('%d  %s  %s  %s  %s', @global_counter, CAST(@current_date AS NVARCHAR(24)), DATENAME(WEEKDAY, @current_date), CAST(@time AS NVARCHAR(24)), 'Программирование на C++');
--            SET @cpp_counter += 1;
--            SET @global_counter += 1;
--        END
--    END
    
--    -- Переходим на следующий день
--    SET @current_date = DATEADD(DAY, CASE WHEN DATEPART(WEEKDAY, @current_date) = 5 THEN 3 ELSE 1 END, @current_date);
--END