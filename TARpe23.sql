-- loome andmebaasi
create database TARpe23

-- valime andmebaasi
use TARpe23

-- db kustutamine
drop database TARpe23

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

-- vaatame tabeli andmeid
select * from Gender

--andemte sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

-- tabeli nimi on Person
--loome tabeli, kus muutujad Id int PK, 
--Name nvarchar(30)
--, Email nvarchar(30), GenderId int
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 3)

select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId
-- alla väärtust, siis see automaatselt sisestab sellele reale
-- väärtuse 3 e unknown

-- enne testime andmebaasi
insert into Person values
(7, 'Spiderman', 'sp@sp.com', NULL)

-- nüüd sisestame väärtuse panemise
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--nüüd sisestame andmed uuesti
insert into Person (Id, Name, Email)
values (11, 'Ironman', 'i@i.com')

select * from Person

-- piirangu kustutamine
alter table Person
drop constraint DF_Persons_GenderId

-- kuidas lisada uus veerg Person tabelisse
-- Age nvarchar(10)
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

select * from Person

--kustutame rea
delete from Person where Id = 10

update Person
set Age = 150
where Id = 2

select * from Person

--lisame uue veeru Person tabelisse
-- City nvarchar(50)
alter table Person
add City nvarchar(50)

select * from Person

update Person
set City = 'Los Angeles'
where Id = 9

select * from Person

--k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- k]ik, kes ei ela Gothami linnas
select * from Person where City <> 'Gotham'
--k]ik, kes ei ela Gothami linnas
select * from Person where City != 'Gotham'

-- n'itab teatud vanusega inimesi
select * from Person where Age = 150 or Age = 37 or Age = 25
select * from Person where Age in (150, 37, 25)

-- n'itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 21 and 40

-- wildcard e n'itab k]ik g-t'hega linnad
select * from Person where City like 'g%'
--n'itab k]iki @-m'rgiga emaile
select * from Person where Email like '%@%'

-- k]igil, kellel ei ole @-m'rki emailis
select * from Person where Email not like '%@%'

--kellel on emailis ees ja peale @-m'rki ainult [ks t'ht
select * from Person where Email like '_@_.com'

-- kellel nimes esimene täht ei ole W, A, C
select * from Person where Name like '[^WAC]%'

-- kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

-- kes elavad Gothamis ja New Yorkis ja on vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York')
and Age > 29

-- kuvab t'hestikulises j'rjekorras inimesi ja v]tab aluseks nime
select * from Person order by Name

-- tahame n'idata vastupidises j'rjestuses
select * from Person order by Name desc

-- v]tab kolm esimest rida
select top 3 * from Person

-- kolm esimest, aga tabeli veergude j'rjestus on Age ja siis Name
select top 3 Age, Name from Person

-- n'itab esimesed 50% tabelis olevatest andmetest
select top 50 percent * from Person

-- j'rjestame vanuse j'rgi isikud
select * from Person order by Age desc

-- j'rjestame vanuse j'rgi ja kasutame casti
select * from Person order by cast(Age as int)

--k]ikide isikute koondvanus
select sum(cast(Age as int)) from Person

--n'itab k]ige nooremat isikut
select min(cast(Age as int)) from Person
--n'itab k]ige vanemat isikut
select max(cast(Age as int)) from Person

-- n'eme konkreetsetes linnades olevate isikute koondvanust
-- Age nvarchar, aga p'ringu k'igus muudame selle intiks
select City, sum(cast(Age as int)) as TotalAge from Person
group by City

--n'itab, et mitu rida on selles tabelis
select count(*) from Person

--mitu inimest on genderId v''rtusega 2 konkreetses linnas
--arvutab vanuse kokku selles linnas
select GenderId, City, sum(cast(Age as int)) as TotalAge, count(Id)
as [Total Person(s)] from Person
where GenderId = '2'
group by GenderId, City

--mitu inimest on vanemad, kui 41 ja kui palju igas linnas
-- neid elab
select GenderId, City, sum(cast(Age as int)) as TotalAge, count(Id)
as [Total Person(s)] from Person
group by GenderId, City having sum(cast(Age as int)) > 41


--teeme kaks tabelit
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

select *from Employees

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Employees
select * from Department

--rida 239

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

