--@author:
--HARSHA VARDHANRAM KALYANARAMAN

---------------------------------------------------JOB-OVERFLOW DATABASE----------------------------------------------------------------

CREATE DATABASE Group14_JobOverflow;

USE Group14_JobOverflow;

DROP DATABASE Group14_JobOverflow;

----------------------------------------------------------COUNTRY-------------------------------------------------------------------------
drop table Counrty;

--Create Table Country
CREATE TABLE Country 
(
 CountryID int IDENTITY (1,1) PRIMARY KEY,
 CountryName varchar(40) NOT NULL,
 last_update datetime not null DEFAULT getdate()
);

--Insert Country details
INSERT INTO Country(CountryName,Last_Update)
VALUES 
('India',GETDATE()),
('China',GETDATE()),
('Japan',GETDATE()),
('US',GETDATE()),
('Pakistan',GETDATE()),
('UK',GETDATE()),
('Australia',GETDATE()),
('Newzealand',GETDATE()),
('Southafrica',GETDATE()),
('Srilanka',GETDATE());

select * from country;

UPDATE Country
SET Countryname = 'Brazil'
--statename = 'State of Rio De Janeiro',
--cityname = 'Rio De Janeiro'
WHERE CountryID = 2

UPDATE Country
SET Countryname = 'New Zealand'
WHERE CountryID = 8

UPDATE Country
SET Countryname = 'US'
WHERE CountryID = 9

----------------------------------------------------------STATE-------------------------------------------------------------------------

drop table State

--Create Table State

CREATE TABLE State
(
 StateID int IDENTITY(1,1) PRIMARY KEY,
 CountryID int NOT NULL 
      REFERENCES dbo.Country(CountryID),
 StateName varchar(50) NOT NULL ,
 Zipcode int NOT NULL , 
 last_update datetime not null DEFAULT getdate()
);

--Insert State Details
INSERT INTO State(CountryID,StateName,Zipcode,Last_Update)
VALUES 
(1,'Tamil Nadu',12345,GETDATE()),
(2,'Beijing',23145,GETDATE()),
(3,'Tokyo',11234,GETDATE()),
(4,'Massachusetts',02130,GETDATE()),
(5,'Islamabad',55678,GETDATE()),
(6,'London',66789,GETDATE()),
(7,'Canberra',77480,GETDATE()),
(8,'Wellington',88345,GETDATE()),
(9,'CapeTown',13131,GETDATE()),
(10,'Colombo',37689,GETDATE());

select * from State

UPDATE State
SET statename = 'State of Rio De Janeiro'
WHERE CountryID = 2

UPDATE State
SET statename = 'Texas'
WHERE CountryID = 9

UPDATE State
SET statename = 'Western Australia'
WHERE CountryID = 7
----------------------------------------------------------CITY-------------------------------------------------------------------------

drop table city;

--Create Table city
CREATE TABLE City
(
 CityID int IDENTITY (1,1) PRIMARY KEY,
 StateID int NOT NULL
     REFERENCES dbo.State(StateID),
 CityName varchar(50) NOT NULL,
 last_update datetime not null DEFAULT getdate()
);

--Insert City Details
INSERT INTO City(StateID,CityName,Last_Update)
VALUES 
(1,'chennai',GETDATE()),
(2,'Miyun',GETDATE()),
(3,'Inagi',GETDATE()),
(4,'Westborough',GETDATE()),
(5,'Rawalpindi',GETDATE()),
(6,'SouthWark',GETDATE()),
(7,'Perth',GETDATE()),
(8,'Nelson',GETDATE()),
(9,'Bloemfontein',GETDATE()),
(10,'Kandy',GETDATE());

select * from City

UPDATE City
SET CityName = 'Rio De Janeiro'
WHERE StateID = 2

UPDATE City
SET CityName = 'Dallas'
WHERE StateID = 9
----------------------------------------------------------ADDRESS-------------------------------------------------------------------------

drop table Address;

--Create Table Address

CREATE TABLE Address 
(
 AddressID int IDENTITY (1,1) PRIMARY KEY,
 CityID int NOT NULL 
     REFERENCES dbo.City(CityID),
 Apt_Number int NOT NULL ,
 Street_Number int NOT NULL ,
 last_update datetime not null DEFAULT getdate()
);

/*Altering address table*/
Alter table address
add Street_name varchar(100) not null

