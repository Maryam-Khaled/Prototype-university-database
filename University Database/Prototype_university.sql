

CREATE DATABASE PROTOTYPE_UNIVERSITY;

USE PROTOTYPE_UNIVERSITY;

--CREATING TABLES:
CREATE TABLE STUDENT(
StudentId INT,
Fname VARCHAR(50) NOT NULL,
Lname VARCHAR(50) NOT NULL,
Bdate VARCHAR(50),
Levell INT,
MajorCode VARCHAR(50),
CONSTRAINT StudentPK PRIMARY KEY(StudentId),
CONSTRAINT StudentCHECKLevell CHECK(Levell IN(1, 2, 3, 4))
);

CREATE TABLE FACULTY(
FacultyCode INT IDENTITY(200, 1),
FacultyName VARCHAR(50) NOT NULL,
CONSTRAINT FacultyPK PRIMARY KEY(FacultyCode),
CONSTRAINT FacultyUNIQUE UNIQUE(FacultyName)
);

CREATE TABLE MAJOR(
MajorCode VARCHAR(50) NOT NULL,
MajorName VARCHAR(50),
FacultyCode INT,
CONSTRAINT MajorPK PRIMARY KEY(MajorCode),
CONSTRAINT MajorUNIQUE UNIQUE(MajorName)
);

CREATE TABLE INSTRUCTOR(
InstId INT NOT NULL,
Fname VARCHAR(50) NOT NULL,
Lname VARCHAR(50) NOT NULL,
Stattus VARCHAR(50),
FacultyCode INT,
Salary MONEY,
CONSTRAINT InstructorCHECKSalary CHECK(Salary BETWEEN 5000 AND 30000)
);

ALTER TABLE INSTRUCTOR
ADD CONSTRAINT InstructorPK PRIMARY KEY(InstId);

CREATE TABLE COURSE(
MajorCode VARCHAR(50) NOT NULL,
CourseNo VARCHAR(50) NOT NULL,
CourseName VARCHAR(50) NOT NULL,
CreditHours INT,
CONSTRAINT CourseFK FOREIGN KEY(MajorCode) REFERENCES MAJOR(MajorCode),
CONSTRAINT CourseUNIQUE UNIQUE(CourseName)
);


ALTER TABLE COURSE 
ADD CONSTRAINT CoursePK PRIMARY KEY(MajorCode, CourseNo);

CREATE TABLE SECTION(
MajorCode VARCHAR(50),
CourseNo VARCHAR(50),
SectionNo INT,
Semester VARCHAR(50),
Yearr INT,
weekDay VARCHAR(50),
Timee INT,
InstId INT,
CONSTRAINT SectionPK PRIMARY KEY(MajorCode, CourseNo, SectionNo, Semester, Yearr),
CONSTRAINT SectionFK1 FOREIGN KEY(MajorCode,CourseNo) REFERENCES COURSE(MajorCode, CourseNo),
CONSTRAINT SectionFK2 FOREIGN KEY(InstId) REFERENCES INSTRUCTOR(InstId),
CONSTRAINT SectionCHECKSemester CHECK(Semester IN('Fall', 'Spring'))
);

CREATE TABLE TRANSCRIPT(
StudentId INT,
MajorCode VARCHAR(50),
CourseNo VARCHAR(50),
SectionNo INT,
Semester VARCHAR(50),
Yearr INT,
Grade CHAR(1),
CONSTRAINT TranscriptPK PRIMARY KEY(StudentId, MajorCode, CourseNo, SectionNo, Semester, Yearr),
CONSTRAINT TranscriptCHECKGrade CHECK(Grade IN('A', 'B', 'C', 'D', 'F'))
);

--ALTERING EXISTING TABLES:
ALTER TABLE STUDENT
ADD Gender CHAR(1);

ALTER TABLE SECTION
ALTER COLUMN Timee VARCHAR(50);

ALTER TABLE INSTRUCTOR
ADD CONSTRAINT InstructorFK FOREIGN KEY(FacultyCode) REFERENCES FACULTY(FacultyCode);

ALTER TABLE STUDENT
ADD CONSTRAINT StudentFK FOREIGN KEY(MajorCode) REFERENCES MAJOR(MajorCode);

ALTER TABLE STUDENT
ADD CONSTRAINT StudentCHECKGender CHECK(Gender IN('M','F'));

ALTER TABLE MAJOR
ADD CONSTRAINT MajorFK FOREIGN KEY(FacultyCode) REFERENCES FACULTY(FacultyCode);

ALTER TABLE TRANSCRIPT
ADD CONSTRAINT TranscriptFK1 FOREIGN KEY(StudentId) REFERENCES STUDENT(StudentId);

