DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
                           number INT,
                           name	VARCHAR(20),
                           type	VARCHAR(10),
                           attack INT,
                           defense INT,
                           capture_date DATE
);
INSERT INTO mypokemon (number, name, type, attack, defense, capture_date)
VALUES (10, 'caterpie', 'bug', 30, 35, '2019-10-14'),
       (25, 'pikachu', 'electric', 55, 40, '2018-11-04'),
       (26, 'raichu', 'electric', 90, 55, '2019-05-28'),
       (125, 'electabuzz', 'electric', 83, 57, '2020-12-29'),
       (133, 'eevee', 'normal', 55, 50, '2021-10-03'),
       (137, 'porygon', 'normal', 60, 70, '2021-01-16'),
       (152, 'chikoirita', 'grass', 49, 65, '2020-03-05'),
       (153, 'bayleef', 'grass', 62, 80, '2022-01-01');

USE pokemon;
SELECT * FROM mypokemon;

/*
MISSION (1)
포켓몬 테이블에서 포켓몬의 이름과 이름의 글자 수를 이름의 글자 수로 정렬해서 가져와 주세요.
(정렬 순서는 글자 수가 적은 것부터 많은 것 순으로 해주세요.) 
*/
select name, length(name) as length
from mypokemon
order by length;

/*
MISSION (2)
포켓몬 테이블에서 방어력 순위를 보여주는 컬럼을 새로 만들어서  ‘defense_rank’라는 별명으로 가져와 주세요. 이 때, 포켓몬 이름 데이터도 함께 가져와 주세요.
조건1: 방어력 순위란 방어력이 큰 순서대로 나열한 순위를 의미합니다.
조건2: 공동 순위가 있으면 다음 순서로 건너 뛰어 주세요.
*/
select name, rank() over(order by defense desc) as defense_rank
from mypokemon;

/*
MISSION (3)
포켓몬 테이블에서 포켓몬을 포획한 지 기준 날짜까지 며칠이 지났는 지를 ‘days’라는 별명으로 가져와 주세요. 이 때, 포켓몬의 이름도 함께 가져와 주세요.
조건: 기준 날짜는 2022년 2월 14일입니다.
*/
select name, datediff('2022-02-14', capture_date) as days
from mypokemon;
