--SQLQuery1 -sp INSERT Lesson.sql

USE PV_521_Import;
--SET DATEFIRST 1;
--GO
--ALTER PROCEDURE sp_InsertLesson
	
--	@group_name			NCHAR(10),
--	@discipline_name	AS NVARCHAR(150),
--	@teacher			AS NVARCHAR(50),
--	@start_date			AS DATE,
--	@time				AS TIME OUTPUT,
--	@spent				AS BIT
	
--AS

--	IF NOT EXISTS(SELECT lesson_id FROM Schedule WHERE [date]=@start_date AND [time]=@time AND [group]=@group_name)
--BEGIN
--	INSERT INTO Schedule([group],discipline,teacher,[date],[time],spent)
--	VALUES(@group_name,@discipline_name,@teacher,@start_date,@time,IIF(@start_date<GETDATE(),1,0));
--	SET @time= DATEADD(MINUTE,95,@time);
--END

--GO
--CREATE OR ALTER PROCEDURE sp_InsertLesson
	
--	@group_name			NCHAR(10),
--	@discipline_name	AS NVARCHAR(150),
--	@teacher			AS NVARCHAR(50),
--	@start_date			AS DATE,
--	@time				AS TIME OUTPUT,
--	@spent				AS BIT,
--	@lesson_number		AS TINYINT OUTPUT
	
--AS
--BEGIN
--	IF NOT EXISTS(SELECT lesson_id FROM Schedule WHERE [date]=@start_date AND [time]=@time AND [group]=@group_name)
--BEGIN 
--	INSERT INTO Schedule([group],discipline,teacher,[date],[time],spent)
--	VALUES(@group_name,@discipline_name,@teacher,@start_date,@time,IIF(@start_date<GETDATE(),1,0));
--	SET @lesson_number = @lesson_number+1;
--	SET @time= DATEADD(MINUTE,95,@time);
--	END
--END

GO
CREATE OR ALTER PROCEDURE sp_InsertLesson
	
	@group				AS INT,
	@discipline 		AS SMALLINT,
	@teacher			AS SMALLINT,
	@date				AS DATE,
	@time				AS TIME OUTPUT,
	@lesson_number		AS TINYINT OUTPUT

AS
BEGIN
	PRINT(FORMATMESSAGE(N'%i  %s  %s  %s',@lesson_number,CAST(@date AS VARCHAR(24)),DATENAME(WEEKDAY,@date),CAST(@time AS VARCHAR(24))));
	IF NOT EXISTS(SELECT lesson_id FROM Schedule WHERE [date]=@date AND [time]=@time AND [group]=@group)
	BEGIN
		INSERT INTO Schedule
		VALUES(@group,@discipline,@teacher,@date,@time,IIF(@date<GETDATE(),1,0));
	END
		SET @lesson_number = @lesson_number+1;
		SET @time= DATEADD(MINUTE,95,@time);	
END
