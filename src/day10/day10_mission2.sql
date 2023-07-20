DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
	   number  INT,
       name	VARCHAR(20)
);
INSERT INTO mypokemon (number, name)
VALUES (10, 'caterpie'),
	   (25, 'pikachu'),
       (26, 'raichu'),
       (133, 'eevee'),
       (152, 'chikoirita');
CREATE TABLE ability (
	   number INT,
	   type	VARCHAR(10),
       height FLOAT,
       weight FLOAT,
       attack INT,
       defense INT,
       speed int
);
INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
	   (25, 'electric', 0.4, 6, 55, 40, 90),
       (26, 'electric', 0.8, 30, 90, 55, 110),
	   (133, 'normal', 0.3, 6.5, 55, 50, 55),
	   (152, 'grass', 0.9, 6.4, 49, 65, 45);

/*
MISSION (1)
이브이의 번호 133을 활용해서, 이브이의 영문 이름, 키, 몸무게를 가져와 주세요.
이 때, 키는 height, 몸무게는 weight이라는 별명으로 가져와 주세요. 
*/
# 방법1
select name, height, weight
from (select mypokemon.number, name, height, weight
	  from mypokemon
      inner join ability
      on mypokemon.number = ability.number) as ma
where ma.number = 133;

# 방법2
select name, (select height from ability where number = 133) as height,
			 (select weight from ability where number = 133) as weight
from mypokemon
where number = 133;

# 방법3
select (select name from mypokemon where number = 133) as name, height, weight
from ability
where number = 133;


/*
MISSION (2)
속도가 2번째로 빠른 포켓몬의 번호와 속도를 가져와 주세요.
*/
select number, speed
from (select number, speed, rank() over(order by speed desc) as speed_rank
	  from ability) as a
where speed_rank = 2;


/*
MISSION (3)
방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬의 이름을 가져와 주세요.
*/
select name
from mypokemon
where number in (select number from ability where defense > all(select defense from ability where type = 'electric'));