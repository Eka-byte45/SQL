--SQLQuery2 AGREGATION.sql
USE PV_521_Import;

--SELECT* FROM Directions;
--SELECT* FROM Groups;
--SELECT *FROM Students;

--SELECT COUNT(direction_name) FROM Directions;

SELECT
	direction_name AS N'Направление обучения'
	,COUNT (group_id) AS N'Количество групп'
FROM Directions,Groups
WHERE direction = direction_id
GROUP BY direction_name
;

SELECT
	 direction_name AS N'Направление обучения'
	,COUNT (stud_id) AS N'Количество студентов'
FROM Students,Groups,Directions
WHERE [group] = group_id
AND direction= direction_id
GROUP BY direction_name
----HAVING COUNT(stud_id) >10
--;

SELECT
    direction_name AS 'Направление обучения',
    COUNT(DISTINCT group_id) AS 'Количество групп',
    COUNT(stud_id) AS 'Количество студентов'
FROM Directions 
LEFT JOIN Groups  ON direction_id = direction
LEFT JOIN Students  ON group_id = [group]
GROUP BY direction_name

SELECT 
    group_name AS 'Название группы',
    direction_name AS 'Название направления'
FROM Groups,Directions
WHERE 
    direction = direction_id
    AND direction_name = N'Разработка программного обеспечения';

 SELECT 
    group_name AS 'Название группы',
    direction_name AS 'Название направления'
FROM Groups,Directions
WHERE 
    direction = direction_id
    AND direction_name = N'Компьютерная графика и дизайн';

