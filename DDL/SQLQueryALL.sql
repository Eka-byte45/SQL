CREATE DATABASE PV_521_ALL_IN_ONE
ON
(
	NAME	=	PV_521_ALL_IN_ONE,
	FILENAME	= 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_521_ALL_IN_ONE.mdf',
	SIZE	=	8 MB,
	MAXSIZE	=	500 MB,
	FILEGROWTH	= 8 MB
)
LOG ON
(
	NAME	= PV_521_ALL_IN_ONE_log,
	FILENAME	= 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\PV_521_ALL_IN_ONE.ldf',
	SIZE	=	8 MB,
	MAXSIZE	=	500 MB,
	FILEGROWTH	= 8 MB
)
GO
USE PV_521_ALL_IN_ONE;
GO
CREATE TABLE Directions
(
	direction_id	TINYINT			PRIMARY	KEY,
	direction_name	NVARCHAR(150)	NOT NULL
);
CREATE TABLE Groups
(
	group_id	INT				PRIMARY KEY,
	group_name	NVARCHAR(24)	NOT NULL,
	direction	TINYINT			NOT NULL --описание поля
	CONSTRAINT FK_Groups_Direction FOREIGN KEY REFERENCES Directions(direction_id)
	--CONSTRAINT FK_Имя_ВнешнегоКлюча FOREIGN KEY REFERENCES Таблица(первичный_ключ_внешней_таблицы)
);
CREATE TABLE Students
(
	student_id	INT				PRIMARY KEY IDENTITY(1,1),
	last_name	NVARCHAR(50)	NOT NULL,
	first_name	NVARCHAR(50)	NOT NULL,
	middle_name	NVARCHAR(50),
	birth_date  DATE			NOT NULL,
	[group]		INT				NOT NULL
	CONSTRAINT FK_Students_Group FOREIGN KEY REFERENCES Groups(group_id)
);
CREATE TABLE Teachers
(
	teacher_id		INT				PRIMARY KEY,
	last_name		NVARCHAR(50)	NOT NULL,
	first_name		NVARCHAR(50)	NOT NULL,
	middle_name		NVARCHAR(50),
	birth_date		DATE			NOT NULL
);

CREATE TABLE Disciplines
(
	discipline_id		SMALLINT			PRIMARY KEY,
	discipline_name		NVARCHAR(256)		NOT NULL,
	number_of_lesson	TINYINT				NOT NULL
);
CREATE TABLE DisciplinesDirectionsRelation
(
	discipline	SMALLINT,
	direction	TINYINT,
	PRIMARY KEY (discipline,direction),
	CONSTRAINT FK_DDR_Discipline	FOREIGN KEY (discipline)				 REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DDR_Direction		FOREIGN KEY (direction)					 REFERENCES Directions(direction_id)
);
CREATE TABLE TeachersDisciplinesRelation
(
	teacher				INT,
	discipline			SMALLINT,
	PRIMARY KEY(teacher,discipline),
	CONSTRAINT FK_TDR_Teacher		FOREIGN KEY (teacher)					 REFERENCES Teachers(teacher_id),
	CONSTRAINT FK_TDR_Discipline	FOREIGN KEY (discipline)				 REFERENCES Disciplines(discipline_id)

);
CREATE TABLE RequiredDisciplines
(
	discipline				SMALLINT,
	required_discipline		SMALLINT,
	PRIMARY KEY(discipline,required_discipline),
	CONSTRAINT FK_RD_Discipline		FOREIGN KEY (discipline)				REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_RD_Required		FOREIGN KEY (required_discipline)		REFERENCES Disciplines(discipline_id)
);
CREATE TABLE DepenentDisciplines
(
	discipline				SMALLINT,
	dependent_discipline	SMALLINT,
	PRIMARY KEY(discipline,dependent_discipline),
	CONSTRAINT FK_DD_Discipline		FOREIGN KEY (discipline)				REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_DD_Dependent		FOREIGN KEY (dependent_discipline)		REFERENCES Disciplines(discipline_id)

);

CREATE TABLE Schedule
(
	lesson_id	INT		PRIMARY KEY,
	[date]		DATE,
	[time]		TIME,
	[group]		INT			NOT NULL,
	discipline	SMALLINT	NOT NULL,
	teacher		INT			NOT NULL,
	[subject]		NVARCHAR(256),
	[status]		BIT 
	CONSTRAINT FK_Schedule_Teacher FOREIGN KEY(teacher) REFERENCES Teachers(teacher_id),
	CONSTRAINT FK_Schedule_Disciplines FOREIGN KEY(discipline) REFERENCES Disciplines(discipline_id),
	CONSTRAINT FK_Schedule_Group FOREIGN KEY([group]) REFERENCES Groups(group_id) 
);
CREATE TABLE HomeWorks
(
	[group]		INT,
	lesson		INT,
	task		BINARY(1000),
	deadline	INT,
	PRIMARY KEY([group],lesson),
	CONSTRAINT FK_HW_Group		FOREIGN KEY([group])	REFERENCES Groups(group_id),
	CONSTRAINT FK_HW_Lesson		FOREIGN KEY(lesson)		REFERENCES Schedule(lesson_id),
	--CONSTRAINT FK_RHW_HomeWorks FOREIGN KEY([group],lesson) REFERENCES HomeWorks([group],lesson)
	
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
	CONSTRAINT FK_RHW_Student			FOREIGN KEY(student)			REFERENCES Students(student_id),
	CONSTRAINT FK_RHW_HOME_Works		FOREIGN KEY([group],lesson)		REFERENCES HomeWorks([group],lesson)

);
CREATE TABLE Grades
(
	student INT,
	lesson INT,
	grade_1 INT,
	grade_2 INT,
	PRIMARY KEY(student,lesson),
	CONSTRAINT FK_Grade_Student		FOREIGN KEY(student)	REFERENCES Students(student_id),
	CONSTRAINT FK_Grade_Lesson		FOREIGN KEY(lesson)		REFERENCES Schedule(lesson_id)

);
CREATE TABLE Exams
(
	student		INT,
	discipline	SMALLINT,
	grade INT,
	PRIMARY KEY (student,discipline),
	CONSTRAINT FK_Exams_Student			FOREIGN KEY (student)		REFERENCES Students(student_id),
	CONSTRAINT FK_Exams_Discipline		FOREIGN KEY (discipline)	REFERENCES Disciplines(discipline_id)

);
--DROP DATABASE IF EXISTS PV_521_ALL_IN_ONE;