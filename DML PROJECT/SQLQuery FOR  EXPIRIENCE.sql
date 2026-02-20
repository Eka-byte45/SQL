--SQLQuery FOR  EXPIRIENCE.sql

USE PV_521_Import;
----Количество студентов, обучающихся в группе PD_212
--SELECT COUNT(*) AS [Количество студентов]
--FROM Groups,Students
--WHERE [group] = group_id
--AND group_name LIKE 'PD_212 %'

----Названия групп в талице Группы
--SELECT group_name AS [Название групп]
--FROM Groups

----вся информация о студентах в таблице
--SELECT *FROM Students

----Количество всех студентов
--SELECT COUNT(*) AS [Количество студентов]
--FROM Students

----Минимальная дата рождения
--SELECT MAX (birth_date) AS [Минимальная дата рождения]
--FROM Students

----Количество студентов в каждой группе
--SELECT group_name AS [Название групп]
--		,COUNT(group_id) AS [Количество студентов]
--FROM Groups,Students
--WHERE [group]	=	group_id
--GROUP BY group_name;

--SELECT first_name AS [Имя студента]
--	,COUNT(stud_id) AS [Количество студентов]
--FROM Students,Groups
--WHERE [group] = group_id
--GROUP BY first_name;

--SELECT *FROM Salary;
SELECT*
FROM Groups INNER JOIN Students
ON [group] = group_id;