select * from Employees
--arvutab k]ikide palgad kokku
select sum(cast(Salary as int)) from Employees
-- min palga saaja
select min(cast(Salary as int)) from Employees
-- [he kuu palgafond linna lõikes
select City, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City

alter table Employees
add City nvarchar(30)

--sooline erisus palga osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender

--linnad t'hestikulises j'rjestuses
select City, Gender, sum(cast(Salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

-- loeb ära, mitu inimest on nimekirjas
select count(*) from Employees

--mitu töötajat on soo ja linna kaupa
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--tahame ainult k]ik meessoost isikud linnade kaupa
select City, Gender, sum(cast(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

-- isikud, kelle palk on üle 4000
select * from Employees where sum(cast(Salary as int)) > 4000

-- tuleb kasutada having
select Gender, City, sum(cast(Salary as int)) as TotalSalary, 
count (Id) as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values ('X')

select * from Test1

--kustutame veeru nimega City Employees tabelist
alter table Employees
drop column City

--inner join
--näitab neid, kellel on DepartmentName all olemas väärtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

--left join
--1. kuidas saada kõik andmend Employees tabelist kätte
--2. tagastab kattuvad read ja kõik mitte-kattuvad 
--read vasakust tabelist
select Name, Gender, Salary, DepartmentName
from Employees
LEFT JOIN Department --võib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--kuidas saada DeparmtentName alla uus nimetus e antud
--juhul Other Department
--right join
--tagastab kõik kattuvad read ja kõik mitte-katuvad read 
--paremast tabelist
select Name, Gender, Salary, DepartmentName
from Employees
right join Department --võib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- kuidas saada kõikide tabelite väärtused ühte päringusse
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

--cross join v]tab kaks allpool olevat tabelit kokku
--ja korrutab need omavahel
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department

--päringu sisu näide
select Veerud
from VasakTabel
joini tüüp  ParemTabel
on Joinitingimus

--kuidas näidata ainult nees isikud, kellel on
--DepartmentName NULL
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--full join
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

-- muudame tabeli nimetust, alguses vana tabeli nimi
-- ja siis uus soovitud
sp_rename 'Department123', 'Department'

--kasutame Employees tabeli asemel muutujat E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--inner join
--kuvab ainult ManagerId all olevate isikute v''rtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--k]ik saavad k]ikide [lemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

select isnull('Ingvar', 'No Manager') as Manager

--NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

-- kui Expression on ]ige, siis paneb v''rtuse,
-- mida soovid v]i m]ne teise v''rtuse
case when Expression then '' else '' end

---neil kellel ei ole [lemust, siis paneb neile No Manager teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager'
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--lisame tabelisse Employees kaks veergu ja nimed on MiddleName ning LastName
--m]lemad on nvarchar(30)

alter table Employees
add MiddleName nvarchar(30),
LastName nvarchar(30)

--muudame ja lisame andmeid
update Employees
set Name = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set Name = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set Name = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set Name = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set Name = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set Name = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set Name = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set Name = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set Name = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set Name = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

--igast reast v]tab esimesena t'idetud lahtri ja kuvab ainult seda v''rtust
select Id, coalesce(Name, MiddleName, LastName) as Fullname
from Employees

--loome kaks tabelit juurde
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

---sisestame tabelisse andmed
insert into IndianCustomers (Name, Email) values
('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into UKCustomers (Name, Email) values
('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

-- kasutame union all, n'itab k]iki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate v''rtustega read pannakse [hte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--kuidas tulemust sorteerida nime j'rgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name

-- stored procedure
create procedure spGetEmployees
as begin
	select Name, Gender from Employees
end

--- n[[d saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

select * from Employees

create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select Name, Gender, DepartmentId from Employees 
	where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- kui n[[d allolevat k'sklust k'ima panna, siis n]uab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--]ige variant
spGetEmployeesByGenderAndDepartment 'Male', 1

--niimoodi saab sp taheud j'rjekorrast m;;da minna,
--kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

-- saab vaadata sp sisu result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

-- kuidas muuta sp-d ja v]ti peale panna, 
-- et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption --paneb v]tme peale
as begin
	select Name, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

sp_helptext spGetEmployeesByGenderAndDepartment

select * from Employees

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

spGetEmployeeCountByGender @Gender = 'Male', @EmployeeCount = 6

-- annab tulemuse, kus loendab 'ra n]uetele vastavad read
--antud juhul tahtsime teada, et mitu naissoost isikut on tabelis
declare @TotalCount int
execute spGetEmployeeCountByGender 'female', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

--n'itab 'ra, et mitu rida vastab n]uetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--vaatame sp sisu
sp_help spGetEmployeeCountByGender
-- tabeli info
sp_help Employees
-- kui soovid teksti n'ha
sp_helptext spGetEmployeeCountByGender

--vaatame, millest s]ltub see sp
sp_depends spGetEmployeeCountByGender
--vaatame tabelit
sp_depends Employees

