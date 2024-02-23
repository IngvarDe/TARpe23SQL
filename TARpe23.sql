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


