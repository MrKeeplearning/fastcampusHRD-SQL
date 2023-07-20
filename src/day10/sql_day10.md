# Day10. 조건에 조건 더하기

# 1. 서브 쿼리

- 하나의 쿼리 내에 포함된 또 하나의 쿼리
- 서브 쿼리는 반드시 괄호 안에 있어야 한다.
- `select`, `from`, `where`, `having`, `order by` 절에 사용 가능하다.
- `insert`, `delete`, `update`문에도 사용 가능하다.
- 서브쿼리에는 세미 콜론을 붙히지 않아도 괜찮다.

<br/>

# 2. SELECT절의 서브 쿼리

- **스칼라 서브쿼리**라고도 한다.
- SELECT절의 서브 쿼리는 반드시 결과값이 하나의 값이어야 한다.
  - 하나의 컬럼이 나와야 한다는 뜻

```mysql
select [컬럼 이름],
    (select [컬럼 이름]
     from [테이블 이름]
     where 조건식)
from [테이블 이름]
where 조건식;
```

<p align="center">
  <img src="/src/resources/day10_select_subquery_table.png" width="700">
</p>

위와 같이 pokemon 데이터베이스가 있을 때 피카츄의 번호, 영문 이름, 키를 가져오는 SQL문은 다음과 같이 작성할 수 있다.

```mysql
# 서브쿼리를 사용하는 방법
select number, name,
       (select height from ability where number = 25) as height
from mypokemon
where number = 25;

# inner join을 사용하는 방법
select mypokemon.number, name, height
from mypokemon
       inner join ability on mypokemon.number = ability.number
where mypokemon.number = 25;
```

<br/>

# 3. FROM절의 서브 쿼리

- **인라인 뷰 서브쿼리**라고도 한다.
- FROM절의 서브 쿼리는 반드시 결과값이 하나의 테이블이어야 한다.
- 서브 쿼리로 만든 테이블은 반드시 별명을 가져야 한다.

```mysql
select [컬럼 이름]
from (select [컬럼 이름]
      from [테이블 이름]
      where 조건식) as [테이블 별명]
where 조건식;
```

<p align="center">
  <img src="/src/resources/day10_select_subquery_table.png" width="700">
</p>

```mysql
# 서브쿼리를 사용해서 키 순위가 3순위인 포켓몬의 번호와 키 순위를 가져온다.
select number, height_rank
from (select number,
      dense_rank() over (order by height desc) as height_rank
      from ability) as a
where height_rank = 3;
```

<br/>

# 4. WHERE절의 서브 쿼리

- **중첩 서브쿼리**라고도 한다.
- WHERE절의 서브 쿼리는 반드시 결과값이 하나의 컬럼이어야 한다(`EXISTS` 제외)
  - 하나의 컬럼에는 여러 개의 값이 존재할 수 있다.
- 연산자와 함께 사용
  - 보통 `WHERE [컬럼 이름] [연산자] [서브 쿼리]`형식으로 사용

```mysql
SELECT [컬럼 이름]
FROM [테이블 이름]
WHERE [컬럼 이름][연산자] (SELECT [컬럼 이름]
                         FROM [테이블 이름]
                         WHERE 조건식);
```

## 비교 연산자

- 비교 연산자만 사용할 때 WHERE절의 서브 쿼리는 반드시 결과값이 하나의 값이어야 한다.
- 비교연산자: `=`, `!=`, `>`, `>=`, `<`, `<=`

## 주요 연산자

- 주요 연산자 사용 시, WHERE절의 서브 쿼리는 반드시 결과값이 하나의 컬럼이어야 한다.
- 단, `EXISTS`는 단독으로 사용하며 결과값이 여러 컬럼이어도 된다.

|       **연산자**       |           **의미**           |
|:-------------------:|:--------------------------:|
|    A IN([서브쿼리])     |   A가 [서브 쿼리]의 결과값 내에 있다.   |
|  A < ALL([서브 쿼리])   |  A가 모든 [서브 쿼리]의 결과값보다 작다.  |
|  A > ALL([서브 쿼리])   |  A가 모든 [서브 쿼리]의 결과값보다 크다   |
|  A < ANY([서브 쿼리])   | A가 [서브 쿼리]의 결과값보다 하나라도 작다. |
|  A > ANY([서브 쿼리])   | A가 [서브 쿼리]의 결과값보다 하나라도 크다. |
|   EXISTS([서브 쿼리])   |    [서브 쿼리]의 결과값이 존재한다.     |
| NOT EXISTS([서브 쿼리]) |  [서브 쿼리]의 결과값이 존재하지 않는다.   |

### ANY 사용법

- < (작다)와 사용: [서브 쿼리]의 최댓값보다 작은 지 확인하는 연산자
- \> (크다)와 사용: [서브 쿼리]의 최솟값보다 큰 지 확인하는 연산자

### EXISTS 사용법

- EXISTS는 값이 있는 지 확인할 때 사용하는 연산자로 True 또는 False를 반환한다.
- True일 때는 서브 쿼리에 해당하는 결과를 출력하고 False일 때는 아무 것도 출력하지 않는다.