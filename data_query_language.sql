-- DATA QUERY LANGUAGE

select * from owners;

alter table owners add column age int;

update owners set age = 25 where firstName = 'Jim';
update owners set age = 45 where firstName = 'Andrew';
update owners set age = 29 where firstName = 'Angela';

select * from owners;

select firstName, lastName from owners;
select firstName, dateOfBirth from owners;

insert into owners (firstName, lastName, dateOfBirth, age) 
values ('John', 'Adams', '1986-02-14', '38'), ('Laura', 'Piece', '1999-10-19', '23');

insert into owners (firstName, lastName, dateOfBirth, age)
values ('Winston', 'Churchill', '1898-06-06', '56');

alter table owners add column city varchar(50);

update owners set city = 'Las Vegas' where firstName = 'Angela';
update owners set dateOfBirth = '1898-05-06' where firstName = 'Winston';

select * from owners where dateOfBirth > '1989-12-21';
select * from owners where age = 25;
select * from owners where age > 25;
select * from owners where age < 25;



select * from owners where firstName in ('Laura', 'John');
select * from owners where firstName not in ('Laura', 'John');
select * from owners where city is null;
select * from owners where city is not null;

select * from owners where age != 25;
select * from owners where firstName != 'John';   --    != sau <>

select * from owners where age between 40 and 60;    -- intervalul include si limitele

select * from owners where firstName like 'A%';  /* procentul inlocuieste toate celelalte litere, nu conteaza lungimea cuvantului si nu ne intereseaza cu ce se termina */
select * from owners where firstName like '%ew';  /* nu ne intereseaza cu ce incepe cuvantul, ci sa se termine cu ew */
select * from owners where firstName like '%an%'; /* aici spunem sistemului ca nu ne intereseaza decat sa contina litera/literele respective */

select * from owners where dateOfBirth like '1999%';
select * from owners where dateOfBirth like '198%'; -- si asa mai departe
select * from owners where dateOfBirth like '%19'; -- ne intere doar cei nascuti in ziua de 19
select * from owners where dateOfBirth like '%02%'; -- ne intere doar cei nascuti in luna a 6a
select * from owners where dateOfBirth like '%-06-%'; 


select * from owners 
where firstName like 'An%'
and dateOfBirth like '198%';

select * from owners 
where (firstName like 'An%'
or dateOfBirth like '198%')
and city = 'Las Vegas';

select * from owners 
where firstName like 'An%'
or dateOfBirth like '198%'
and city = 'Las Vegas';


--  FUNCTII AGREGATE
select sum(age) from owners;
select avg(age) from owners;
select min(age) from owners;
select max(age) from owners;
select count(*) from owners;
select count(city) from owners;

alter table owners add column ownerid int primary key auto_increment;
alter table owners modify column ownerid int auto_increment first;  -- la modify trebuiesc specificate toate proprietatile pe care le vrem pe coloana(altfel sunt anulate)
desc owners; -- prescurtarea de la describe

select * from owners;
insert into owners (firstName, lastName, dateOfBirth, age) values ("Brad", 'Pitt', '1968-05-30', 54); 
insert into owners (firstName, lastName, dateOfBirth, age) values ("Angelina", 'Jolie', '1975-04-16', 47);


create table pets( 
petid int not null auto_increment,
race  varchar(45) not null,
dateOfbirth date not null, 
ownerid int not null, 
primary key (petid),
constraint fk_pets_owners foreign key (ownerid) references owners (ownerid) -- fk= foreign key, pets= numele tabelei de la care se pleaca(in care creezi cheia secundara), owners = numele tabelei destinatie(in care ajungem)petid
);


select * from owners;
select * from pets;
insert into pets (race, dateOfBirth, ownerid)
values ('european', '2019-10-12', 6);
-- ^^^^^^
/* Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`petclinic`.`pets`, CONSTRAINT `fk_pets_owners` FOREIGN KEY (`ownerid`) REFERENCES `owners` (`ownerid`)) */

insert into pets (race, dateOfBirth, ownerid)
values ('european', '2019-11-18', 3);
insert into pets (race, dateOfBirth, ownerid)
values ('husky', '2020-09-16', 2);
insert into pets (race, dateOfBirth, ownerid)
values ('pisica norvegiana', '2022-03-16', 2);
insert into pets (race, dateOfBirth, ownerid)
values ('golden retriever', '2018-12-15', 3);

delete from owners where ownerid = 8;
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`petclinic`.`pets`, CONSTRAINT `fk_pets_owners` FOREIGN KEY (`ownerid`) REFERENCES `owners` (`ownerid`))

delete from pets where ownerid = 8;
delete from owners where ownerid = 8;
delete from pets where ownerid= 3 and dateOfbirth = '2019-10-12';

select * from owners; 
select * from pets;
select * from owners cross join pets;
select * from owners inner join pets on owners.ownerid = pets.ownerid; -- cheia primara din prima tabela si cheia secundara din a doua tabela
select * from owners left join pets on owners.ownerid  = pets.ownerid;
select * from owners left join pets on owners.ownerid  = pets.ownerid where pets.ownerid is null;
select * from owners left join pets on owners.ownerid  = pets.ownerid where pets.ownerid is not null; -- rezultatele sunt identice cu inner join

-- Instructiuni echivalente
select * from owners right join pets on owners.ownerid  = pets.ownerid; 
select * from pets left join owners on owners.ownerid = pets.ownerid; 

select * from owners right join pets on owners.ownerid = pets.ownerid where owners.ownerid is null;
select * from owners right join pets on owners.ownerid = pets.ownerid where owners.ownerid is not null;

-- Cross join- se vor aduce toate combinatiile intre inregistrarile din tabela din dreapta si ce adin stanga
-- Inner join - se vor aduce toate datele care exista in ambele tabele, comparatia facandu-se pe coloana pe care se face conditia de join 
-- Left join - se aduc toate inregistrarile din tabela din stanga si se compara cu cele din dreapta.
       -- Astfel se vor aduce toate randurile din tabela din stanga, iar pe coloanele aferente tabelei din dreapta se va completa doar cu randurile care au echivalent
       -- ( adica cele a caror cheie primara exista in tabela din dreapta
-- Right join - se aduc toate inregistrarile din tabela din dreapta si se compara cu cele din stanga.
	   -- Astfel se vor aduce toate randurile din tabela din dreapta, iar pe coloanele aferente tabelei din stanga se va completa doar cu randurile care au echivalent
       -- (adica cele a caror cheie primara exista in tabela din stanga)

select * from owners;
select * from pets;
select * from owners order by dateOfBirth; -- sortarea se va face by default ascendent
select * from owners order by dateOfBirth desc; -- desc = descendent
select * from owners order by age desc limit 1;
select max(age) from owners;  

select  o.ownerid, firstName, lastName, count(petid)
from owners o inner join pets p on o.ownerid = p.ownerid
where count(petid) > 2
group by o.ownerid, firstName, lastName
having count(petid) > 2;

-- In mod normal filtrarea se face cu clauza where, singura exceptie fiind functiile agregate care se pot filtra doar cu clauza having


select * from owners inner join pets on owners.ownerid = pets.ownerid; -- Error Code: 1052. Column 'ownerid' in on clause is ambiguous
select * from owners o inner join pets p on o.ownerid = p.ownerid;
-- alliases- nume temporale pe care le vedem la executie
select o.ownerid, firstName, lastName, race, o.dateOfBirth ownerBirthDate, p.dateOfBirth petBirthDate 
from owners o inner join pets p on o.ownerid = p.ownerid;


-- CRUD -- CREATE
        -- READ
        -- UPDATE
        -- DELETE
       
       