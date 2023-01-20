----------Create Database -------------------------

create database TestDb01

create database TestDb02

create database TestDb03

------------------Use Database -------------------
use TestDb01

use TestDb02

use TestDb03

use TestDbDemo03

----------------------DROP database --------------
drop database TestDb01

drop database if exists TestDb03,TestDb02

---------------------Rename Database name---------
alter database TestDb03 modify Name=TestDbDemo03;

ALTER DATABASE TestDbDemo03 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;	--set to single user

ALTER DATABASE TestDbDemo03 MODIFY NAME = TestDatabase03;				--Rename db
  
ALTER DATABASE TestDatabase03 SET MULTI_USER;							--set to multiple user


--------Retrieving all Databases data in the System----

SELECT name, database_id, create_date  
FROM sys.databases;  

GO  

SELECT database_id, is_read_only,physical_database_name, compatibility_level  --config details
FROM sys.databases WHERE name = 'TestDbDemo03';  
-------------------------------------------------

CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR(20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);
---------------------------------------------------------------
create database SQLPractice

use SQLPractice

create table EmployeeData
(Emp_Id int Primary key Identity(101,1),
First_Name nvarchar(150),
Last_Name nvarchar(150),
Gender nvarchar(10),
Department nvarchar(50),
Salary float,
);

insert into EmployeeData 
(
   First_Name,
   Last_Name,
   Gender,
   Department,
   Salary
)
values
('Shaik','Rehan','Male','IT',34000),
('Peram','Ramesh','Male','Telecom',20000),
('Anku','Siva','Male','Sales',17000),
('Kamili','Sravani','Female','HR',35000);

select * from EmployeeData

create table DepartmentsData
(
DeptId int,
DeptName nvarchar(100)
);

insert into DepartmentsData(DeptId,DeptName) values(1001,'Sales'),(1002,'HR'),(1003,'Telecom'),(1004,'IT')
	
select * from DepartmentsData

create procedure spInsertIntoEmpData
(
@First_Name nvarchar(150),
@Last_Name nvarchar(150),
@Gender nvarchar(10),
@Department nvarchar(50),
@Salary float
)
as
begin
	insert into EmployeeData 
		(First_Name,Last_Name,Gender,Department,Salary)
	values
		(@First_Name,@Last_Name,@Gender,@Department,@Salary)
end

--Exec spInsertIntoEmpData 'Pateli','Vidhya','Female','IT',30500;



create procedure spUpdateEmpData
(
@Emp_Id int,
@First_Name nvarchar(150),
@Last_Name nvarchar(150),
@Gender nvarchar(10),
@Department nvarchar(50),
@Salary float
)
as
begin
	update EmployeeData
	set First_Name=@First_Name,Last_Name=@Last_Name,Gender=@Gender,Department=@Department,Salary=@Salary where Emp_Id=@Emp_Id
end

--Exec spUpdateEmpData 106,'Praveen','Kumar','Male','IT',31000 


create procedure spSelectEmpData
as 
begin
	select * from EmployeeData
end

--Exec spSelectEmpData;

create procedure spSelectEmpDataById
(@Emp_Id int)
as 
begin
	select * from EmployeeData where Emp_Id=@Emp_Id
end

--Exec spSelectEmpDataById 105

create procedure spDeleteEmpDataById
(@Emp_Id int)
as 
begin
	Delete from EmployeeData where Emp_Id=@Emp_Id
end

--Exec spDeleteEmpDataById (Emp_Id)


create procedure spACRUDEmpData
(
@Emp_Id int,
@First_Name nvarchar(150),
@Last_Name nvarchar(150),
@Gender nvarchar(10),
@Department nvarchar(50),
@Salary float,
@SpType NVARCHAR(30) = ''
)
AS
BEGIN
  if @SpType ='insert'
	Begin
		insert into EmployeeData 
			(First_Name,Last_Name,Gender,Department,Salary)
		values
			(@First_Name,@Last_Name,@Gender,@Department,@Salary)
	end
  if @SpType ='update'
	Begin
		update EmployeeData
		set First_Name=@First_Name,Last_Name=@Last_Name,Gender=@Gender,Department=@Department,Salary=@Salary where Emp_Id=@Emp_Id
	end
  if @SpType ='delete'
	Begin
		Delete from EmployeeData where Emp_Id=@Emp_Id
	end
  if @SpType ='getall'
	Begin
		select * from EmployeeData
	end
  else if @SpType ='getbyid'
	Begin
		select * from EmployeeData where Emp_Id=@Emp_Id
	end