--Insert Address Details
INSERT INTO Address(CityID,Apt_Number,street_name,Street_Number,Last_Update)
VALUES
(1,23,'Thangal Street',4,GETDATE()),
(2,26,'China town',3,GETDATE()),
(3,29,'Nagaqu',7,GETDATE()),
(4,31,'South huntington avenue',6,GETDATE()),
(5,36,'Karachi',4,GETDATE()),
(6,17,'Mayfair',9,GETDATE()),
(7,12,'Opera street',1,GETDATE()),
(8,34,'Auckland',12,GETDATE()),
(9,11,'Dale street',22,GETDATE()),
(10,41,'Colombo street',23,GETDATE()),
(4,1,'Huntington',32,GETDATE()),
(4,21,'Tremont',42,GETDATE()),
(4,31,'Roxbury street',52,GETDATE()),
(4,51,'Lechmere',62,GETDATE()),
(4,61,'Back Bay street',72,GETDATE()),
(4,71, 'Goverment Center',82,GETDATE()),
(4,81,'Park Street',92,GETDATE()),
(4,91, 'Hay Market',102,GETDATE()),
(4,101,'Fenway',112,GETDATE()),
(4,102,'Acton',122,GETDATE());

SELECT * FROM Address;


----------------------------------------------------------STUDENT-------------------------------------------------------------------------


DROP FUNCTION fn_CalcAge;

--1st computed column
/* Function fn_calcAge returns age when passed a DOB as a parameter */

CREATE FUNCTION fn_CalcAge(@DOB Date)
RETURNS INT
AS
	BEGIN
		DECLARE @totalAge INT = 
			(SELECT DATEDIFF (hour,@DOB,GETDATE())/8766);
		RETURN @totalAge
END


DROP FUNCTION fn_CalcPerformance;

--2nd computed column
/* Function fn_CalcPerformance returns performance evaluation  when passed GPA as an argument */
CREATE FUNCTION fn_CalcPerformance(@GPA Float)
RETURNS VARCHAR(10)
AS
	BEGIN
		DECLARE @perf VARCHAR(10) = 
			(SELECT 
				CASE 
					WHEN @GPA BETWEEN 0 AND 1 THEN 'Poor'
					WHEN  @GPA BETWEEN 1.1 AND 2 THEN 'Average'
					WHEN @GPA BETWEEN 2.1 AND 3 THEN 'Good'
					ELSE 'Excellent'
				END 
				);
		RETURN @perf
END

DROP TABLE Student

--Create student table

CREATE TABLE Student 
(
 StudentID int IDENTITY (1,1) PRIMARY KEY,
 StudentLastName varchar(40) NOT NULL,
 StudentFirstName varchar(40) NOT NULL,
 DOB Date NOT NULL,
 Age AS (dbo.fn_CalcAge(DOB)),
 Phone_Number varchar(15) NOT NULL,
 Email_Address varchar(80) NOT NULL,
 Gender varchar(20) NOT NULL,
 last_update datetime not null DEFAULT getdate(),
 AddressID int NOT NULL 
     REFERENCES dbo.Address(AddressID),
 GPA FLOAT ,
 Performance_Evaluation AS (dbo.fn_CalcPerformance(GPA))
);

--Insert Student Details
INSERT INTO dbo.Student (StudentLastName,StudentFirstName,DOB,Phone_Number,Email_Address,Gender,Last_Update,AddressID,GPA)
VALUES 
('kumar','pradheep','01-02-1997','8451233456','pk@gmail.com','Male',GETDATE(),1,4),
('Kanakasabai','Ganeshram','09-21-1996','8578003456','gk@gmail.com','Male',GETDATE(),2,4),
('Raman','Navin','08-22-1996','8578003445','nr@gmail.com','Male',GETDATE(),3,3.1),
('Kalyanaraman','Harshavardhanram','04-09-1997','8578003986','hk@gmail.com','Male',GETDATE(),4,2.1),
('chan','Jackie','09-02-1996','8578003956','jc@gmail.com','Male',GETDATE(),5,1.1),
('Johnson','Dwane','07-24-1998','8578001234','dj@gmail.com','Male',GETDATE(),6,0.1),
('Damooo','Vishal','03-18-1997','8578002998','vm@gmail.com','Male',GETDATE(),7,3),
('Joseph','Vijay','09-27-1995','8234567812','jv@gmail.com','Male',GETDATE(),8,0),
('Prasad','Venkat','02-21-1999','8578003356','vp@gmail.com','Male',GETDATE(),9,1),
('Pasricha','Suhas','10-12-1994','8578009877','sp@gmail.com','Male',GETDATE(),10,2);

