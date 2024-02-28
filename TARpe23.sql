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

-- v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId
-- alla v��rtust, siis see automaatselt sisestab sellele reale
-- v��rtuse 3 e unknown

-- enne testime andmebaasi
insert into Person values
(7, 'Spiderman', 'sp@sp.com', NULL)

-- n��d sisestame v��rtuse panemise
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

--n��d sisestame andmed uuesti
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

-- kellel nimes esimene t�ht ei ole W, A, C
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