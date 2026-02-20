--SQLQuery4 - SELECTAggregateStudentsAndGroups.sql
USE PV_521_Import;

SELECT 
	   direction_name AS N'Направление обучения'
	  ,(SELECT COUNT(DISTINCT group_id) FROM Groups WHERE direction = direction_id) AS N'Количество групп'
	  ,(SELECT COUNT(stud_id) FROM Students,Groups WHERE [group] = group_id AND direction=direction_id )AS N'Количество студентов'
FROM Directions
;

SELECT 
	   direction_name			 AS N'Направление обучения'
	   ,COUNT(DISTINCT group_id) AS N'Количество групп'
	   ,COUNT(stud_id)			 AS N'Количество студентов'	   
FROM Students,Groups,Directions
WHERE [group]	=	group_id
AND direction	=	direction_id
GROUP BY direction_name
;
