# fastcampusHRD-SQL

'패스트캠퍼스 SQL 데이터 분석 첫걸음' 학습 내용 정리

<br/>

- [Day02. 데이터베이스 다루기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day02/sql_day02.md)
  - 데이터 타입: 숫자형, 문자형, 날짜형
  - 데이터 타입 변환: `CAST`, `CONVERT`, `DATE_FORMAT`
  - 테이블 생성 및 변경 쿼리문: `CREATE`, `ALTER`
  - 테이블 지우기 쿼리문: `DROP`, `TRUNCATE`
  - 데이터 삽입, 삭제, 수정
    - `INSERT INTO VALUES`
    - `DELETE FROM WHERE`
    - `UPDATE SET WHERE`
  - [Day02 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day02/mission1.sql)
  - [Day02 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day02/mission2.sql)
  - [Day02 mission3](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day02/mission3.sql)
  - [Day02 mission4](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day02/mission4.sql)

- [Day03. 데이터 가져오기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day03/sql_day03.md)
  - `SELECT`, `FROM`
  - 별명 붙이기: `ALIAS`
  - 데이터 일부만 가져오기: `LIMIT`
  - 중복 제거: `DISTINCT`
  - [Day03 mission](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day03/day03_mission.sql)

- [Day04. 조건에 맞는 데이터 가져오기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day04/sql_day04.md)
  - `WHERE`, `BETWEEN`, `IN`
  - `LIKE`의 와일드카드
  - `IS NULL` `IS NOT NULL`
  - [Day04 mission](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day04/day04_mission.sql)

- [Day05. 원하는 데이터 만들기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day05/sql_day05.md)
  - 정렬: `ORDER BY`
  - 데이터 순위 만들기: `RANK() OVER()`, `DENSE_RANK() OVER()`, `ROW_NUMBER() OVER()`
  - 문자형 데이터를 다루는 함수
  - 숫자형 데이터를 다루는 함수
  - 날짜형 데이터를 다루는 함수
  - [Day05 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day05/day05_mission1.sql)
  - [Day05 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day05/day05_mission2.sql)

- [Day06. 데이터 그룹화하기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day06/sql_day06.md)
  - 데이터 그룹화: `GROUP BY`
  - 그룹에 조건을 주는 방법: `HAVING`
  - 다양한 그룹 함수 알아보기
    - `COUNT([컬럼 이름])`, `COUNT(*)`, `COUNT(1)`
    - `SUM`, `AVG`, `MIN`, `MAX`
  - 쿼리의 실행 순서
  - [Day06 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day06/day06_mission1.sql)
  - [Day06 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day06/day06_mission2.sql)

- [Day07. 규칙 만들기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day07/sql_day07.md)
  - 조건 만들기: `IF`, `IFNULL`
  - 여러 조건 한 번에 만들기: `CASE`
  - 함수 생성하기
  - [Day07 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day07/day07_mission1.sql)
  - [Day07 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day07/day07_mission2.sql)

- [Day08. 테이블 합치기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day08/sql_day08.md)
  - JOIN의 기본 설정 `INNER JOIN`
  - 한쪽을 기준으로 테이블 합치기
    - `LEFT OUTER JOIN`
    - `RIGHT OUTER JOIN`
    - `FULL OUTER JOIN`
  - `CROSS JOIN`, `SELF JOIN`
  - [Day08 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day08/day08_mission1.sql)
  - [Day08 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day08/day08_mission2.sql)

- [Day09. 여러 테이블을 한 번에 다루기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day09/sql_day09.md)
  - UNION과 UNION ALL
  - MySQL에서 교집합(INTERSECT)과 차집합(MINUS)을 표현하는 방법
  - [Day09 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day09/day09_mission1.sql)
  - [Day09 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day09/day09_mission2.sql)

- [Day10. 테이블 합치기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day10/sql_day10.md)
  - SELECT절에서 서브쿼리
  - FROM절에서 서브쿼리
  - WHERE절에서 서브쿼리
    - 비교연산자
    - 주요연산자: IN, ALL, ANY, EXISTS, NOT EXISTS
  - [Day10 mission1](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day10/day10_mission1.sql)
  - [Day10 mission2](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day10/day10_mission2.sql)

- [Day11. MySQL 고급 기능](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day11/sql_day11.md)
  - 제약 조건: NOT NULL, UNIQUE, DEFAULT, PRIMARY KEY, FOREIGN KEY
  - 데이터 제어어 DCL: GRANT, REVOKE
    - 사용자 확인하기
    - 사용자 생성 및 삭제하기
    - 권한 부여하기
  - 트랜잭션과 TCL: COMMIT, ROLLBACK, SAVEPOINT