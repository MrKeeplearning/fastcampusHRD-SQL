# Day 03. 데이터 가져오기

## 1. 테이블에서 데이터 가져오기

### SELECT

- 값을 가져올 컬럼을 선택한다.

### FROM

- 데이터를 가져올 테이블을 지정하는 키워드
- 테이블이 어떤 데이터베이스 안에 있는지 데이터베이스 이름도 같이 명시해야 한다.
  - `USE` 키워드를 통해서 사용할 데이터베이스를 지정해주었다면 생략 가능하다.

```mysql
# 컬럼을 하나만 선택하는 경우
SELECT [컬럼 이름]
FROM [데이터베이스 이름].[테이블 이름];

# 컬럼을 여러 개 선택하는 경우
SELECT [컬럼 이름], [컬럼 이름], ..., [컬럼 이름]
FROM [데이터베이스 이름].[테이블 이름];
```

<br/>

## 2. 별명 붙이기(ALIAS)

- `AS [컬럼 별명]` 형식으로 사용
- 테이블 내의 실제 컬럼 이름은 변하지 않고, 별명은 쿼리 내에서만 유효
  - 실제 컬럼 이름을 변경하고 싶다면 `ALTER TABLE` 구문을 사용해야 한다.

```mysql
SELECT [컬럼 이름] AS [컬럼 별명]
FROM [테이블 이름];
```

<br/>

## 3. 데이터 일부만 가져오기 (LIMIT)

- 가져올 데이터의 로우 개수를 지정하는 키워드
- 데이터의 일부만 확인하고 싶을 때 사용
- `LIMIT [로우 수]` 형식으로 사용
- 쿼리의 가장 마지막에 위치
- 만약 입력한 숫자가 전체 row 수보다 크다면, 현재 최대 row까지만 가져온다.

<p align="center">
  <img src="/src/resources/day03_limit.png" width="500">
</p>

```mysql
# 빨간색 박스 안의 데이터만 가져오기
SELECT number, name
FROM pokemon.mypokemon
LIMIT 2;
```

<br/>

## 4. 중복 제거하기(DISTINCT)

- 중복된 데이터는 제거하고 같은 값은 한 번만 가져오는 키워드
- 컬럼에 어떤 값이 있는지 확인하고 싶을 때 사용한다.
- `DISTINCT [컬럼 이름]` 형식으로 사용
- SELECT 절에 위치해서 컬럼의 유일한 값들을 가져온다.

<p align="center">
  <img src="/src/resources/day03_distinct.png" width="500">
</p>

- 위의 테이블에서 `type` 컬럼에는 `electric` 이라는 value가 중복된다.
- 이 때 `DISTINCT` 키워드를 사용하면 다음과 같이 유일한 값만 출력된다.

```mysql
select distinct type from pokemon.mypokemon;
```

<p align="center">
  <img src="/src/resources/day03_distinct2.png">
</p>