ALTER TABLE TRANSCRIPT
ADD CONSTRAINT TranscriptFK2 FOREIGN KEY(MajorCode, CourseNo, SectionNo, Semester, Yearr) REFERENCES SECTION(MajorCode, CourseNo, SectionNo, Semester, Yearr);

--INSERTING VALUES IN THE TABLES:
INSERT INTO STUDENT VALUES(20214402, 'Maryam', 'Abobakr', '2003-11-7', 2, '200-DM', 'F'),
(20211102, 'Nour', 'Safan', '2003-11-7', 2, '200-DM', 'F'),
(20213232, 'Farah', 'Ahraf', '2003-8-2', 2, '200-DM', 'F'),
(20214403, 'Malak', 'Hussein', '2003-6-11', 2, '200-DM', 'F'),
(20212211, 'Shaimma', 'Ahmad', '2003-5-19', 2, '200-DM', 'F'),
(20212156, 'Sara', 'Maged', '2003-2-27', 2, '200-CS', 'F'),
(20213376, 'Salma', 'Ahmad', '2003-11-23', 2, '200-IS', 'F'),
(20211004, 'Eman', 'Mohammad', '2003-9-15', 2, '200-CS', 'F'),
(20204302, 'Ali', 'Abobakr', '2002-10-3', 3, '205-Bio', 'M'),
(20181008, 'Omar', 'Abobakr', '2000-4-27', 4, '205-Bio', 'M'),
(20184402, 'Sayed', 'Monir', '2000-4-27', 4, '204-FM', 'M'),
(20192908, 'Amir', 'Khaled', '2001-4-27', 4, '203-Fren', 'M'),
(20192402, 'Amr', 'Abdallah', '2001-4-27', 3, '203-Eng', 'M'),
(20201404, 'Khaled', 'Abobakr', '2002-4-27', 3, '202-Acc', 'M'),
(20202795, 'Shahed', 'Khairy', '2002-5-19', 3, '200-IS', 'F'),
(20135500, 'Rasha', 'Amin', '1995-5-19', 4, '208-Phy', 'F'),
(20085690, 'Amin', 'Hamouda', '1990-5-19', 4, '208-Math', 'M'),
(20201111, 'Obaida', 'Marzouk', '2002-5-19', 3, '202-Mark', 'M'),
(20213123, 'Sohaila', 'Hany', '2003-5-19', 1, '209-Psych', 'F');

INSERT INTO FACULTY VALUES('Computer Science'),
('Engineering'),
('Business'),
('Languages & Literature'),
('Arts'),
('Pharmacy'),
('Political Science'),
('Oral & Dental Medicine'),
('Natural Sciences'),
('Social Sciences');

INSERT INTO MAJOR VALUES('200-CS', 'ComputerScience', 200),  
('200-DM', 'Digital Media', 200),
('200-IS', 'Information Systems', 200), 
('202-Acc', 'Accounting', 202), 
('202-Mark', 'Marketing', 202),  
('203-Eng', 'English', 203),
('203-Fren', 'French', 203),
('204-FM', 'Film making', 204),
('205-Bio', 'Biology', 205), 
('208-Math', 'Mathematics', 208), 
('208-Phy', 'Physics', 208), 
('209-Psych', 'Psychology', 209);

INSERT INTO INSTRUCTOR VALUES(4600, 'Mohammad', 'Attia', 'FullTime', 200, 20000),
(4601, 'Sabah', 'Sayed', 'FullTime', 200, 15500),
(4602, 'Heba', 'Mohsen', 'FullTime', 200, 6000),
(4603, 'Dalia', 'Alsaiid', 'FullTime', 202, 16000),
(4604, 'Nadeen', 'Ramadan', 'PartTime', 203, 5500),
(4605, 'Hassan', 'Hamdy', 'FullTime', 204, 7500),
(4606, 'Khaled', 'Mahmoud', 'FullTime', 205, 25000),
(4607, 'Mariam', 'Ali', 'FullTime', 208, 9000),
(4608, 'Heba', 'Hamdy', 'FullTime', 205, 15500),
(4609, 'Yousef', 'Mohammad', 'PartTime', 202, 6500),
(4610, 'Yahia', 'El Sawda', 'FullTime', 203, 6000),
(4611, 'Amr', 'Mansour', 'PartTime', 209, 6000);

