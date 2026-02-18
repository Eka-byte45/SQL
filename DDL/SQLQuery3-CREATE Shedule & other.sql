--SQLQuery3-CREATE Shedule & other.sql
USE PV_521_DDL;

CREATE TABLE Schedule
(
	lesson_id	INT		PRIMARY KEY,
	[date]		DATE,
	[time]		TIME,
	[group]		INT			NOT NULL,
	discipline	SMALLINT	NOT NULL,
	teacher		INT			NOT NULL,
	[subject]	NVARCHAR(256),
	[status]	BIT 
	CONSTRAINT FK_Schedule_Teacher		FOREIGN KEY(teacher)		REFERENCES Teachers(teacher_id),
	CONSTRAINT FK_Schedule_Disciplines	FOREIGN KEY(discipline)		REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_Schedule_Group		FOREIGN KEY([group])		REFERENCES Groups(group_id) 
);
CREATE TABLE HomeWorks
(
	[group]		INT,
	lesson		INT,
	task		BINARY(1000),
	deadline	INT,
	PRIMARY KEY([group],lesson),
	CONSTRAINT FK_HW_Group		FOREIGN KEY([group])	REFERENCES Groups(group_id),
	CONSTRAINT FK_HW_Lesson		FOREIGN KEY(lesson)		REFERENCES Schedule(lesson_id)
		
);
CREATE TABLE ResultsHomeWorks
(
	student		INT,
	[group]		INT,
	lesson		INT,
	result		BINARY(1000),
	report		INT,
	grade		INT,
	PRIMARY KEY(student,[group],lesson),
	CONSTRAINT FK_RHW_Student		FOREIGN KEY(student)			REFERENCES Students(student_id),
	CONSTRAINT FK_RHW_HOME_Works	FOREIGN KEY([group],lesson)		REFERENCES HomeWorks([group],lesson)

);
CREATE TABLE Grades
(
	student INT,
	lesson INT,
	grade_1 INT,
	grade_2 INT,
	PRIMARY KEY(student,lesson),
	CONSTRAINT FK_Grade_Student FOREIGN KEY(student)	REFERENCES Students(student_id),
	CONSTRAINT FK_Grade_Lesson	FOREIGN KEY(lesson)		REFERENCES Schedule(lesson_id)

);
--DROP TABLE Schedule;