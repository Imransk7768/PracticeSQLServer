--Locking--

create table TestDemo
(
	ID varchar(100),
	Name varchar(100)
)

insert into TestDemo values 
('A1001','Record 1'),
('A1002','Record 2'),
('A1003','Record 3'),
('A1004','Record 4');

select * from TestDemo;

---------
begin tran
	update TestDemo set id = 'D1009'
	where Name='Record 3'

----------------------------------------------------