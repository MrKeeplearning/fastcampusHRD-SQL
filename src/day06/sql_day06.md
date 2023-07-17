# Day06. 데이터 그룹화하기

# 1. GROUP BY: 데이터 그룹화

- `GROUP BY [컬럼 이름]`의 형식으로 사용
- 그룹 별 데이터를 집계할 때 사용
- GROUP BY가 쓰인 쿼리의 SELECT 절에는 GROUP BY 대상 컬럼과 그룹 함수만 사용 가능

```mysql
SELECT [GROUP BY 대상 컬럼 이름], ..., [그룹함수]
FROM [테이블 이름]
WHERE 조건식
GROUP BY [컬럼 이름];
```

<p align="center">
    <img src="/src/resources/day06_groupby.png">
</p>

```mysql
select type
from mypokemon
group by type;
```

<p align="center">
    <img src="/src/resources/day06_groupby_result.png">
</p>

위의 sql문은 `distinct`를 사용해도 동일한 결과를 얻을 수 있다.

```mysql
select distinct type
from mypokemon;
```

<br/>

# 2. HAVING: 그룹에 조건 주기

- 가져올 데이터 그룹에 조건을 지정해주는 키워드
- 조건식이 참이 되는 그룹만 선택
- HAVING 절의 조건식에는 그룹 함수를 활용

```mysql
SELECT [컬럼 이름], ..., [그룹 함수]
FROM [테이블 이름]
WHERE 조건식
GROUP BY [컬럼 이름]
HAVING 조건식;
```

<br/>

# 3. 다양한 그룹 함수 알아보기

## 3.1. COUNT([컬럼 이름])

- 그룹의 값 수를 세는 함수
- `COUNT([컬럼 이름])` 형식을 따르고 COUNT는 SELECT 절에, 그리고 HAVING 절에는 조건식을 작성한다.
- COUNT에 작성하는 컬럼 이름은 그룹의 기준이 되는 컬럼 이름과 같아도 되고, 같지 않아도 괜찮다. GROUP BY 문에 작성한 컬럼을 기준으로 COUNT 작업을 진행한다.
- COUNT(*)와 COUNT(1)과 달리 NULL이 있을 경우 NULL을 제외한 나머지 ROW의 개수를 카운트한다.

```mysql
SELECT [컬럼 이름], ..., COUNT([컬럼 이름])
FROM [테이블 이름]
GROUP BY [컬럼 이름]
HAVING 조건문;
```

<br/>

## 3.2. COUNT(*)와 COUNT(1)

### COUNT(*)
- `COUNT(*)`는 NULL까지 포함해서 테이블 내에 존재하는 모든 row의 개수를 반환한다.

### COUNT(1)
- `COUNT(1)` 그룹 함수는 쿼리 결과 집합의 모든 레코드를 값 1로 바꾼다. NULL이 있어도 1로 값을 바꾼다. 결과적으로 GROUP BY 절에 입력한 기준이 되는 컬럼에서 총 1의 개수를 리턴한다.
- 1이 아닌 2를 입력해도 상관이 없다. `COUNT(2)`를 해도 리턴하는 값은 동일하게 GROUP BY 절에 입력한 기준이 되는 컬럼에서 총 2의 개수를 리턴하는 것이다. 심지어 숫자가 아닌 'STRING'과 같이 문자열을 입력해도 값은 똑같다.

<br/>

## 3.3. SUM

```mysql
SELECT [컬럼 이름], ..., SUM([컬럼 이름])
FROM [테이블 이름]
GROUP BY [컬럼 이름]
HAVING 조건문;
```

- 그룹의 합을 계산하는 함수
- SELECT절에는 `SUM([컬럼 이름])`을 HAVING 절에는 조건문을 작성한다.
- 집계할 컬럼의 이름은 그룹의 기준이 되는 컬럼 이름과 같아도 되고, 같지 않아도 괜찮다.
- GROUP BY절이 없는 쿼리에서도 사용가능하지만 이때는 전체 로우에 함수가 적용된다.

<br/>

## 3.4. AVG

```mysql
SELECT [컬럼 이름], ..., AVG([컬럼 이름])
FROM [테이블 이름]
GROUP BY [컬럼 이름]
HAVING 조건문;
```

- 그룹의 평균을 계산하는 함수
- SELECT 절에는 AVG함수를, HAVING절에는 조건문을 작성한다.
- 집계할 컬럼 이름은 그룹의 기준이 되는 컬럼 이름과 같아도 되고 같지 않아도 괜찮다.
- GROUP BY가 없는 쿼리에서도 사용 가능하며 전체 로우에 함수가 적용된다.

<br/>

## 3.5. MIN과 MAX

```mysql
SELECT [컬럼 이름], ..., MIN([컬럼 이름])
FROM [테이블 이름]
GROUP BY [컬럼 이름]
HAVING 조건문;
```

- 그룹의 최솟값 또는 최댓값을 반환하는 함수
- SELECT절에는 MIN 또는 MAX를, HAVING절에는 조건문을 작성한다.
- 집계할 컬럼 이름은 그룹의 기준이 되는 컬럼 이름과 같아도 되고 같지 않아도 괜찮다.
- GROUP BY가 없는 쿼리에서도 사용 가능하며 전체 로우에 함수가 적용된다.

<br/>

# 4. 쿼리의 실행 순서

| **키워드**  | **문법**           | **작성 순서** | **실행 순서** |
|:--------:|:----------------:|:---------:|:---------:|
| SELECT   | SELECT [컬럼 이름]   | 1         |     5     |
| FROM     | FROM [테이블 이름]    | 2         |     1     |
| WHERE    | WHERE 조건식        | 3         |     2     |
| GROUP BY | GROUP BY [컬럼 이름] | 4         |     3     |
| HAVING   | HAVING 조건식       | 5         |     4     |
| ORDER BY | ORDER BY [컬럼 이름] | 6         |     6     |
