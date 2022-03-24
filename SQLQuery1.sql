create database Academy

use  Academy

create table Groups(
id int identity primary key,
name nvarchar (20)
)

create table Students(
id int identity primary key,
Name nvarchar (20),
Surname nvarchar (20),
GroupId int references Groups
)

alter table Students
add Grade int

insert into Groups(name)
values('P224'), ('P124'), ('P221')

insert into Students(Name,Surname,GroupId)
values('Altan', 'Ibrahimli', '3'),
('Kamil', 'Quliyev', '1'),
('David', 'Qayibov', '1'),
('Mayil', 'Kerimov', '1')

select * from Students s inner join Groups g on s.GroupId = g.Id where g.Name='P221'

select g.Name,count(s.Id) as [say] from Students s inner join Groups g on s.GroupId = g.Id group by g.Name

create procedure usp_Altan
@Grade int 
as
begin
select * from  Students where Grade>@Grade
end

exec usp_Altan 40

create view usv_Altan2
as
select s.Name, s.Surname, g.Id as [Group],s.Grade from Students s join Groups g on s.GroupId = g.Id
select * from usv_Altan2

create function getStuCountByGroupName
(@Group nvarchar(20))
returns int
as
begin
declare @Count int
select @Count =count (s.name ) from Students s
join Groups g on s.GroupId =g.Id
where g.name = @Group
group by g.Name 
return @Count
end

select dbo.getStuCountByGroupName('P224')
