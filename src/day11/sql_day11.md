# Day11. 알아두면 좋은 고급 기능

# 1. 제약 조건

- 데이터를 입력할 때 실행되는 데이터 입력 규칙
- 테이블을 만들거나 변경하면서 설정한다(`create table`, `alter table`).

|  **제약 조건**  |                      **의미**                      |
|:-----------:|:------------------------------------------------:|
|  NOT NULL   |             현재 컬럼에 NULL값을 저장할 수 없다.              |
|   UNIQUE    |           현재 컬럼의 값들은 서로 다른 값을 가져야 한다.            |
|   DEFAULT   |           현재 컬럼에 입력값이 없을 시 기본값이 설정된다.            |
| PRIMARY KEY | 현재 컬럼은 테이블의 기본키이다. NOT NULL과 UNIQUE의 특징을 모두 가진다. |
| FOREIGN KEY | 현재 컬럼은 테이블의 외래 키이다. 현재 컬럼은 다른 테이블의 특정 컬럼을 참조한다.  |

- `FOREIGN KEY`는 참조하는 테이블의 `PRIMARY KEY`여야 한다.

```mysql
# 제약 조건을 적용한 쿼리 예시
CREATE TABLE new_mypokemon
(
    number  int primary key,
    name    varchar(20) unique,
    type    varchar(10) not null,
    attack  int default 0,
    defense int default 100,
    foreign key (number) references mypokemon (number);
)
```

<br/>

# 2. 권한과 DCL

## 2.1. SQL 분류

- DDL(Data Definition Language, 데이터 정의어)
  - CREATE, ALTER, DROP, RENAME, TRUNCATE
- DML(Data Manipulation Language, 데이터 조작어)
  - SELECT, INSERT, UPDATE, DELETE
- DCL(Data Control Language, 데이터 제어어)
  - GRANT, REVOKE
- TCL(Transaction Control Language, 트랜잭션 제어어)
  - COMMIT, ROLLBACK, SAVEPOINT

## 2.2. 사용자 확인하기

```mysql
# MySQL 기본 데이터베이스인 mysql 데이터베이스 선택하기
USE mysql;

# 사용자 목록 조회하기
SELECT user, host FROM user;
```

## 2.3. 사용자 생성, 삭제하기

```mysql
# 사용자 생성하기
CREATE USER [사용자 이름]@[ip 주소];

# 비밀번호와 함께 사용자 생성하기
CREATE USER [사용자 이름]@[ip주소] IDENTIFIED BY `[사용자 비밀번호]`;

# 사용자 삭제하기
DROP USER [사용자 이름];
```

## 2.4. 권한 부여하기

```mysql
# 권한 부여하기
GRANT [권한] ON [데이터베이스 이름].[테이블 이름] TO [사용자 이름]@[ip주소];

# 권한 확인하기
SHOW GRANTS FOR [사용자 이름]@[ip주소];

# 권한 삭제하기
REVOKE [권한] ON [데이터베이스 이름].[테이블 이름] FROM [사용자 이름]@[ip주소];

# 권한 적용하기
FLUSH PRIVILEGES;
```

```mysql
# newuser@%에게 mydb.mytb에 대한 모든 권한 부여하기
# ip주소가 %이면 해당 아이디를 가지는 모든 ip에서의 접근을 허용한다는 뜻
GRANT ALL PRIVILEGES ON mydb.mytb TO newuser@%;

# newuser@%에게 모든 데이터베이스, 모든 테이블에 대한 select, insert 권한 부여하기
GRANT SELECT, INSERT ON *.* TO newuser@%;
```

<br/>

# 3. 트랜잭션과 TCL

- 트랜잭션은 데이터베이스의 상태를 바꾸는 작업의 묶음을 뜻한다.
- 트랜잭션이 시작하고 쿼리를 실행한 뒤 트랜잭션 결과를 확정 짓거나 트랜잭션 이전으로 돌아가는 일련의 작업 묶음을 말한다.

```mysql
# 트랜잭션 시작하기
START TRANSACTION; 

# 트랜잭션 확정하기
COMMIT;

# 트랜잭션 이전으로 돌아가기
ROLLBACK;

# 트랜잭션 내 특정한 저장 지점인 세이브포인트를 생성하기
SAVEPOINT [세이브포인트 이름];

# 세이브포인트로 돌아가기
ROLLBACK TO [세이브포인트 이름];
```