--
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Name = Id, @Name = Name from Employees
end

--annab kogu ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

-- annab kogu tabeli ridade arvu
declare @TotalEmployees int
execute spTotalCount2 @TotalEmployees output
select @TotalEmployees

--mis id all on keegi nime j'rgi
create proc spgetnameById1
@Id int,
@FirstnName nvarchar(50) output
as begin
	select @FirstnName = Name from Employees where Id = @Id
end
-- annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(50)
execute spgetnameById1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

---
declare
@FirstName nvarchar(20)
execute spgetnameById1 1, @FirstName out
print 'Name = ' + @FirstName

sp_help spgetnameById1

---
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime v'lja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

---sisseehitatud string funktsioonid
-- konverteeri ASCII t'he v''rtuse numbriks
select ASCII('a')
-- kuvab A-t'he
select char (65)

--prindime kogu t'hestiku v'lja
declare @Start int
set @Start = 97
while (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

-- eemaldame t[hjad kohad vasakul pool sulgudes
select ltrim('            Hello')

--t[hikute eemaldamine veerust
select LTRIM(FirstName) as FirstName, MiddleName, LastName from Employees

--paremalt poolt eemaldab k]ik t[hjad kohad
select RTRIM('        Hello                                    ')

--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt upper ja lower-ga saan muuta märkide suurust
--reverse funktsioon pöörab kõik ümber
select REVERSE(upper(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
RTRIM(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

-- left, right ja substring
-- vasakult poolt neli esimest tähte
select LEFT('ABCDEF', 4)
--- paremalt poolt kolm tähte
select Right('ABCDEF', 3)

--kuvab @-t'hem'rki asetust
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr peale komakohta näitab, et mitmendast alustab 
--ja siis mitu nr peale seda kuvada
select SUBSTRING('pam@bbb.com', 5, 2)

--- @märgist kuvab kolm tähemärki. Viimase numriga saab määrata pikkust
select substring('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 4)

---peale @-märki reguleerin tähemärkide pikkuse näitamist
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 2,
LEN('pam@bbb.com') - CHARINDEX('@', 'pam@bbb.com'))

---saame teada domeeninimed emailides
select substring(Email, CHARINDEX('@', Email) + 1,
len(Email) - CHARINDEX('@', Email)) as EmailDomain
from Employees

--lisame uue veeru nimega Email nvarchar(20)
alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

--- lisame *-märgi teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + REPLICATE('*', 5) + --kõik peale teist tähemmärki paneb viis tärni
	substring(Email, charindex('@', Email), len(Email) - CHARINDEX('@', Email)+1) as Email -- kuni @-m'rgini on dünaamiline e muutub
from Employees

--- kolm korda n'itab stringis olevat v''rtust
select replicate('asd ', 3)

-- kuidas sisestada t[hikut kahe nime vahele
select space(5)

--- t[hikute arv kahe nime vahel
select FirstName + space(5) + LastName as FullName
from Employees

---PATINDEX
-- sama, mis CHARINDEX, aga d[naamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 ---leian k]ik selle domeeni esindajad ja 
-- alates mitmendast m'rgist algab @
select * from Employees

--- k]ik .com-d asendatakse .net-ga
select Email, replace(Email, '.com', '.net') as ConvertedEmail
from Employees

--- soovin asendada peale esimest m'rki kolm t'hte viie t'rniga
select FirstName, LastName, Email,
	STUFF(Email, 2, 3, '*****') as StuffedEmail
from Employees

select * from Employees

---
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--- konkreetse masina kellaaeg
select GETDATE(), 'GETDATE()'

---
insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

-- tabelis aja uuendamine
update DateTime set c_datetimeoffset = '2024-03-13 23:25:15.8500000 +10:00'
where c_datetimeoffset = '2024-03-13 09:55:30.1500000 +10:00'
go
select * from DateTime


select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja p'ring
select SYSDATETIME(), 'SYSDATETIME' --veel t'psem aja p'ring 
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' ---t'pne aeg koos ajalise nihkega UTC suhtes 
select GETUTCDATE(), 'GETUTCDATE' --UTC aeg


select ISDATE('asd') --tagastab 0 kuna string ei ole date
select ISDATE(GETDATE()) --tagastab 1 kuna on kp
select ISDATE('2024-03-13 09:55:30.1500000') -- tagastab 0 kuna max kolm komakohta v]ib olla
select ISDATE('2024-03-13 09:55:30.150') ---tagastab 1
select DAY(GETDATE()) ---annab t'nase p'eva nr
select DAY('01/31/2017') --annab stringis oleva kp ja j'rjestus peab olema ]ige
select YEAR(GETDATE())  -- annab jooksva aasta nr
select year('01/31/2024') --annab stringis oleva aasta nr

select DATENAME(DAY, '2024-03-13 09:55:30.150') -- annab stringis oleva p'eva nr
select DATENAME(WEEKDAY, '2024-03-13 09:55:30.150') --annab stringis oleva p'eva s]nana
select DATENAME(MONTH, '2024-03-13 09:55:30.150') --annab stringis oleva kuu s]nana

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

select * from EmployeesWithDates

--- kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud
select Name, DateOfBirth, datename(weekday, DateOfBirth) as [Day], --- vaatab DOB veerust p'eva ja kuvab p'eva nimetuse s]nana
	MONTH(DateOfBirth) as MonthNumber, --- vt DOB veerust kp-d ja kuvab kuu nr
	DATENAME(MONTH, DateOfBirth) as [MonthName], --vt DOB veerust kuud ja kuvab s]nana
	YEAR(DateOfBirth) as [Year] --v]tab DOB veerust aasta
from EmployeesWithDates

select DATEPART(WEEKDAY, '2024-03-24 09:55:30.150') -- kuvab 1 kuna USA n'dal algab p[hap'evaga
select DATEPART(MONTH, '2024-03-24 09:55:30.150') -- kuvab kuu nr
select DATEADD(DAY, 20, '2024-03-24 09:55:30.150')  --liidab stringis olevale kp 20 p'eva juurde
select DATEADD(DAY, -20, '2024-03-24 09:55:30.150')  --lahutab stringis olevale kp 20 p'eva juurde
select DATEDIFF(MONTH, '03/30/2023', '01/30/2023') --kuvab kahe stringis olevate kuudevahelist aega nr-na
select DATEDIFF(YEAR, '03/30/2023', '01/30/2033') --kuvab kahe stringis olevate aastavahelist aega nr-na


create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, GETDATE()) - case when (month(@DOB) > MONTH(GETDATE())) or (month(@DOB)
		= MONTH(GETDATE()) and day(@DOB) > day(GETDATE())) then 1 else 0 end
		select @tempdate = DATEADD(year, @years, @tempdate)

		select @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - case when day(@DOB) > day(GETDATE()) then 1 else 0 end
		select @tempdate = DATEADD(MONTH, @months, @tempdate)

		select @days = DATEDIFF(day, @tempdate, GETDATE())

	declare @Age nvarchar(50)
		set @Age = CAST(@years as nvarchar(4)) + ' Years ' + CAST(@months as nvarchar(2)) +
			' Months ' + cast(@days as nvarchar(2)) + ' Days old'
	return @Age
end

-- saame vaadata kasutajate vanust
select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

-- kui kasutame seda funktsiooni, siis saame teada t'nase p'eva vahet stringis v'lja tooduga
select dbo.fnComputeAge('11/11/2010')

--- nr peale DOB muutujat n'itab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDoB
from EmployeesWithDates

select  Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select * from EmployeesWithDates

select cast(getdate() as date) --t'anane kp
select convert(date, GETDATE()) --t'anane kp

---matemaatilised funktsioonid
select abs(-101.5) ---abs on absoluutne nr ja tulemuseks saame ilma miinus m'rgita tulemuse
select CEILING(15.2) -- tagastab 16 ja suurendab suurema t'siarvu suunas
select CEILING(-15.2) --tagastab -15 ja suurendab suurema positiivse t'siarvu suunas
select floor(15.2) --[mardab negatiivsema nr poole
select floor(-15.2) --[mardab negatiivsema nr poole
select POWER(2, 4)  -- hakkab korrutama 2x2x2x2, esimene nr on astendatav
select SQUARE(9) --antud juhul 9 ruudus
select sqrt(81) --annab vastuse 9, ruutjuur

select rand() --annab suvalise nr
select floor(rand() * 100) ---korrutab sajaga iga suvalise nr

--- iga kord näitab 10 suvalist nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
	print floor(rand() * 1000)
	set @counter = @counter + 1
end


select ROUND(850.556, 2)  --ümardab kaks kohta peale komat, tulemus on 850.560
select ROUND(850.556, 2, 1) --ümardab allapoole kaks kohta peale komat, tulemus 850.550
select ROUND(850.556, 1) --ümardab ülespoole ja võtab ainult esimest nr peale koma arvesse
select ROUND(850.556, 1, 1)  --ümardab alla
select ROUND(850.556, -2)  --ümardab täisnr ülesse
select ROUND(850.556, -1)  --ümardab täisnr allapoole


---
create function dbo.CalculateAge1 (@DOB date)
returns int
as begin
declare @Age int
set @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
	case
		when (MONTH(@DOB) > MONTH(GETDATE())) or
			 (MONTH(@DOB) > MONTH(GETDATE()) and DAY(@DOB) > DAY(GETDATE()))
		then 1
		else 0
		end
	return @Age
end

execute CalculateAge1 '11/30/2020'

---arvutab v'lja, kui vana on isik ja v]tab arvesse kuud ja p'evad
--antud juhul n'itab k]ike, ke son [le 36 a vanad
select Id, dbo.CalculateAge1(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge1(DateOfBirth) > 40

select * from EmployeesWithDates

--- inline table valued functions
alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')

-- scalare function annab mingis vahemikus olevaid andmeid, aga
-- inline table values ei kasuta begin ja end funktsioone
-- scalar annab väärtused ja inline annab tabeli
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- k]ik naissoost t;;tajad
select * from fn_EmployeesByGender('Female')

-- k]ik naissoost ja siis omakorda otsida sealt [lesse Pam
select * from fn_EmployeesByGender('Female')
where Name = 'Pam'

-- kahest erinevast tabelist andmete v]tmine ja koos kuvamine
-- esimene on funktsioon ja teine tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (Select Id, Name, cast(DateOfBirth as date)
		as DOB
		from EmployeesWithDates)

select * from fn_GetEmployees()

--- multi-state funktsiooni puhul peab defineerima uue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

-- inline tabeli funktsioonid on paremini t;;tamas kuna k'sitletakse vaatena
-- multi-table puhul on pm tegemist stored procedure-ga ja kulutab ressurssi rohkem

--muudame andmeid fn_GetEmployees() funktsiooniga
-- Sam nimi hakkab olema Sam1
update fn_GetEmployees() set Name = 'Sam' where Id = 1  -- saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam' where Id = 1 --multi-state puhul ei saa muuta

select * from EmployeesWithDates

-- deteministlikud ja mitte-deterministlikud

select count(*) from EmployeesWithDates
select SQUARE(3)  --k]ik tehtem'rgid on deterministlikud funktsioonid, sinna kuuluvad veel sum, avg ja square

--mitte-deterministlikud
select GETDATE()
select CURRENT_TIMESTAMP
select rand()  --see funktsioon saab olla mõlemas kategoorias, 
-- kõik oleneb sellest, kas sulgudes on 1 või ei ole

-- loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(4)

-- kuidas saab vaadata funktsiooni sisu
sp_helptext fn_GetNameById

create function fn_GetEmployeeNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

--peale seda ei saa koodi sisu n'ha
alter function fn_GetEmployeeNameById(@id int)
returns nvarchar(30)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

sp_helptext fn_GetEmployeeNameById

--muudame [levalpool olevat funktsiooni, kindlasti panna tabeli ette dbo.
--schemabinding seob funktsiooi tabeliga ära
alter function dbo.fn_GetEmployeeNameById(@id int)
returns nvarchar(30)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @id)
end

-- ei saa kustutada tabelit ilma funktsiooni kustutamata
drop table dbo.EmployeesWithDates

---temporary tables

--- #-märgi ette panemisel saame aru, et tegemist on temp table-ga
--- seda tabelit saab ainult selles päringus avada
create table #PersonDetails(Id int, Name nvarchar(20))
--otsida ülesse, kuhu tekkis #PersonDetails tabel?
insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like '#PersonDetails%'

--kuidas saab #PersonDetails tabelit 'ra kustutada
drop table #PersonDetails

--teeme stored procedure, mis loob meile temp tabeli

create proc spCreateLocalTempTable
as begin
	create table #PersonDetails(Id int, Name nvarchar(20))

	insert into #PersonDetails values(1, 'Mike')
	insert into #PersonDetails values(2, 'John')
	insert into #PersonDetails values(3, 'Todd')

	select * from #PersonDetails
end

--k'ivitame stored procedure
exec spCreateLocalTempTable

---globaalse temp table tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))
--mis vahe on globaalsel ja lokaalsel temp tabelil

