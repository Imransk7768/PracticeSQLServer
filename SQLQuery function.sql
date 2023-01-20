-- write a query to get department wise employee count
select count(E.EmpName) as Emp_No,D.DeptName from EmpTbl as E inner join DeptTbl as D on E.Id=D.Id group by DeptName order by D.DeptName desc;

-- write a query to get top 5 salaries of employees
select top 5 Salary from EmpTbl order by Id desc;

-- write a query to get average salary of each employee
select avg(Salary) from EmpTbl;

-- write a query to get min & max of age in all employees
select min(age) from EmpTbl;
select max(age) from EmpTbl;
-- write a query to get total count of employees
Select  Count(EmpName) as Employees from EmpTbl;

select Sum(Salary) from EmpTbl;

select GETDATE();
select APP_NAME();
select CURRENT_USER;

select * from EmpTbl;

select * from DeptTbl;

select * from EmpTbl;

insert into EmpTbl values ('Kumar',40,10000),('Siva',23,8500),('Balu',27,6500);

insert into DeptTbl values ('IT',5);



select * from DeptTbl

select * from EmpTbl

select * from DeptTbl,EmpTbl


	create function AddDigit(@num1 int,@num2 int)
	returns int 
	as
	begin
		Declare @result int;
		set @result=@num1+@num2;
		return @result		
	end

Exec AddDigit(26,4)
