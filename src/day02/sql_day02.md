# Day02. 데이터베이스 다루기

## 1. 데이터 타입

### 숫자형 데이터 타입

- 정수형: TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT
- 실수형: FLOAT, DOUBLE

### 문자형 데이터 타입

- 문자형
  - CHAR(n): n을 1부터 255까지 지정 가능, 지정하지 않을 시 1 자동 입력, 고정 길이로 문자열 저장
  - VARCHAR(n): n을 1부터 65535까지 지정 가능, 지정하지 않을 시 사용 불가, 변동 길이로 문자열 저장
- 문자형(고정 길이)
  - TINYTEXT: 255바이트 문자열까지 표현 가능
  - TEXT: 65535바이트의 문자열까지 표현 가능
  - MEDIUMTEXT: 약 1,600백만 바이트의 문자열까지 표현 가능
  - LONGTEXT: 약 42억 바이트의 문자열까지 표현 가능
- 날짜형
  - DATE: 0000-00-00 형식, 날짜(연, 월, 일) 표현
  - DATETIME: 0000-00-00 00:00:00 형식, 날짜와 시간을 표현
  - TIME: -838:59:59 ~ -838:59:59, 시간 정보 표현
  - YEAR: 1901 ~ 2155, 연도 정보 표현

<br/>

## 2. 데이터 타입 간의 변환

- 숫자형, 문자형, 날짜형 데이터는 함수를 사용해서 서로 타입 변환이 가능하다.

```mysql
# 숫자를 문자로 변환
SELECT CAST(123 AS CHAR(5));

# 문자를 숫자로 변환
SELECT CONVERT('1004', INT);

# 문자를 날짜로 변환
SELECT DATE_FORMAT('20211225', '%Y-%m-%d')  # 2021-12-25
```

<br/>

## 3. 테이블 생성 및 변경 쿼리문

```mysql
# 데이터베이스 생성
CREATE DATABASE DB_NAME;

# 데이터베이스 목록 조회
SHOW DATABASES;

# 데이터베이스 사용
USE DB_NAME;

# 테이블 만들기
CREATE TABLE EX_TABLE (
    col_name1   datatype,
    col_name2   datatype
);

# 테이블 이름 변경
ALTER TABLE [init_name] RENAME [new_name];

# 새로운 column 추가하기
ALTER TABLE [테이블명] ADD COLUMN [컬럼 이름][데이터타입];

# 기존 column 타입 변경하기
ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명][새로운 데이터 타입];

# 기존 컬럼 이름과 타입 함께 변경하기
# 타입을 변경하지 않는다면 기존 타입을 입력하면 된다.
ALTER TABLE [테이블 이름]
CHANGE COLUMN [컬럼 이름][새로운 컬럼 이름][새로운 데이터 타입];

# 컬럼 지우기
ALTER TABLE [테이블 이름] DROP COLUMN [컬럼 이름];
```

<br/>

## 4. 테이블 지우기 쿼리문

```mysql
# 데이터베이스 지우기
DROP DATABASE [DB 이름];

# 테이블 지우기
DROP TABLE [테이블 이름];

# 테이블 값만 지우기
TRUNCATE TABLE [테이블 이름];
```

`IF EXISTS` 키워드 없이 존재하지 않는 데이터베이스/테이블을 삭제하려 한다면 ERROR가 발생하기 때문에 `IF EXISTS` 키워드를 사용해서 에러를 방지하자.

```mysql
DROP DATABASE IF EXISTS [데이터베이스 이름];

# IF EXISTS는 테이블 쿼리에도 동일하게 적용된다.
DROP TABLE IF EXISTS [테이블 이름];
```

<br/>

## 5. 데이터 삽입, 삭제, 수정하기

```mysql
# 컬럼이 3개인 테이블에 데이터 삽입
# 컬럼의 수와 삽입하려는 데이터의 개수는 동일해야 한다.
INSERT INTO [테이블명] ([컬럼1 이름], [컬럼2 이름], [컬럼3 이름])
VALUES ([컬럼1 값], [컬럼2 값], [컬럼3 값]);

# 여러 row의 데이터를 삽입하기
INSERT INTO [테이블명] ([컬럼1 이름], [컬럼2 이름], [컬럼3 이름])
VALUES ([컬럼1 값], [컬럼2 값], [컬럼3 값]),
       ([컬럼1 값], [컬럼2 값], [컬럼3 값]),
       ([컬럼1 값], [컬럼2 값], [컬럼3 값]);

# 데이터 삭제하기
DELETE FROM [테이블 이름] WHERE [조건 값];

# 데이터 수정하기
UPDATE [테이블 이름]
SET [컬럼 이름] = [새 값]
WHERE [조건 값];
```