use pokemon;
drop table if exists mypokemon;
create table mypokemon (
	number int not null primary key,
    name varchar(20),
    type varchar(20),
    height float,
    weight float,
    attack float,
    defense float,
    speed float
);
insert into mypokemon (number, name, type, height, weight, attack, defense, speed)
values (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
       (25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
       (26, 'raichu', 'electric', 0.8, 30, 90, 55, 110),
       (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
       (152, 'chikoirita', 'grass', 0.9, 6.4, 49, 65, 45);
       
select * from pokemon.mypokemon;

/*
Mission1
123 x 456을 가져온다.
*/
select 123 * 456;

/*
Mission2
2310 / 30
*/
select 2310 / 30;

/*
Mission3
'피카츄'라는 문자열을 '포켓몬'이라는 이름의 컬럼 별명으로 가져와 주세요.
*/
select * from mypokemon;
select name as '포켓몬'
from pokemon.mypokemon
where name = 'pikachu';

/*
Mission4
포켓몬 테이블에서 모든 포켓몬들의 컬럼과 값 전체를 가져와 주세요.
*/
select * from pokemon.mypokemon;

/*
Mission5
포켓몬 테이블에서 모든 포켓몬들의 이름을 가져와 주세요.
*/
select name from pokemon.mypokemon;

/*
Mission6
포켓몬 테이블에서 모든 포켓몬들의 이름과 키, 몸무게를 가져와 주세요.
*/
select name, height, weight
from mypokemon;

/*
Mission7
포켓몬 테이블에서 포켓몬들의 키를 중복 제거하고 가져와 주세요.
*/
select distinct height
from mypokemon;

/*
Mission8
포켓몬 테이블에서 모든 포켓몬들의 공격력을 2배 해 'attack2'라는 별명으로 이름과 함께 가져와 주세요.
*/
select name, attack*2 as attack2, attack
from mypokemon;

/*
Mission9
포켓몬 테이블에서 모든 포켓몬들의 이름을 '이름'이라는 한글 별명으로 가져와 주세요.
*/
select name as '이름'
from mypokemon;

/*
Mission10
포켓몬 테이블에서 모든 포켓몬들의 공격력은 '공격력'이라는 한글 별명으로,
방어력은 '방어력'이라는 한글 별명으로 가져와 주세요.
*/
select attack as '공격력', defense as '방어력'
from mypokemon;

/*
Mission11
현재 포켓몬 테이블의 키 컬럼은 m단위입니다. (1m = 100cm)
포켓몬 테이블에서 모든 포켓몬들의 키를 cm 단위로 환산하여 'height(cm)'라는 별명으로 가져와 주세요.
*/
select height * 100 as 'height(cm)'
from mypokemon;

/*
Mission12
포켓몬 테이블에서 첫번째 로우에 위치한 포켓몬 데이터만 컬럼 값 전체를 가져와 주세요.
*/
select * from mypokemon limit 1;

/*
Mission13
포켓몬 테이블에서 2개의 포켓몬 데이터만 이름은 '영문명'이라는 별명으로,
키는 '키(m)'라는 별명으로, 몸무게는 '몸무게(kg)'이라는 별명으로 가져와 주세요.
*/
select name as '영문명', height as '키(m)', weight as '몸무게(kg)'
from mypokemon
limit 2;

/*
Mission14
포켓몬 테이블에서 모든 포켓몬들의 이름과 능력치의 합을 가져오고,
이 때 능력치의 합은 'total'이라는 별명으로 가져와 주세요.
조건1. 능력치의 합은 공격력, 방어력, 속도의 합을 의미합니다.
*/
select name, attack + defense + speed as total
from mypokemon;

/*
Mission15
포켓몬 테이블에서 모든 포켓몬들의 BMI 지수를 구해서 ‘BMI’라는 별명으로 가져와 주세요.
이 때, 포켓몬을 구분하기 위해 이름도 함께 가져와 주세요.
조건1. BMI 지수 = 몸무게(kg) ÷ (키(m))²
조건2. 포켓몬 테이블 데이터의 체중은 kg 단위, 키는 m 단위입니다.
(힌트) MySQL에서 제곱은  ^ 로 표현합니다. (예시: 10²은 10^2로 표현합니다.)
※ FLOAT 데이터 타입은 입력 값의 근사치를 저장하기 때문에, 소수점이 나오는 게 정상입니다.
*/
select name, weight / (height^2) as BMI
from mypokemon;
