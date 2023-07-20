DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
	number  int,
       name	varchar(20),
       type	varchar(10),
       attack int,
       defense int
);
CREATE TABLE friendpokemon (
	number  int,
       name	varchar(20),
       type	varchar(10),
       attack int,
       defense int
);
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
	   (25, 'pikachu', 'electric', 55, 40),
	   (26, 'raichu', 'electric', 90, 55),
	   (133, 'eevee', 'normal', 55, 50),
	   (152, 'chikoirita', 'grass', 49, 65);

INSERT INTO friendpokemon (number, name, type, attack, defense)
VALUES (26, 'raichu', 'electric', 80, 60),
	   (125, 'electabuzz', 'electric', 83, 57),
       (137, 'porygon', 'normal', 60, 70),
       (153, 'bayleef', 'grass', 62, 80),
       (172, 'pichu', 'electric', 40, 15),
       (470, 'leafeon', 'grass', 110, 130);

/*
MISSION (1)
나도 가지고 있고, 친구도 가지고 있는 포켓몬의 이름을 가져와 주세요.
*/
select m.name
from mypokemon as m 
inner join friendpokemon as f
on m.number = f.number and m.name = f.name;

/*
MISSION (2)
나만 가지고 있고, 친구는 안 가지고 있는 포켓몬의 이름을 가져와 주세요.
A (내가 가지고 있는 포켓몬) - B (친구가 가지고 있는 포켓몬)
*/
select my.name
from mypokemon as my
left join friendpokemon as friend
on my.number = friend.number and my.name = friend.name
where friend.number is null;
