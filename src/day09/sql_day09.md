# Day09. 여러 테이블을 한 번에 다루기

# 1. UNION과 UNION ALL

- `[쿼리 A] UNION [쿼리 B]` 또는 `[쿼리 A] UNION ALL [쿼리 B]` 형식으로 사용
- 쿼리 A와 쿼리 B의 결과 값을 합쳐서 보여준다.
- UNION은 동일한 값은 제외하고 보여주고, UNION ALL은 동일한 값도 포함해서 보여준다.
- 쿼리 A와 쿼리 B의 결과값의 개수가 같지 않으면 에러가 발생한다.
- `ORDER BY`는 쿼리 가장 마지막에 작성 가능하고 쿼리 A에서 가져온 컬럼으로만 가능하다.

```mysql
SELECT [컬럼 이름]
FROM [테이블 A 이름]
UNION   # UNION ALL을 사용하려면 현재 위치에 UNION 대신 UNION ALL을 입력
SELECT [컬럼 이름]
FROM [테이블 B 이름];
```

<br/>

# 2. 데이터에서 데이터 빼기

- MySQL에는 교집합(INTERSECT)과 차집합(MINUS)을 나타낼 수 있는 표현이 존재하지 않는다.
- 따라서 JOIN을 활용해서 이 두 가지 상태를 나타낸다.

## 2.1. 교집합(INTERSECT)

```mysql
SELECT [컬럼 이름]
FROM [테이블 A 이름] AS A
INNER JOIN [테이블 B 이름] AS B
ON A.[컬럼1 이름] = B.[컬럼1 이름] AND ... AND A.[컬럼n 이름] = B.[컬럼n 이름];
```

- 단순 inner join과 달리, 교집합을 확인하고 싶은 컬럼은 `ON`에서 모두 다 기준으로 두고 합쳐야 한다.

<p align="center">
    <img src="/src/resources/day09_intersect_db.png" width="500">
</p>

```mysql
select a.name
from mypokemon as a
inner join friendpokemon as b
on a.name = b.name and a.number = b.number and
   a.type = b.type and a.attack = b.attack and a.defense = b.defense; 
```

<p align="center">
    <img src="/src/resources/day09_intersect_result.png">
</p>

- 위와 같이 pokemon 데이터베이스에 2개의 테이블이 존재할 때 모든 컬럼을 JOIN의 기준으로 잡아서 교집합을 찾게 되면, select 절에 입력한 name 칼럼이 빈 상태로 출력된다.
- 왜냐하면 raichu는 동일하게 존재하지만 attack과 defense의 값이 두 테이블에서 다르기 때문이다.

<br/>

## 2.2. 차집합(MINUS)

- 차집합은 LEFT JOIN 또는 RIGHT JOIN으로 표현하는 것이 가능하다.
- LEFT JOIN 또는 RIGHT JOIN 사용 후에 WHERE 절을 사용해서 다른 테이블의 컬럼의 값이 NULL인 것만 가져오도록 처리한다. 이것이 에서 B에 해당하는 것을 뺀다는 의미이다.
- 교집합과 마찬가지로 확인하고 싶은 컬럼은 모두 다 `ON`절에서 기준으로 두고 합쳐 주어야 한다.

```mysql
SELECT [컬럼 이름]
FROM [테이블 A 이름] AS A
LEFT JOIN [테이블 B 이름] AS B
ON A.[컬럼1 이름] = B.[컬럼1 이름] AND ... AND A.[컬럼 N 이름] = B.[컬럼 N 이름]
WHERE B.[컬럼 이름] IS NULL;
```