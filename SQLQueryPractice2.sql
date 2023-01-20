USE BookStoreDB

create  or alter procedure sp_UPDATEEMP
(
@ID int,
@EMPID iNT,
@NAME VARCHAR(50)
)

AS 
BEGIN
UPDATE INTO EMPLOYEE SET EMPID=@EMPID, NAME=@NAME WHERE ID=@ID
END

execute sp_UPDATEEMP;



create or alter procedure sp_Update_Employee
@Id int,
@EmpName varchar,
@EmpId int

as
 begin
  update into Employee set EmpId=@EmpId, EmpName=@EmpName where Id=@Id
  end



select * from Users

select * from Users where FullName