create database pokemon;

use pokemon;
create table mypokemon
(
    number INT,
    name   varchar(20),
    type   varchar(20)
);
insert into mypokemon (number, name, type)
values (10, 'caterpie', 'bug'),
       (25, 'pikachu', 'electric'),
       (133, 'eevee', 'normal');

select * from mypokemon;