END
---------------------------------------------------------------
select * into EmpDetailsData from EmployeeData
---------------------------------------------------------------
select * from  DepartmentsData

select * from EmployeeData

select * from EmpDetailsData
---------------------------------------------------------------
create view ViewEmployeeData
AS
select
    Emp_Id,First_Name,Last_Name,Gender,Salary,DeptId from EmployeeData join DepartmentsData on EmployeeData.Department = DepartmentsData.DeptName

Select * from ViewEmployeeData

---------------------------------------------------------------
create index IX_Employee_Salary on EmployeeData (Salary asc)

 
--select * from EmployeeData where Salary=30500

--drop index EmployeeData.IX_Employee_Salary

---------------------------------------------------------------
 
 Select First_Name,Last_Name,Gender,Department,Salary from EmployeeData as E inner join DepartmentsData as D on E.Department=D.DeptName
 
 --------------------------------------------------------------
 
create table Employee(
	empId INT  NOT NULL,
	empName varchar(200) NOT NULL
)

insert into Employee values
(1,'Kumar'),(2,'Ramesh'),(3,'Ram'),(4,'Siva'),(5,'Kalyan');



select * from Employee;

create table EmpDetails(
	empId INT  NOT NULL,
	empAge INT NOT NULL,
	empAddress varchar(200),
	empSalary decimal(8, 2)
)

Insert into EmpDetails values
(1,33,'Hyderabad',2923.90),
(2,43,'Delhi',3444.90),
(3,22,'Vijayawada',3456.90),
(4,65,'Pune',5433.90),
(8,34,'Hyderabad',4222.90),
(10,32,'Delhi',4554.90);

select * from EmpDetails;

---Inner Join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp INNER JOIN EmpDetails empD ON emp.empId = empD.empId;

---Left join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp LEFT JOIN EmpDetails empD ON emp.empId = empD.empId;

---right join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp RIGHT JOIN EmpDetails empD ON emp.empId = empD.empId;

--Full join=combination of right and left join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp FULL JOIN EmpDetails empD ON emp.empId = empD.empId;

--cross join--
select emp.empId,empName,empD.empAge,empD.empAddress,empD.empSalary from Employee emp CROSS JOIN EmpDetails empD ;

--self join--
create table company(
	empId int ,
	empName varchar(20),
	managerId Int,
	City varchar(20)
)

insert into company values
(1,'Kumar',6,'Hyderabad'),
(2,'Suresh',2,'Hyderabad'),
(3,'Ram',4,'Hyderabad');

insert into company values
(4,'Suresh',3,'Hyderabad'),
(5,'Amit',1,'Hyderabad'),
(6,'Kumar',2,'Hyderabad');

select * from company;

select a.empID As "Emp_ID" , a.empName AS "Emp_Name", b.empID AS "Manager ID" , b.empName AS "Manager Name" from company a , company b
where a.managerId = b.empId;
 
 ---------------------------------------------------------------

 create table EmpTrigger(
 Emp_ID INT IDENTITY PRIMARY KEY,
 Emp_name varchar(100) NOT NULL,
 Emp_Sal decimal(10,2) NOT NULL,
 Emp_DOB datetime NOT NULL,
 Emp_Experience INT NOT NULL,
 Record_DateTime datetime NOT NULL
)

create trigger dbo.triggerAInsert ON dbo.EmpTrigger
AFTER  INSERT
as
declare @emp_dob varchar(20);
declare @age INT;
declare @Emp_Experience INT;

select @emp_dob = i.Emp_DOB from inserted i;
select @Emp_Experience = i.Emp_Experience from inserted i;

---employee age must not above  25 years
SET @Age=Year(GetDate())-Year(@emp_dob);
If @Age > 25
	begin
	Print 'Not Eligible: Age is greater  than 25'
	Rollback
	End
---Employee should have more than 5 years experience
ELSE IF @Emp_Experience < 5
	begin
	Print 'Not Eligible: Experience is less than 5'
	Rollback
	end
	
insert into EmpTrigger values ('Kumar',5000,'1990-01-03',4,GetDate()) 
insert into EmpTrigger values ('Ram',5000,'1998-01-03',4,GetDate()) 
insert into EmpTrigger values ('Suresh',5000,'1998-01-03',6,GetDate()) 

