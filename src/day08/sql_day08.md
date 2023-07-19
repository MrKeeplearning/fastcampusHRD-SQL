# Day08. 테이블 합치기

# 1. JOIN: 테이블을 합칠 때 사용하는 키워드

- 같은 의미를 가지는 컬럼의 값을 기준으로 테이블을 합칠 때 사용하는 키워드
- `JOIN`의 종류: INNER JOIN, LEFT JOIN, RIGHT JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN

<br/>

# 2. 기준으로 테이블 합치기

## 2.1. INNER JOIN

<p align="center">
    <img src="/src/resources/INNERJOIN.png">
</p>

- INNER JOIN은 JOIN의 기본 설정이기 때문에 JOIN만 적는다면 자동으로 INNER JOIN으로 인식한다.
- INNER JOIN은 두 테이블에 모두 존재하는 값을 합친다.

<p align="center">
    <img src="/src/resources/DAY08_INNERJOIN1.png">
</p>

```mysql
SELECT [컬럼 이름]
FROM [테이블 A 이름]
INNER JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B 이름]
WHERE 조건식;
```

<p align="center">
    <img src="/src/resources/day08_innerjoin_table.png">
</p>

```mysql
SELECT *
FROM mypokemon
INNER JOIN ability
ON mypokemon.number = ability.number;
```

<p align="center">
    <img src="/src/resources/day08_innerjoin_result.png">
</p>

<br/>

# 3. 한쪽을 기준으로 테이블 합치기

## OUTER JOIN(외부조인)

<p align="center">
    <img src="/src/resources/OUTER_JOIN.png">
</p>

- 내부조인은 두 테이블 모두 데이터가 있어야 결과가 나오지만, 외부 조인은 한쪽에만 데이터가 있어도 결과가 나온다.
- `LEFT OUTER JOIN`: 왼쪽 테이블의 모든 값이 출력되는 조인
- `RIGHT OUTER JOIN`: 오른쪽 테이블의 모든 값이 출력되는 조인
- `FULL OUTER JOIN`: 왼쪽 또는 오른쪽 테이블의 모든 값이 출력되는 조인

```mysql
# LEFT JOIN
SELECT [컬럼 이름]
FROM [테이블 A 이름]
LEFT JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B 이름]
WHERE 조건식;

# RIGHT JOIN
SELECT [컬럼 이름]
FROM [테이블 A 이름]
RIGHT JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B 이름]
WHERE 조건식;
```

<p align="center">
    <img src="/src/resources/day08_leftjoin.png">
</p>

```mysql
select *
from mypokemon
left join ability
on mypokemon.number = ability.number;
```

<p align="center">
    <img src="/src/resources/day08_leftjoin_result.png">
</p>

- 만약 LEFT JOIN이나 RIGHT JOIN에서 한쪽 테이블에만 있고 다른 테이블에는 대응되는 값이 없을 때 NULL로 표현한다.

<br/>

## FULL OUTER JOIN

- FULL OUTER JOIN은 두 테이블에 있는 모든 값을 합치는 작업을 수행한다.
- `UNION`이라는 키워드를 LEFT JOIN 쿼리문과 RIGHT JOIN 쿼리문 사이에 작성한다.

```mysql
SELECT [컬럼 이름]
FROM [테이블 A 이름]
LEFT JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B 이름]
UNION
SELECT [컬럼 이름]
FROM [테이블 A 이름]
RIGHT JOIN [테이블 B 이름]
ON [테이블 A 이름].[컬럼 A 이름] = [테이블 B 이름].[컬럼 B 이름]
```

<p align="center">
    <img src="/src/resources/day08_fullouterjoin_table.png">
</p>

```mysql
select *
from mypokemon
left join ability
on mypokemon.number = ability.number
union
select *
from mypokemon
right join ability
on mypokemon.number = ability.number;
```

<p align="center">
    <img src="/src/resources/day08_fullouterjoin_result.png">
</p>

<br/>

# 4. 다양한 방식으로 테이블 합치기

## 4.1. CROSS JOIN(상호 조인)

<p align="center">
    <img src="/src/resources/CROSS_JOIN.png">
</p>

- `CROSS JOIN`은 한쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인시키는 기능
- 상호 조인 결과의 전체 행 수는 두 테이블의 각 행의 개수를 곱한 수만큼 된다.
- 카티션 곱(cartesian product)라고도 한다.

```mysql
select *
from [테이블 A 이름]
cross join [테이블 B 이름]
```

<br/>

## 4.2. SELF JOIN(자체 조인)

<p align="center">
    <img src="/src/resources/SELF_JOIN.png">
</p>

- 자기 자신과 조인하기 때문에 1개의 테이블을 사용한다.
- 테이블 1개로 조인하면 자체 조인이 된다.

```mysql
SELECT [컬럼 이름]
FROM [테이블 A 이름] AS t1
INNER JOIN [테이블 A 이름] AS t2
ON t1.[컬럼 A 이름] = t2.[컬럼 A 이름]
WHERE 조건식;
```

<p align="center">
    <img src="/src/resources/day08_selfjoin_table.png">
</p>

```mysql
SELECT *
FROM mypokemon AS t1
INNER JOIN mypokemon AS t2
ON t1.number = t2.number;
```

<p align="center">
    <img src="/src/resources/day08_selfjoin_result.png">
</p>
