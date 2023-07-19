DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon
(
    number INT,
    name   VARCHAR(20),
    type   VARCHAR(10)
);
INSERT INTO mypokemon (number, name, type)
VALUES (10, 'caterpie', 'bug'),
       (25, 'pikachu', 'electric'),
       (26, 'raichu', 'electric'),
       (133, 'eevee', 'normal'),
       (152, 'chikoirita', 'grass');
CREATE TABLE ability
(
    number  INT,
    height  FLOAT,
    weight  FLOAT,
    attack  INT,
    defense INT,
    speed   int
);
INSERT INTO ability (number, height, weight, attack, defense, speed)
VALUES (10, 0.3, 2.9, 30, 35, 45),
       (25, 0.4, 6, 55, 40, 90),
       (26, 0.8, 30, 90, 55, 110),
       (133, 0.3, 6.5, 55, 50, 55),
       (137, 0.8, 36.5, 60, 70, 40),
       (152, 0.9, 6.4, 49, 65, 45),
       (153, 1.2, 15.8, 62, 80, 60),
       (172, 0.3, 2, 40, 15, 60),
       (470, 1, 25.5, 110, 130, 95);

/*
MISSION (1)
포켓몬 타입 별 키의 평균을 가져와 주세요.
*/
select type, avg(height)
from mypokemon
         left join ability
                   on mypokemon.number = ability.number
group by type;

/*
MISSION (2)
포켓몬의 타입 별 몸무게의 평균을 가져와 주세요.
*/
select type, avg(weight)
from mypokemon
         left join ability
                   on mypokemon.number = ability.number
group by type;

/*
MISSION (3)
포켓몬의 타입 별 키의 평균과 몸무게의 평균을 함께 가져와 주세요.
*/
select type, avg(height), avg(weight)
from mypokemon
         left join ability
                   on mypokemon.number = ability.number
group by type;

/*
MISSION (4)
번호가 100 이상인 내 포켓몬들의 번호, 이름, 공격력, 방어력을 가져와 주세요.
*/
select mypokemon.number, name, attack, defense
from mypokemon
         left join ability
                   on mypokemon.number = ability.number
where mypokemon.number >= 100;

/*
MISSION (5)
공격력과 방어력의 합이 큰 순서대로 내 포켓몬들의 이름을 나열해 주세요.
*/
select name, (attack + defense) as ad
from mypokemon
         left join ability
                   on mypokemon.number = ability.number
order by ad desc;

/*
MISSION (6)
속도가 가장 빠른 내 포켓몬의 이름을 가져와 주세요.
*/
select name
from mypokemon
         left join ability
                   on mypokemon.number = ability.number
order by speed desc
limit 1;