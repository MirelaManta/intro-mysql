/* Crearea unei tabele */
CREATE TABLE petOwners (
    firstName VARCHAR(25) NOT NULL,
    lastName VARCHAR(25) NOT NULL
);
/* adaugarea unei coloane din tabele */ 
alter table owners
add column age int;

/* stergerea unei coloane din tabela - doua instructiuni echivalente */
alter table owners drop age;
alter table owners drop column age; 

/* MODIFY poate sa modifice propritatile unei coloane 
Atentie!!
Daca in mom in care executam instructiunea nu specificam toate proprietatile pe care le-am specificat la creare, ele vor fi sterse */

 
desc owners; /*- -- arata structura tabelei;*/ 
alter table owners modify firstName char(25) not null;
alter table owners modify lastName char(25) not null; 

/* instructiunea de CHANGE ne ajuta sa schimbam numele unei coloane */
alter table owners change lastName ownerLastName char(25) not null;

/* instrctiunea de RENAME ne ajuta sa scjimbam numele tabelei */
alter table petowners rename to owners ;

/* drop table petOwner; -----> ATENTIE!! VA STERGE TABELE IMPREUNA CU TOATE INFORMATIILE DIN EA SI NU SE MAI POATE RECUPERA */