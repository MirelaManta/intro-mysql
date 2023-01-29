alter table owners change ownerLastName lastName varchar(25);
alter table owners add column dateOfBirth date;

insert into owners (firstName, lastName, dateOfBirth)
values ('Jim', 'Jameson', '1980-01-31');

insert into owners(firstName, lastName, dateOfBirth)
values ('Andrew', 'Smith', '1987-02-16'), ('Angela', 'Yung', '1992-05-03'); /* cum se insereaza mai multe randuri in acelasi timp */


/* Instructiune de insert fara specificarea coloanelor. ATENTIE!! Trebuie in cazul asta sa specificam (OBLIGATORIU) nr exact de valori corespunzator nr de coloane */ 
insert into owners values ('Tom', 'Anderson', '1979-06-29');
insert into owners values ('Mirela', 'Manta'); /* va returna eroare:Error Code: 1136. Column count doesn't match value count at row 1 */


-- verificam rezultatele instructiunii de insert
select * from owners;

-- -------------------------

update owners set firstName = 'James';
-- Verificam rezultatele instructiunii de update 

-- --------------------------

select * from owners;
-- stergerea tuturor inregistrarilor din tabele 
delete from owners; 

-- Verificam rezulatele instructiunii de delete
select * from owners;

-- ---------------------------
-- Stergerea tuturor inregistrarilor din tabele cu truncate
truncate table owners;
-- Verificam rezulatele instructiunii de truncate
select * from owners;
-- Diferenat intrre DELETE si TRUNCATE:
/* DELETE are capacitatea de a numara inregistarile pe care le sterge, iar TRUNCATE sterge fara a numara
Cu DELETE putem sa filtram si sa stergem doar anumite inregistrari, in schimb la TRUNCATE nu putem face filtrare */