---index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values
(1, 'Sam', 2500, 'Male'),
(2, 'Pam', 6500, 'Female'),
(3, 'John', 4500, 'Male'),
(4, 'Sara', 5500, 'Female'),
(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

--kuidas saada tulemus,et n'itab ainult palgad vahemikus 5000 kuni 7000

select * from EmployeeWithSalary
where Salary >= 5000 and Salary <= 7000

---loome indeksi, mis asetab palga kahanevasse järjestusse
create index IX_EmployeeSalary
on EmployeeWithSalary(Salary asc)

--- same teada, et mis on selle tabeli primaarvõti ja indeks
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--saame vaadata tabelit koos selle sisuga alates v'ga detailsest infost
select 
	TableName = t.name,
	IndexName = ind.name,
	IndexId = ind.index_id,
	ColumnId = ic.index_column_id,
	ColumnName = col.name,
	ind.*,
	ic.*,
	col.*
from
	sys.indexes ind
inner join
	sys.index_columns ic on ind.object_id = ic.object_id and ind.index_id = ic.index_id
inner join
	sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
inner join
	sys.tables t on ind.object_id = t.object_id
where 
	ind.is_primary_key = 0
	and ind.is_unique = 0
	and ind.is_unique_constraint = 0
	and t.is_ms_shipped = 0
order by
	t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

---indeksi kustutamine
drop index EmployeeWithSalary.IX_EmployeeSalary

---- indeksi tüübid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumiline
--8. Veerusäilitav
--9. Veergude indeksid
--10. Välja arvatud veergudega indeksid

-- klastris olev indeks määrab ära tabelis oleva füüsilise järjestuse 
-- ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)