select * from EmpTrigger

----After Update-
create table dbo.EmpHistory(
	Emp_ID INT NOT NULL,
	field_name varchar(100) NOT NULL,
	old_value varchar(100) NOT NULL,
	new_value varchar(100) NOT NULL,
	Record_DateTime datetime NOT NULL
)

create trigger dbo.trgAfterUpdate ON dbo.EmpTrigger
AFTER UPDATE
AS
declare @emp_id INT;
declare @emp_name varchar(100);
declare @old_emp_name varchar(100);
declare @emp_sal decimal(10,2);
declare @old_emp_sal decimal(10,2);

select @emp_id=i.Emp_id from inserted i;
select @emp_name=i.Emp_Name from inserted i;
select @old_emp_name=i.Emp_Name from deleted i;
select @emp_sal=i.Emp_Sal from inserted i;
select @old_emp_sal=i.Emp_Sal from deleted i;

if update(Emp_Name)
begin
insert into EmpHistory values (@emp_id,'Emp_Name',@old_emp_name,@emp_name,getdate())
end
if update(Emp_Sal)
begin
insert into EmpHistory values (@emp_id,'Emp_Name',@old_emp_name,@emp_name,getdate())
end

select * from EmpTrigger;
update EmpTrigger set emp_name='king' where emp_id=2

---After update
select * from EmpTrigger;
select * from EmpHistory;

----After Delete--
create table EmployeeBackUp(
 Emp_ID INT NOT NULL,
 Emp_name varchar(100) NOT NULL,
 Emp_Sal decimal(10,2) NOT NULL,
 Emp_DOB datetime NOT NULL,
 Emp_Experience INT NOT NULL,
 Record_DateTime datetime NOT NULL
)

create trigger dbo.trgAfterDelete ON dbo.EmpTrigger
AFTER DELETE
as
declare @emp_id INT;
declare @emp_name varchar(100);
declare @emp_sal decimal(10, 2);
declare @emp_dob varchar(20);
declare @age INT;
declare @Emp_Experience INT;

select @emp_id = i.emp_id from deleted i;
select @emp_name = i.Emp_Name from deleted i;
select @emp_sal = i.Emp_Sal from deleted i;
select @emp_dob = i.Emp_DOB from deleted i;
select @Emp_Experience = i.Emp_Experience from deleted i;

insert into EmployeeBackUp values(@emp_id,@emp_name,@emp_sal,@emp_dob,@emp_experience,getdate())
print 'Employee details inserted successfully.';

---before delete--
select * from EmpTrigger;
select * from EmployeeBackUp;

delete from EmpTrigger where emp_id=6

---After delete
select * from EmpTrigger;
select * from EmployeeBackUp;

 ---------------------------------------------------------------
CREATE TABLE t1 (
    id INT IDENTITY(1, 1), 
    a  INT, 
    b  INT, 
    PRIMARY KEY(id)
);

INSERT INTO
    t1(a,b)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (2,1),
    (1,2),
    (1,3),
    (2,1),
    (2,2);

SELECT * FROM t1;

SELECT 
    a, 
    b, 
    COUNT(*) occurrences
FROM t1
GROUP BY
    a, 
    b
HAVING 
    COUNT(*) > 1;

--To return the entire row for each duplicate row, 
--you join the result of the above query with the t1 table using a common table expression(cte)
	WITH cte AS (
    SELECT
        a, 
        b, 
        COUNT(*) occurrences
    FROM t1
    GROUP BY 
        a, 
        b
    HAVING 
        COUNT(*) > 1
)
SELECT 
    t1.id, 
    t1.a, 
    t1.b
FROM t1
    INNER JOIN cte ON 
        cte.a = t1.a AND 
        cte.b = t1.b
ORDER BY 
    t1.a, 
    t1.b;

----------------------------------------------------
CREATE TABLE Contacts(
    ContactId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
);

INSERT INTO Contacts
    (FirstName,LastName,Email) 
VALUES
    ('Syed','Abbas','syed.abbas@example.com'),
    ('Catherine','Abel','catherine.abel@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Kim','Abercrombie','kim.abercrombie@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Hazem','Abolrous','hazem.abolrous@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Humberto','Acevedo','humberto.acevedo@example.com'),
    ('Pilar','Ackerman','pilar.ackerman@example.com');

	SELECT * FROM Contacts








