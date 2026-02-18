--SQLQuery3 SELECT TEACHERS.sql
USE PV_521_Import;

--SELECT
--		[Преподаватель]		=	 FORMATMESSAGE(N'%s %s %s',last_name,first_name,middle_name)
--		,[Дата рождения]	=	birth_date
--		,[Возраст]			=	CAST(DATEDIFF(DAY,birth_date,GETDATE())/365.25 AS TINYINT)
--FROM Teachers
----ORDER BY last_name DESC
----ORDER BY birth_date DESC
----ORDER BY [Возраст] ASC
----WHERE CAST(DATEDIFF(DAY,birth_date,GETDATE())/365.25 AS TINYINT) >=40
--WHERE CAST(DATEDIFF(DAY,birth_date,GETDATE())/365.25 AS TINYINT)BETWEEN 38 AND 44
--ORDER BY [Возраст] ASC
----ASC  - Ascending (По возрастанию)
----DESC - Descending(По убыванию)
--;

SELECT 
		[Преподаватель]			=	FORMATMESSAGE(N'%s %s %s',last_name,first_name,middle_name)
		,[Количество дисциплин]	=	COUNT(discipline_id)
		FROM Teachers,TeachersDisciplinesRelation,Disciplines
		WHERE teacher = teacher_id
		AND discipline = discipline_id
		GROUP BY last_name,first_name,middle_name
;
		
		
SELECT
	[Наименование дисциплины] = discipline_name
	,[Количество преподавателей] = COUNT(teacher_id)
	FROM Teachers,TeachersDisciplinesRelation,Disciplines
	WHERE teacher = teacher_id
	AND discipline = discipline_id
	GROUP BY discipline_name
	
SELECT
	[Преподаватель]			=	FORMATMESSAGE(N'%s %s %s',last_name,first_name,middle_name)
	,[Наименование дисциплины] = discipline_name
	FROM Teachers,TeachersDisciplinesRelation,Disciplines
	WHERE teacher = teacher_id
	AND discipline = discipline_id
	AND last_name = N'Ковтун';
