# Day05. 원하는 데이터 만들기

## 1. ORDER BY

```mysql
select [컬럼 이름]
from [테이블 이름]
where 조건식
order by [컬럼 이름] desc;
```

- `ORDER BY [컬럼 이름]` 형식으로 사용
- `[컬럼 이름]`의 값을 기준으로 모든 row를 정렬
- 기본 정렬 규칙은 오름차순: `ORDER BY [컬럼 이름]` = `ORDER BY [컬럼 이름] ASC`
- 내림차순은 `ASC`가 아닌 `DESC`를 사용
- 여러 컬럼으로 정렬 가능
  - `ORDER BY [컬럼1], [컬럼2], ...`
  - 위치한 순서대로 정렬이 되기 때문에 위의 경우에는 컬럼1을 기준으로 정렬하며, 만약 동일한 값이 있을 때는 컬럼 2를 기준으로 정렬한다.

<p align="center">
  <img src="/src/resources/day05_orderby.png" width="600">
</p>

```mysql
select number, name, attack, defense
from mypokemon
order by attack desc, defense;
```

<p>
  <img src="/src/resources/day05_orderby2.png">
</p>

- 위의 sql문을 살펴보면 attack을 내림차순으로 먼저 정렬 후, 같은 값이 있을 경우 defense를 기준으로 정렬하도록 되어 있다.
- pikachu와 eevee는 attack의 value가 동일하다. 따라서 그 다음 정렬 기준인 defense에서 eevee의 defense value가 더 높기 때문에 pickachu, eevee의 순서로 정렬하게 된다.
- select문에 작성한 컬럼의 인덱스를 활용해서 동일한 기능이지만 조금 다르게 sql문을 작성할 수도 있다.

```mysql
select number, name, attack, defense
from mypokemon
order by 3 desc, 4;
```

- 위의 sql문에서 3은 attack 컬럼을, 4는 defense 컬럼을 의미한다.

<br/>

## 2. 데이터 순위 만들기

### RANK() OVER

```mysql
# 내림차순 순위 만들기
select [컬럼 이름], ..., rank() over (order by [컬럼 이름] desc)
from [테이블 이름]
where 조건식;
```

- 데이터를 정렬해서 순위를 만들어주는 함수
- 항상 ORDER BY와 함께 사용
- SELECT 절에서 사용하고 정렬된 순서에 순위를 붙인 새로운 컬럼을 보여준다. 실제 데이터에는 영향이 없다.

<p align="center">
  <img src="/src/resources/day05_orderby.png" width="600">
</p>

```mysql
SELECT name, attack, RANK() OVER(ORDER BY attack DESC) AS attack_rank
FROM mypokemon;
```

<p align="center">
  <img src="/src/resources/day05_rank.png">
</p>

### DENSE_RANK와 ROW_NUMBER

- `RANK`: 공동 순위가 있으면 다음 순서로 건너 뜀
- `DENSE_RANK`: 공동 순위가 있어도 다음 순위로 뛰어 넘지 않음
- `ROW_NUMBER`: 공동 순위를 무시함

```mysql
SELECT name, attack,
RANK() OVER(ORDER BY attack DESC) AS rank_rank,
DENSE_RANK() OVER(ORDER BY attack DESC) AS rank_dense_rank,
ROW_NUMBER() OVER(ORDER BY attack DESC) AS rank_row_number
FROM mypokemon;
```

<p align="center">
  <img src="/src/resources/day05_rank2.png">
</p>

<br/>

## 3. 문자형 데이터

- MySQL 내의 다양한 타입의 데이터는 함수를 사용해서 변형 가능
- 함수의 결과 값은 새로운 컬럼으로 반환된다.

| ** 함수**   | **활용 예시**                | **설명**                                 |
|:---------:|:------------------------:|:--------------------------------------:|
| LOCATE    | LOCATE("A", "ABC")       | "ABC"에서 "A"는 몇 번째에 위치해 있는지 검색해서 위치를 반환 |
| SUBSTRING | SUBSTRING("ABC", 2)      | "ABC"에서 2번째 문자부터 반환                    |
| RIGHT     |  RIGHT("ABC", 1)         | "ABC"의 오른쪽에서 1번째 문자까지 반환               |
| LEFT      | LEFT("ABC", 1)           | "ABC"의 왼쪽에서 1번째 문자까지 반환                |
| UPPER     | UPPER("abc")             | "abc"를 대문자로 바꿔서 반환                     |
| LOWER     | LOWER("ABC")             | "ABC"를 소문자로 바꿔서 반환                     |
| LENGTH    | LENGTH("ABC")            | "ABC"의 글자 수를 반환                        |
| CONCAT    | CONCAT("ABC", "DEF")     | "ABC" 문자열과 "CDF" 문자열을 합쳐서 반환           |
| REPLACE   | REPLACE("ABC", "A", "Z") | "ABC"의 "A"를 "Z"로 바꿔서 반환                |

- `LOCATE`는 찾는 문자가 여러 개일 때 가장 먼저 찾은 문자의 위치를 반환하고, 만약 찾는 문자가 없다면 0을 반환한다.
- `SUBSTRING`은 입력한 숫자가 문자열의 길이보다 크다면 아무것도 가져오지 않는다.
- `SUBSTRING`, `RIGHT`, `LEFT`에서 위치를 나타내는 숫자는 말 그대로 해당 위치를 말한다. 0부터 시작하지 않는다. "ABC"에서 첫번째는 "A"를 의미한다.

<br/>

## 4. 숫자형 데이터

- `ABS(숫자)`: 숫자의 절댓값을 반환
- `CEILING(숫자)`: 숫자를 정수로 올림해서 반환
- `FLOOR(함수)`: 숫자를 정수로 내림해서 반환
- `ROUND(숫자, 자릿수)`와 `TRUNCATE(숫자, 자릿수)`
  - `ROUND(숫자, 자릿수)`: 숫자를 소수점 자릿수까지 반올림해서 반환
  - `TRUNCATE(숫자, 자릿수)`: 숫자를 소수점 자릿수까지 버림해서 반환
  - 둘 모두 자릿수에 0을 입력하면 정수만 반환
- `POWER(숫자 A, 숫자 B)`: 숫자A의 숫자B 제곱 반환
- `MOD(숫자 A, 숫자 B)`: 숫자A를 숫자B로 나눈 나머지 반환ㅓ

<br/>

## 5. 날짜형 데이터

- [날짜형 데이터 함수 공식문서](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html)
- [DATE_FORMAT 공식문서](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format)