SELECT * FROM Student;

ALTER TABLE Student ADD Desired_Job VARCHAR(20) NULL;

UPDATE Student
SET Desired_Job = 'Full Stack Engineer'
WHERE StudentID = 1

UPDATE Student
SET Desired_Job = 'IoT Engineer'
WHERE StudentID = 2

UPDATE Student
SET Desired_Job = 'Network Engineer'
WHERE StudentID = 3

UPDATE Student
SET Desired_Job = 'Network Engineer'
WHERE StudentID = 4

UPDATE Student
SET Desired_Job = 'Java Developer'
WHERE StudentID = 5

UPDATE Student
SET Desired_Job = 'Cloud Engineer'
WHERE StudentID = 6

UPDATE Student
SET Desired_Job = 'Data Scientist'
WHERE StudentID = 7

UPDATE Student
SET Desired_Job = 'Database Engineer'
WHERE StudentID = 8

UPDATE Student
SET Desired_Job = 'Business Analyst'
WHERE StudentID = 9

UPDATE Student
SET Desired_Job = 'Data Scientist'
WHERE StudentID = 10

----------------------------------------------------------COMPANY-------------------------------------------------------------------------

drop table Company

--Create table Company
CREATE TABLE Company
(
 CompanyID int IDENTITY (1,1) PRIMARY KEY,
 CompanyName varchar(40) NOT NULL ,
 AddressID int NOT NULL
     REFERENCES dbo.Address(AddressID),
 last_update datetime not null DEFAULT getdate()
);

--Insert Company Details
INSERT INTO Company(CompanyName,AddressID,Last_Update)
VALUES
('Charles River Development',11,GETDATE()),
('Boston Scientific',12,GETDATE()),
('Amazon',13,GETDATE()),
('Philips',14,GETDATE()),
('Wayfair',15,GETDATE()),
('Akuna Capitals',16,GETDATE()),
('Google',17,GETDATE()),
('Bose Technologies',18,GETDATE()),
('Paypal',19,GETDATE()),
('Uber',20,GETDATE());

SELECT * FROM Company;

----------------------------------------------------------SUGGESTED COURSE-------------------------------------------------------------------------
drop table SuggestedCourse;

--Create table SuggestedCourse 
CREATE TABLE SuggestedCourse 
(
 CourseID int IDENTITY(1,1) PRIMARY KEY,
 CourseName varchar(30) NOT NULL,
 last_update datetime not null DEFAULT getdate()
);

--Insert SuggestedCourse Details
INSERT INTO SuggestedCourse(CourseName,Last_Update)
VALUES
('Web design',GETDATE()),
('Connected Devices',GETDATE()),
('Data Networking',GETDATE()),
('Internet Prorocols',GETDATE()),
('Object Oriented Programming',GETDATE()),
('Cloud Computing',GETDATE()),
('Database Management System',GETDATE()),
('Algorithms',GETDATE()),
('Project Management',GETDATE()),
('Data Warehousing',GETDATE());

SELECT * FROM SuggestedCourse;

----------------------------------------------------------SKILL-------------------------------------------------------------------------

drop table Skills;

--Create table Skills
CREATE TABLE Skills
(
 Skill_ID int IDENTITY(1,1) PRIMARY KEY,
 SkillName varchar(40) NOT NULL,
 last_update datetime not null DEFAULT getdate()
);

--Insert Skills Details
INSERT INTO Skills(SkillName,Last_Update)
VALUES
('AngularJS',GETDATE()),
('IoT Protocols',GETDATE()),
('Cisco Paket tracer',GETDATE()),
('Ip telephony',GETDATE()),
('Java',GETDATE()),
('AWS',GETDATE()),
('MongoDB',GETDATE()),
('Dynamic programming',GETDATE()),
('Leadership',GETDATE()),
('data mining',GETDATE());

INSERT INTO Skills(SkillName,Last_Update)
VALUES
('NodeJS',GETDATE()),
('SQL',GETDATE()),
('Spring MVC',GETDATE()),
('HeroKu',GETDATE()),
('UI/UX',GETDATE()),
('REST API',GETDATE()),
('Linux',GETDATE()),
('Data Networking',GETDATE()),
('Machine Learning',GETDATE()),
('Virutualization',GETDATE()),
('Cloud Services',GETDATE()),
('Data Analyst',GETDATE()),
('Python',GETDATE()),
('Shell Scripting',GETDATE()),
('Machine Learning',GETDATE());