INSERT INTO COURSE VALUES('200-CS', 'CS232', 'Software Engineering1', 3),
('200-IS', 'IS211', 'Database1', 3),
('200-DM', 'DM251', 'Web Design', 4),
('202-Mark', 'Mark343', 'Advertising', 3),
('202-Acc', 'Acc355', 'Cost Accounting', 3),
('203-Eng', 'Eng412', 'Postcolonial literature', 4),
('203-Fren', 'Fren556', 'Francophone literature', 4 ),
('204-FM', 'FM598', 'Camera and Lighting techniques', 3),
('205-Bio', 'Bio639', 'Genetics', 4),
('208-Math', 'Math799', 'Foundations Math', 4),
('208-Phy', 'Phy824', 'Electricity and Magnetism', 4),
('209-Psych', 'Psych873', 'Forensic Psychology', 3);

INSERT INTO SECTION VALUES('200-CS', 'CS232', 1, 'Fall', 2021, 'Monday', '11:00 AM', 4602),
('200-IS', 'IS211', 2, 'Spring', 2022, 'Monday', '9:00 AM', 4600),
('200-DM', 'DM251', 3, 'Spring', 2023, 'Sunday', '11:00 AM', 4601),
('202-Mark', 'Mark343', 4, 'Fall', 2022, 'Wednesday', '11:00 AM', 4609),
('202-Acc', 'Acc355', 2, 'Spring', 2021, 'Wednesday', '9:00 AM', 4603),
('203-Eng', 'Eng412', 7, 'Fall', 2020, 'Tuesday', '11:00 AM', 4610),
('203-Fren', 'Fren556', 1, 'Spring', 2022, 'Sunday', '1:00 PM', 4604),
('204-FM', 'FM598', 10, 'Fall', 2023,'Thursday', '9:00 AM', 4605),
('205-Bio', 'Bio639', 4, 'Fall', 2020, 'Saturday', '11:00 AM', 4608),
('208-Math', 'Math799', 3, 'Spring', 2014, 'Sunday', '1:00 PM', 4607),
('208-Phy', 'Phy824', 2, 'Spring', 2015, 'Saturday', '3:00 PM', 4607),
('209-Psych', 'Psych873', 1, 'Fall', 2023, 'Monday', '3:00 PM', 4606);

INSERT INTO TRANSCRIPT VALUES(20214402, '200-DM', 'DM251', 3, 'Spring', 2023, 'A'),
(20211102, '200-DM', 'DM251', 3, 'Spring', 2023, 'A'),
(20213232, '200-DM', 'DM251', 3, 'Spring', 2023, 'A'),
(20214403, '200-DM', 'DM251', 3, 'Spring', 2023, 'A'),
(20212211, '200-DM', 'DM251', 3, 'Spring', 2023, 'B'),
(20212156, '200-CS', 'CS232', 1, 'Fall', 2021, 'B'),
(20213376, '200-IS', 'IS211', 2, 'Spring', 2022, 'A'),
(20211004, '200-CS', 'CS232', 1, 'Fall', 2021, 'A'),
(20204302, '205-Bio', 'Bio639', 4, 'Fall', 2020, 'A'),
(20181008, '205-Bio','Bio639', 4, 'Fall', 2020, 'B'),
(20184402, '204-FM', 'FM598', 10, 'Fall', 2023, 'F'),
(20192908, '203-Fren', 'Fren556', 1, 'Spring', 2022, 'C'),
(20192402, '203-Eng', 'Eng412', 7, 'Fall', 2020, 'C'),
(20201404, '202-Acc', 'Acc355', 2, 'Spring', 2021, 'A'),
(20202795, '200-IS', 'IS211', 2, 'Spring', 2022, 'D'),
(20135500, '208-Phy', 'Phy824', 2, 'Spring', 2015, 'A'),
(20085690, '208-Math', 'Math799', 3, 'Spring', 2014, 'A'),
(20201111, '202-Mark', 'Mark343', 4, 'Fall', 2022, 'C'),
(20213123, '209-Psych', 'Psych873', 1, 'Fall', 2023, 'A');

--Displaying data:
--Q11
SELECT * FROM STUDENT;

--Q12
SELECT * FROM FACULTY ORDER BY FacultyCode DESC;

--Q13
SELECT * FROM STUDENT WHERE Gender = 'M';

--Q14
SELECT Fname + ' ' + Lname AS 'Student_Name' FROM STUDENT WHERE Gender = 'M';

--Q15
--CHECK IF IT IS RIGHT:
SELECT *, DateDiff(MONTH, Bdate, GETDATE()) AS 'Age in months'  FROM STUDENT WHERE Gender = 'F' AND DateDiff(MONTH, Bdate, GETDATE()) > 150;

--Q16
SELECT * FROM INSTRUCTOR WHERE Salary BETWEEN 15000 AND 17550;

--Q17
SELECT * FROM INSTRUCTOR WHERE Salary IN(1000, 5000, 8000, 15000, 20000);

--Q18
SELECT Fname + ' ' + Lname AS 'Full name' FROM STUDENT WHERE MajorCode IS NOT NULL;

