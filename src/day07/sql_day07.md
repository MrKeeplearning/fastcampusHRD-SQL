# Day07. 규칙 만들기

# 1. 조건 만들기

## 1.1. IF

- `IF(조건식, 참일 때 값, 거짓일 때 값` 형식으로 사용한다.
- SELECT 절에서 주로 사용되고, 결과 값으로 새로운 컬럼을 반환한다.

<p align="center">
    <img src="/src/resources/day07_if1.png">
</p>

```mysql
select name, if(attack >= 60, 'strong', 'weak') as attack_class
from mypokemon;
```

<p align="center">
    <img src="/src/resources/day07_if2.png">
</p>

<br/>

## 1.2. IFNULL

- 데이터가 NULL인지 아닌지 확인해 NULL이라면 새로운 값을 반환하는 함수
- `IFNULL([컬럼 이름], NULL일 때 값)` 형식으로 사용
- 입력한 컬럼의 값이 NULL인 로우에서 NULL일 때 값을 반환한다.
- SELECT 절에 주로 사용하고, 새로운 컬럼으로 결과를 반환한다.

<p align="center">
    <img src="/src/resources/day07_ifnull1.png">
</p>

위의 테이블을 살펴보면 172번과 470번에 해당하는 name이 null인 상태이다. 이 때 아래의 sql문을 실행하면 `full_name`이라는 새로운 컬럼을 생성하고 null인 row에 대해서 unknown이라는 값을 넣어 반환한다.

```mysql
select name, ifnull(name, 'unknown') as full_name
from mypokemon;
```

<p align="center">
    <img src="/src/resources/day07_ifnull2.png">
</p>

<br/>

# 2. 여러 조건 한 번에 만들기

## 2.1. CASE

- `IF`가 하나의 조건을 만들 때 사용하는 문법이었다면, `CASE`는 여러 개의 조건을 만들 때 사용하는 문법이다.
- `CASE`는 SELECT절에 주로 사용하는 함수로 새로운 컬럼을 결과 값으로 반환한다.
- ELSE를 생략하면 NULL 값을 반환한다.

```mysql
# 컬럼 이름을 입력하지 않는 형식
CASE
    WHEN 조건식1 THEN 결과값1
    WHEN 조건식2 THEN 결과값2
    ELSE 결과값3
END
```
```mysql
# 컬럼 이름을 입력하는 형식
CASE [컬럼 이름]
    WHEN 조건값1 THEN 결과값1
    WHEN 조건값2 THEN 결과값2
    ELSE 결과값3
END
```

## 2.2. CASE 활용 예시

<p align="center">
    <img src="/src/resources/day07_if1.png">
</p>

```mysql
select name,
case
	when attack >= 100 then 'very strong'
    when attack >= 60 then 'strong'
    else 'weak'
end as attack_class,
type,
case type
	when 'bug' then 'grass'
    when 'electric' then 'water'
    when 'grass' then 'bug'
end as rival_type
from mypokemon;
```

<p align="center">
    <img src="/src/resources/day07_case.png">
</p>

- `rival_type`컬럼에 해당하는 sql문을 살펴보면 case문 시작에 `type` 컬럼 이름을 입력한 것을 확인할 수 있다.
- `type` 컬럼 이름을 명시했기 때문에 when에서 'bug'가 어떤 컬럼에 해당하는 value인지 알 수 있는 것이다. 만약 case문의 시작에 컬럼 이름을 누락하면 `rival_type` 컬럼은 모두 `NULL`이 된다. 만약 case 시작에 컬럼 이름을 쓰기 싫다면 다음과 같이 작성해서 같은 결과를 얻을 수 있다.

    ```mysql
    case
        when type = 'bug' then 'grass'
        when type = 'electric' then 'water'
        when type = 'grass' then 'bug'
    end as rival_type
    ```
  
- 결과 테이블을 보면 `eevee`와 `porygon`의 rival_type에서 value는 NULL로 되어 있는데 이것은 case문에서 else 처리를 생략했기 때문이다.

<br/>

# 3. 함수 만들기

함수를 생성하는 문법은 다음과 같은 형식을 가진다.

```mysql
CREATE FUNCTION [함수 이름] ([입력값 이름][데이터 타입], ...) RETURNS [결과값 데이터 타입]
BEGIN
    DECLARE [임시값 이름][데이터 타입];
    SET [임시값 이름] = [입력값 이름];
    쿼리;
    RETURN 결과값
END
```

생성한 함수를 삭제하는 문법은 다음과 같다.

```mysql
DROP FUNCTION [함수 이름];
```

- 앞서 다루었던 `mypokemon`테이블에서 **공격력과 방어력의 합**을 가져오는 함수는 다음과 같이 작성할 수 있다.

```mysql
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION getAbility(attack INT, defenese INT) RETURNS INT
BEGIN
  DECLARE a INT;
  DECLARE b INT;
  DECLARE ability INT;
  SET a = attack;
  SET b = defense;
  SELECT a + b INTO ability;
  RETURN ability;
END
//
DELIMITER ;
```

- `SET GLOBAL log_bin_trust_function_creators = 1;` 구문은 사용자의 계정에 함수를 생성할 수 있는 권한을 부여하는 것이다.
- `DELIMITER`는 그대로 번역하면 구분자를 의미한다. MySQL에서 기본 구분자는 세미콜론(`;`)으로 지정되어 있어 하나의 sql 쿼리문이 끝났다는 것을 알릴 때 세미콜론을 붙여 알린다.
- 그런데 위에서 `BEGIN`과 `END` 사이에는 수 많은 세미콜론이 쓰여져 있고, 이것을 구분자로 인식하면 함수가 모두 생성되지 않았음에도 쿼리문이 끝난 것으로 인식하고 오류가 발생할 수 있다. 따라서 `DELIMITER //`는 `//`를 구분자로 사용하겠다고 선언한 것이고 `//`가 구분자로 지정된 동안에는 `;`도 단순 문자열로 인식하게 된다.
- `END` 다음에 `//`가 등장했을 때 비로소 함수 생성이 완료된 것이고, 다시 원래대로 세미콜론을 구분자로 사용하기 위해서 `DELIMITER ;`를 작성하여 세미콜론이 다시 구분자로 사용됨을 선언한다.
- 구분자는 꼭 `//`를 사용하지 않아도 괜찮다. `$`를 사용해도 무방하다.

## 함수를 사용하기

- 함수에서 반환하는 값을 하나의 새로운 컬럼에 담아 테이블로 나타낼 수 있도록 SELECT문에 함수를 사용한다.
- 아래의 SQL문은 `getability()`함수에서 리턴한 값을 ability라는 새로운 컬럼에 담아 테이블로 표현한다.

```mysql
select name, getability(attack, defense) as ability
from mypokemon;
```