update skills
set skillname = 'Robotics'
where Skill_ID = 39

SELECT *  FROM Skills;

----------------------------------------------------------SKILLSUGGESTEDCOURSE-------------------------------------------------------------------------

drop table SkillSuggestedCourse;

--Create table SkillSuggestedCourse 
CREATE TABLE SkillSuggestedCourse 
(
  Skill_ID int NOT NULL 
     REFERENCES dbo.Skills(Skill_ID),
  CourseID int NOT NULL 
     REFERENCES dbo.SuggestedCourse(CourseID),
  CONSTRAINT PKSkills PRIMARY KEY CLUSTERED 
   (Skill_ID,CourseID)
);

--Insert SkillSuggestedCourse Details
INSERT INTO SkillSuggestedCourse(Skill_ID,CourseID)
VALUES 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

SELECT * FROM SkillSuggestedCourse;


----------------------------------------------------------JOBS-------------------------------------------------------------------------
--Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD =  'Test_P@ssword';

--crreate certificate
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'Job overflow certificate',
EXPIRY_DATE = '2026-10-31';

--Symmetric key
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

--OPEN SYMMERTRIC
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

drop table Jobs;

--Create table Jobs
CREATE TABLE Jobs
(
 JobID int IDENTITY (1,1) PRIMARY KEY,
 jobName VARCHAR(100),
 EncryptedSalary VARBINARY(250),
 last_update datetime not null DEFAULT getdate()
);

