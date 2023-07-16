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

use pokemon;
select * from mypokemon;

/*
MISSION (1)
포켓몬의 이름을 마지막 3개 문자만, ‘last_char’이라는 별명으로 가져와 주세요.
*/
select right(name, 3) as last_char
from mypokemon;

/*
MISSION (2)
포켓몬 이름을 왼쪽에서 2개 문자를 ‘left2’라는 별명으로 가져와 주세요.
*/
select left(name, 2) as left2
from mypokemon;

/*
MISSION (3)
포켓몬 이름에서 이름에 o가 포함된 포켓몬만 모든 소문자 o를 대문자 O로 바꿔서 ’bigO’라는 별명으로 가져와 주세요.
Ex) 이름이 ‘pokemon’일 경우, ’bigO’ 값은 ’pOkemOn’이 됩니다.
*/
select replace(name, 'o', 'O') as bigO
from mypokemon
where name like '%o%';

/*
MISSION (4)
포켓몬 타입을 가장 첫번째 글자 1자, 가장 마지막 글자 1자를 합친 후, 대문자로 변환해서 ‘type_code’라는 별명으로 가져와 주세요. 이 때, 이름도 함께 가져와 주세요.
Ex) 타입이 ‘water’일 경우, ‘type_code’ 값은 ‘w’와 ‘r’를 대문자로 바꾼 ‘WR’이 됩니다.
*/
select name, upper(concat(left(type, 1), right(type, 1))) as type_code
from mypokemon;

/*
MISSION (5)
포켓몬 이름의 글자 수가 8보다 큰 포켓몬의 데이터를 전부 가져와 주세요.
*/
select *
from mypokemon
where length(name) > 8;

/*
MISSION (6)
모든 포켓몬의 공격력 평균을 정수로 반올림해서 ‘avg_of_attack’이라는 별명으로 가져와 주세요.
*/
select ceiling(avg(attack)) as avg_of_attack
from mypokemon;

select round(avg(attack)) as avg_of_attack
from mypokemon;

/*
MISSION (7)
모든 포켓몬의 방어력 평균을 정수로 내림해서 ‘avg_of_defense’이라는 별명으로 가져와 주세요.
*/
select floor(avg(defense)) as avg_of_defense
from mypokemon;

/*
MISSION (8)
이름의 길이가 8미만인 포켓몬의 공격력의 2 제곱을 ‘attack2’라는 별명으로 가져와 주세요. 이 때, 이름도 함께 가져와 주세요.
*/
select name, power(attack, 2) as attack2
from mypokemon
where length(name) < 8;

/*
MISSION (9)
모든 포켓몬의 공격력을 2로 나눈 나머지를 ‘div2’라는 별명으로 가져와 주세요. 이 때, 이름도 함께 가져와 주세요.
*/
select name, mod(attack, 2) as div2
from mypokemon;

/*
MISSION (10)
공격력이 50 이하인 포켓몬의 공격력을 방어력으로 뺀 값의 절댓값을 ‘diff’라는 별명으로 가져와 주세요. 이 때, 이름도 함께 가져와 주세요.
*/
select name, abs(attack - defense) as diff
from mypokemon
where attack <= 50;

/*
MISSION (11)
현재 날짜와 시간을 가져와 주세요. 각각 now_date, now_time이라는 별명으로 가져와 주세요.
*/
select left(now(), 10) as now_date, time(now()) as now_time;

select current_date() as now_date, current_time() as now_time;

/*
MISSION (12)
포켓몬을 포획한 달(월, MONTH)을 숫자와 영어로 가져와 주세요. 숫자는 month_num, 영어는 month_eng이라는 별명으로 가져와 주세요.
*/
select date_format(capture_date, '%c') as month_num, date_format(capture_date, '%M') as month_eng
from mypokemon;

select date_format(capture_date, '%m') as month_num, date_format(capture_date, '%M') as month_eng
from mypokemon;

SELECT MONTH(capture_date) AS month_num, MONTHNAME(capture_date) AS month_eng
FROM mypokemon;

/*
MISSION (13)
포켓몬을 포획한 날의 요일을 숫자와 영어로 가져와 주세요. 숫자는 day_num, 영어는 day_eng이라는 별명으로 가져와 주세요.
*/
select dayofweek(capture_date) as day_num, dayname(capture_date) as day_eng
from mypokemon;

/*
MISSION (14)
포켓몬을 포획한 날의 연도, 월, 일을 각각 숫자로 가져와 주세요. 연도는 year, 월은 month, 일은 day라는 별명으로 가져와 주세요.
*/
select year(capture_date) as year, month(capture_date) as month, dayofmonth(capture_date) as day
from mypokemon;