--Q19
SELECT COUNT(SectionNo) FROM SECTION WHERE InstId IS NULL;

--Q20
SELECT SUM(Salary) AS 'Total_salaries', FACULTY.FacultyName FROM INSTRUCTOR INNER JOIN FACULTY ON INSTRUCTOR.FacultyCode = FACULTY.FacultyCode GROUP BY FacultyName HAVING SUM(Salary) > 5000;

--Q21
SELECT * FROM STUDENT WHERE Levell = 4 ORDER BY Lname ASC;

--Q22
SELECT StudentId, Fname, Lname FROM STUDENT WHERE Levell = 4 AND Gender = 'M';

--Q23
SELECT StudentId, Fname, Lname FROM STUDENT WHERE Bdate IS NULL;

--Q24
SELECT * FROM STUDENT ORDER BY Levell ASC, Lname ASC;

--Q25
SELECT * FROM SECTION WHERE Semester = 'Spring' AND Yearr = 2023;

--Q26
SELECT * FROM STUDENT ORDER BY Levell DESC, Fname ASC;

--Q27
SELECT * FROM SECTION WHERE Semester = 'Spring' AND Yearr = 2023 AND InstId IS NULL;

--Q28
SELECT * FROM STUDENT WHERE Fname LIKE 'Moh%' AND Lname LIKE '%sh';

--Q29
SELECT * FROM STUDENT WHERE Fname LIKE '_h%';

--Q30
SELECT DATEDIFF(YEAR, Bdate, GETDATE()) AS 'Student_Age' FROM STUDENT WHERE DATEDIFF(YEAR, Bdate, GETDATE()) > 22;

--Q31
SELECT Salary*1.1 FROM INSTRUCTOR;

--Q32
SELECT Fname, SUM(Salary) AS 'Total salaries', SUM(Salary*1.15) AS 'Total salaries after raise' FROM INSTRUCTOR WHERE FacultyCode = 200 GROUP BY Fname;

--Q33
SELECT * FROM SECTION WHERE InstId = 4600 AND Semester = 'Spring' AND Yearr = 2023;

--Q34
SELECT * FROM SECTION  WHERE InstId = 4600 AND Yearr IN(2021, 2022, 2023);

--Q35
SELECT INSTRUCTOR.Fname FROM INSTRUCTOR INNER JOIN SECTION ON INSTRUCTOR.InstId = SECTION.InstId WHERE INSTRUCTOR.FacultyCode = 200 AND SECTION.Semester != 'Spring' AND Yearr != 2023;

--Q36
SELECT MAJOR.MajorName FROM MAJOR INNER JOIN STUDENT ON MAJOR.MajorCode = STUDENT.MajorCode GROUP BY MAJOR.MajorName HAVING COUNT(StudentId) < 20;

--Q37
SELECT SectionNo, Grade, COUNT(StudentId) AS 'Number of students' FROM TRANSCRIPT WHERE Yearr IN(2019, 2020) GROUP BY SectionNo, Grade;

--Q38
SELECT COUNT(InstId) AS 'Number of instructors', FACULTY.FacultyName  FROM INSTRUCTOR INNER JOIN FACULTY ON INSTRUCTOR.FacultyCode = FACULTY.FacultyCode WHERE Stattus = 'PartTime' GROUP BY FACULTY.FacultyName;

--Q39
SELECT STUDENT.Fname, STUDENT.Lname, COURSE.CourseName, MAJOR.MajorName, TRANSCRIPT.Grade
FROM STUDENT INNER JOIN TRANSCRIPT
ON STUDENT.StudentId = TRANSCRIPT.StudentId INNER JOIN MAJOR ON 
TRANSCRIPT.MajorCode = MAJOR.MajorCode INNER JOIN COURSE ON MAJOR.MajorCode = COURSE.MajorCode
WHERE TRANSCRIPT.Grade IN('A','B', 'C', 'D');

--Q40
SELECT FACULTY.FacultyName, MAJOR.MajorName, TRANSCRIPT.Semester, COUNT(STUDENT.StudentId) AS 'Passed students' FROM STUDENT INNER JOIN TRANSCRIPT
ON STUDENT.StudentId = TRANSCRIPT.StudentId INNER JOIN MAJOR ON TRANSCRIPT.MajorCode = MAJOR.MajorCode INNER JOIN FACULTY
ON MAJOR.FacultyCode = FACULTY.FacultyCode WHERE TRANSCRIPT.Grade IN('A', 'B', 'C', 'D') AND TRANSCRIPT.Semester = 'Spring'
GROUP BY FACULTY.FacultyName, MAJOR.MajorName, TRANSCRIPT.Semester ORDER BY COUNT(STUDENT.StudentId) DESC;