-- andmete õige järjestuse loovad klastris olevad indeksid ja kasutab 
-- selleks Id nr-t
-- põhjus, miks antud juhul kasutab Id-d, tuleneb primaarvõtmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastris olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis 
-- ja seda saab klastrite puhul olla ainult üks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

-- annab veateate, et tabelis saab olla aonult üks klastris olev indesk
-- kui soovid, uut indesksit luua, siis kustuta olemasolev

-- saame luua ainult ühe klastris oleva indeksi tabeli peale
-- klastris olev indeks on analoogne telefoni suunakoodile

--loome composite indeksi
--enne tuleb kõik teised klastris olevad indeksid ära kustutada

create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)
-- kui teed select p'ringu sellele tabelile, siis peaksid n'gema andmeid,
-- mis on järjestatud selliselt: Esimeseks võetakse aluseks Gender veerg 
-- kahanevas järjestuses ja siis Salary veerg kasvavas

select * from EmployeeCity

insert into EmployeeCity values(6, 'Valerie', 2500, 'Female', 'Sydney')

drop index EmployeeCity.IX_Employee_Gender_Salary

--- mitte klastris olev indeks
create nonclustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult üks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- Juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks määratleb ära tabeli ridade slavestusjärjestuse
--- ja ei nõua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

