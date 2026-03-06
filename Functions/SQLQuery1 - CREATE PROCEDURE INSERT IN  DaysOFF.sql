--SQLQuery1 - CREATE PROCEDURE INSERT IN  DaysOFF.sql

USE PV_521_Import;
SET DATEFIRST 1;

GO

CREATE OR ALTER PROCEDURE sp_AddHolidays
    @year SMALLINT,
    @name NVARCHAR(50)
AS
BEGIN
    DECLARE @start_date DATE;
    DECLARE @duration TINYINT;
    DECLARE @holiday_id TINYINT;

    -- Ќачальна€ дата праздника
    SET @start_date = dbo.GetHolidayStartDate(@name, @year);
    
    -- ѕродолжительность праздника
    SELECT @duration = duration FROM Holidays WHERE holiday_name = @name;
    
    -- Id праздника
    SELECT @holiday_id = holiday_id FROM Holidays WHERE holiday_name = @name;

    IF @start_date IS NOT NULL AND @duration > 0 AND @holiday_id IS NOT NULL
    BEGIN
        DECLARE @date DATE;
        DECLARE @day TINYINT = 0;
        
        SET @date = @start_date;
        
        WHILE @day < @duration
        BEGIN
            -- ѕровер€ем, существует ли запись с таким праздником и датой
            IF NOT EXISTS
            (
                SELECT *
                FROM DaysOff
                WHERE [date] = @date AND holiday = @holiday_id
            )
            BEGIN
                INSERT INTO DaysOff([date], holiday)
                VALUES (@date, @holiday_id);
            END

            SET @day += 1;
            SET @date = DATEADD(DAY, 1, @date);
        END
    END
END