USE PV_521_DDL;
CREATE TABLE Exams
(
	student		INT,
	discipline	SMALLINT,
	grade INT,
	PRIMARY KEY (student,discipline),
	CONSTRAINT FK_Exams_Student		FOREIGN KEY (student)		REFERENCES Students(student_id),
	CONSTRAINT FK_Exams_Discipline	FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id)

);
--DROP TABLE Exams;