--
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC07D08136E4
-- kui k'ivitad [levalpool oleva koodi, siis tuleb veateade,
-- et SQL server kasutab UNIQUE indeksit j]ustamaks v''rtuste unikaalsust
-- ja primaarvõtit. Koodiga unikaalseid indekseid ei saa kustutada, 
-- aga käsitsi saab

--sisestame uuesti need kaks koodirida andmeid

--teeme unikaalse mitte-klastris oleva indeksi
create unique nonclustered index UIX_EmployeeFirstnameLastname
on EmployeeFirstName(FirstName, LastName)

--kustutame tabeli andmed ära
truncate table EmployeeFirstName

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

--lisame uue unikaalse piirangu tabelile
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

insert into EmployeeFirstName values(3, 'John', 'Menco', 3500, 'Male', 'London')

-- saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

---
-- 1.Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel 
-- juba sisaldab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

-- koodinäide:
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

-- võtame maha indeksid ja võtmed
insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'London')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3123, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3220, 'Male', 'London1')
--- enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga 
--- nüüd läks keskmine rida läbi kuna linna nimi oli unikaalne

select * from EmployeeFirstName

--- View

-- view on salvestatud SQL-i päring. Saab käsitleda ka virtuaalse tabelina

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

-- view p'ringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub võtta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõiki veerge

-- teeme veeru, kus näeb ainult IT-töötajaid

create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'

select * from vITEmployeesInDepartment

select * from vEmployeesByDepartment
where DepartmentName = 'IT'

-- rida 1400