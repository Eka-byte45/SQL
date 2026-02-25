--SQLQuery1 -SELECT Schadule.sql
USE PV_521_Import;

--SELECT*FROM Schedule;
--DELETE FROM Schedule
--WHERE lesson_id BETWEEN 13033 AND 13056;

--DELETE FROM Schedule WHERE [group] = (SELECT group_id FROM Groups WHERE group_name=N'PV_521');
SELECT 
		 [Группа]			=	[group_name]
		,[Дисциплина]		=	discipline_name
		,[Преподаватель]	=	FORMATMESSAGE(N'%s %s %s',last_name,first_name,middle_name)
		,[Дата]				=	[date]
		,[День]				=	DATENAME(WEEKDAY,[date])
		,[Время]			=	[time]
		,[Статус]			=	IIF(spent=1,N'Проведено',N'Запланировано')
		--Тернарный оператор IIF(condidion,value_1,value_2)
FROM Schedule,Groups,Teachers,Disciplines
WHERE [group]	=	group_id
AND discipline	=	discipline_id
AND teacher		=	teacher_id
AND [group]     =   (SELECT group_id FROM Groups WHERE group_name=N'PV_521')
--AND discipline_name = N'Процедурное программирование на языке C++';
--AND discipline_name = N'Hardware-PC';
;