--Insert Jobs details
INSERT 
INTO Jobs 
(jobName, EncryptedSalary)
VALUES 
('Software Engineer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '140000')),
('Full Stack Engineer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '100000')),
('IOT Engineer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '200000')),
('Network Analyst', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '70000')),
('Network Engineer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '80000')),
('Java Developer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '90000')),
('Cloud Engineer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '300000')),
('Database Engineer', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '120000')),
('Business Analyst', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '130000')),
('Data Scientist', EncryptByKey(Key_GUID(N'TestSymmetricKey'), '150000'));

-- with encrpyted Salary values
SELECT * FROM Jobs;
-- with decrypted salary values
SELECT JobID,jobName, DecryptByKey(EncryptedSalary) as DecryptedSalary,last_update as Salary FROM Jobs;

--Do Housekeeping
Drop table Jobs

--Close symmetric key
Close symmetric key TestSymmetricKey

--drop symmetric key
drop symmetric key TestSymmetricKey

--drop certificate
drop certificate testcertificate

--DMK
drop master key


----------------------------------------------------------CAREERDATABASE-------------------------------------------------------------------------

drop table CareerDatabase

--Create table CareerDatabase
CREATE TABLE CareerDatabase 
(
 CompanyID int NOT NULL 
     REFERENCES dbo.Company(CompanyID),
 JobID int NOT NULL 
     REFERENCES dbo.Jobs(JobID),
 Skill_ID int NOT NULL 
     REFERENCES dbo.Skills(Skill_ID),
 CONSTRAINT PKCompany PRIMARY KEY CLUSTERED 
   (CompanyID,JobID,Skill_ID)
);

-- Insert CareerDatabase Details
INSERT INTO CareerDatabase(CompanyID,JobID,Skill_ID)
VALUES	(1,1,1),	
		(2,2,2),
		(3,3,3),
		(4,4,4),
		(5,5,5),
		(6,6,6),
		(7,7,7),
		(8,8,8),
		(9,9,9),
		(10,10,10),
		(1,2,2),	
		(2,3,3),
		(3,4,4),
		(4,5,5),
		(5,6,6),
		(6,7,7),
		(7,8,8),
		(8,9,9),
		(9,10,10),
		(10,1,1);
	
INSERT INTO CareerDatabase(CompanyID,JobID,Skill_ID)
VALUES	
(1,1,37),	
(2,2,11),
(1,2,11),
(1,2,12),
(1,2,14),
(3,3,20),
(3,3,21),
(3,3,22),
(4,4,23),
(4,4,24),
(4,4,18),
(5,5,24),
(5,5,18),
(5,5,17),
(5,5,23),
(6,6,38),
(6,6,37),
(6,6,13),
(7,7,34),
(7,7,36),
(7,7,35),
(8,8,29),
(8,8,30),
(8,8,7),
(9,9,26),
(9,9,27),
(9,9,28),
(10,10,32),
(10,10,33),
(10,10,27),
(10,10,5),
(1,2,11),
(1,2,12),
(1,2,13),	
(2,3,15),
(2,3,16),
(2,3,19),
(3,4,22),
(3,4,23),
(3,4,24),
(4,5,24),
(4,5,17),
(4,5,18),
(4,5,23),
(5,6,13),
(5,6,38),
(5,6,37),
(6,7,20),
(6,7,36),
(6,7,35),
(6,7,34),
(7,8,30),
(7,8,29),
(7,8,31),
(8,9,26),
(8,9,27),
(8,9,28),
(9,10,32),
(9,10,33),
(9,10,27),
(9,10,5),
(10,1,16),
(1,1,5),
(1,1,23)
;

select * from CareerDatabase

----------------------------------------------------------DEPARTMENT-------------------------------------------------------------------------
drop table Department

--Create table Department 
CREATE TABLE Department 
(
 DepartmentID int IDENTITY(101,1) PRIMARY KEY,
 DepartmentName varchar(40) NOT NULL,
 last_update datetime not null DEFAULT getdate()
);

--Insert Department Details
INSERT INTO Department(DepartmentName,Last_Update)
VALUES
('Web User Engineering',GETDATE()),
('Computer Systems Engineering',GETDATE()),
('Telecommunication Networks',GETDATE()),
('Telecommunication and Teleinfomatics',GETDATE()),
('Computer software Engineering',GETDATE()),
('Cyber Physical Systems',GETDATE()),
('Datascience Engineering',GETDATE()),
('Information Technology',GETDATE()),
('Engineering Management',GETDATE()),
('Data Science And Technology',GETDATE());

SELECT * FROM Department;


----------------------------------------------------------MAJOR-------------------------------------------------------------------------

drop table Major

--Create table Major
CREATE TABLE Major
(
 MajorID int IDENTITY(1,1) PRIMARY KEY,
 MajorName varchar(50) NOT NULL,
 DepartmentID int NOT NULL 
     REFERENCES dbo.Department(DepartmentID),
 last_update datetime not null DEFAULT getdate()
);

-- Insert Major Details
INSERT INTO Major(MajorName,DepartmentID,Last_Update)
VALUES
('Web Design',101,GETDATE()),
('IOT',102,GETDATE()),
('Networking',103,GETDATE()),
('Advanced Telenetworking',104,GETDATE()),
('Software Design',105,GETDATE()),
('Cloud Integration',102,GETDATE()),
('Datascience',107,GETDATE()),
('IT',108,GETDATE()),
('Engineering Project Management',109,GETDATE()),
('Advance Data Science',110,GETDATE());

SELECT * FROM Major;


----------------------------------------------------------DEGREE-------------------------------------------------------------------------

drop table Degree

--Create table Degree
CREATE TABLE Degree 
(
 DegreeID int IDENTITY(1,1) PRIMARY KEY , 
 DegreeName varchar(60) NOT NULL ,
 DegreeDescription varchar(100) NOT NULL ,
 last_update datetime not null DEFAULT getdate()
);

--Insert Degree Details
INSERT INTO [Degree](DegreeName,DegreeDescription,Last_Update)
VALUES
('B.S','Bachelor of Science',GETDATE()),
('B.Tech','Bachelor of Technology',GETDATE()),
('Bachelor of Fine Arts','Degree for Fine arts by an art school',GETDATE()),
('Associate Degree','A two year ubdergraduate degree',GETDATE()),
('M.S','Master of Science',GETDATE()),
('M.Tech','Master of Technology',GETDATE()),
('PHD Degree','It is the highest degree a person can achieve',GETDATE()),
('MBA','Master of Business Administration which focus on aspects of business',GETDATE()),
('Professinal Degree','Masters degree',GETDATE()),
('Specialist','Degree for graduated students',GETDATE());

SELECT * FROM [Degree];

----------------------------------------------------------STUDENTDETAILS-------------------------------------------------------------------------


drop table Student_Details

-- Create table Student_Details
CREATE TABLE Student_Details
(
 StudentID int NOT NULL 
     REFERENCES Student(StudentID),
 DegreeID int NOT NULL 
     REFERENCES Degree(DegreeID),
 MajorID int NOT NULL 
     REFERENCES Major(MajorID),
 Skill_ID int NOT NULL 
     REFERENCES Skills(Skill_ID),
 JobID int NOT NULL 
     REFERENCES Jobs(JobID),
   CONSTRAINT PKStudent PRIMARY KEY CLUSTERED 
   (StudentID,DegreeID,MajorID,Skill_ID,JobID)
);

-- Insert data into Student_Details 
INSERT INTO Student_Details(StudentID,DegreeID,MajorID,Skill_ID,JobID)
VALUES 	(1,1,1,1,1),
		(2,2,2,2,2),
		(3,3,3,3,3),
		(4,4,4,4,4),
		(5,5,5,5,5),
		(6,6,6,6,6),
		(7,7,7,7,7),
		(8,8,8,8,8),
		(9,9,9,9,9),
		(10,10,10,10,10);
	
	
SELECT * FROM Student_Details;

/* Updating Student_details table  */

UPDATE student_details
SET degreeid = 5
WHERE studentid = 3;

UPDATE student_details
SET degreeid = 2
WHERE studentid = 8;


----------------------------------------------------------STUDENTVIEW-------------------------------------------------------------------------
drop view StudentReport

/* The StudentReport view is created to display induvidual student report details */
CREATE VIEW StudentReport
AS 
SELECT s.StudentID, concat(s.StudentFirstName,' ',s.StudentLastName) as 'Student Name', s.DOB ,s.Phone_Number,s.Email_Address, s.Gender,
a.Apt_number, a.street_number ,c.cityname , sa.statename, sa.zipcode , co.Countryname 
FROM Student s
join Address a 
ON s.AddressID = a.AddressID
join City c 
ON a.CityID=c.CityID
join State sa 
ON c.StateID = sa.StateID
join Country co 
ON sa.CountryID=co.CountryID;

SELECT * FROM StudentReport;

----------------------------------------------------------STUDENTACADEMICVIEW-------------------------------------------------------------------------
Drop view StudentAcademicDetails;

/* The StudentAcademicDetails view is created to display the academic details of the student */
CREATE VIEW StudentAcademicDetails
AS 
SELECT sd.StudentID, concat(s.StudentFirstName,' ',s.StudentLastName) as 'student Name', DEG.DegreeName ,m.MajorName, Dept.DepartmentName
FROM Student_details sd
join student s
ON sd.StudentID = s.AddressID
join Degree DEG
ON sd.DegreeID = DEG.DegreeID
join Major m
ON sd.MajorID = m.MajorID
join Department Dept
ON m.DepartmentID=Dept.DepartmentID;

SELECT * FROM StudentAcademicDetails;

-----------------------------------------------------------------------------------------------------------------------------------

drop view studentcount

create view studentcount
as
select count(s.studentid) as count_of_students, c.countryname
from student s
join country c
on s.StudentID = c.CountryID
group by countryname

SELECT * from studentcount

-----------------------------------------------------------------

SELECT DISTINCT c.jobid,
	STUFF((SELECT DISTINCT ', ' +  RTRIM( CAST(skill_id as CHAR))
		FROM careerdatabase
		WHERE jobid = c.jobid
		FOR XML PATH ('')) , 1, 2, '')  as List_of_skills
FROM careerdatabase as c
ORDER BY jobid

------------------------------------------------------------------------skill_jobs_view_horizontal---------------------------------------------------------------------------
drop view skill_jobs_horizontal;

CREATE view skill_jobs_horizontal
as
with temp2 AS
	(select DISTINCT j.JobID, j.jobname, s.skillname
	from jobs j
	inner join dbo.CareerDatabase c
	on j.JobID = c.JobID
	inner join dbo.Skills s
	on s.Skill_ID = c.Skill_ID)
select DISTINCT jobid, jobname,
	STUFF((select ', '+ RTRIM(skillname)
	   from temp2
	   where jobname = t.jobname
	   for xml PATH('')) , 1,2, '') as Skills_required
from temp2 t
--order by jobid

select * from dbo.skill_jobs_horizontal

------------------------------------------------------------------------skill_jobs_view_vertical---------------------------------------------------------------------------

drop view skill_jobs_vertical;

CREATE view skill_jobs_vertical
as
select DISTINCT j.JobID, j.jobname, s.skillname
	from jobs j
	inner join dbo.CareerDatabase c
	on j.JobID = c.JobID
	inner join dbo.Skills s
	on s.Skill_ID = c.Skill_ID
	
select * from dbo.skill_jobs_vertical