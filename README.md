# fastcampusHRD-SQL

'패스트캠퍼스 SQL 데이터 분석 첫걸음' 학습 내용 정리

<br/>

## 1. SQL 기초

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

<br/>

## 2. 실무 문제 풀이

- [Day13. 서비스 이해 기본](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day13/solution1.md)
  - [SQL 파일 바로가기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day13/solution1.sql)
  - **Q1**: 7월의 총 Revenue구하기
  - **Q2**: 7월의 MAU 구하기
    - MAU를 구하는 것은 총 방문횟수가 아니라 active user의 수를 구하는 것이기 때문에 `distinct`를 활용해야 한다.
  - **Q3**: Active User의 구매율(Paying Rate)구하기
    - 구매율: 구매 유저 수 / 전체 활성 유저 수
  - **Q4**: 객단가(ARPPU, Average Revenue per Paying User) 계산하기
  - **Q5**: 가장 많이 구매한 고객 TOP3와 TOP10~15에 해당하는 고객 추출하기
    - `LIMIT`키워드와 함께 `OFFSET`을 사용하면 OFFSET 뒤에 있는 수만큼 건너뛰고 시작한다.
    - `LIMIT 6 OFFSET 9`이라는 제약조건이 있으면 10번째 ROW부터 시작을 하고 10번째부터 15번째 ROW만 가져온다.

- [Day14. 날짜와 시간별 분석](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day14/solution2.md)
  - [SQL 파일 바로가기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day14/solution2.sql)
  - 💡SELECT절에 집계함수가 있을 때는 집계함수를 제외한 나머지 컬럼에 대해서는 꼭 `GROUP BY` 절에 포함시키자.
  - **Q6**: 평균 DAU(Daily Active User) 구하기
    - `DATE_FORMAT([날짜 정보를 담은 컬럼명] - interval 9 hour, '%Y-%m-%d)`
    - 날짜 정보를 포맷팅할 때는 정확한 시간을 표현하기 위해서 기준이 되는 시간에서 9시간(KST와 UTC의 시간 차이)을 빼야 한다.
  - **Q7**: WAU(Weekly Active User) 구하기
    - Date Format 함수의 `%U`는 입력한 날짜가 해당 연도의 몇 번째 주인지 포맷팅하는 역할을 한다.
  - **Q8**: Daily Revenue 구하기
  - **Q9**: Weekly Revenue 구하기
  - **Q10**: 요일별 Daily Revenue구하기. `%w`와 `%W`의 차이.
  - **Q11**: 시간대별 시간당 Revenue를 구하기
  - **Q12**: 요일 및 시간대별 Revenue 구하기

- [Day15. 유저 세그먼트별 분석 & 매출 관련 추가 분석](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day15/solution3.md)
  - [SQL 파일 바로가기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day15/solution3.sql)
  - **Q13**
    - 성별, 연령별 유저 숫자를 확인하고 어떤 세그먼트에 가장 많이 분포하는지 찾아내기
    - null값을 처리하는 방법: `IS NULL`보다 `LENGTH([컬럼 이름]) < 1`를 사용하자.
  - **Q14**
    - 세그먼트별 분포도 확인하기
    - `concat()`함수로 컬럼 및 문자열을 연결하기
  - **Q15**: 집계함수를 활용해서 성별에 따른 구매 건수와 총 Revenue 구하기
  - **Q16**: 집계함수와 CASE-WHEN을 활용해서 성별과 연령대에 따른 구매 건수와 총 Revenue 구하기
  - **Q17**: 일별 매출의 전일 대비 증감폭과 증감률 구하기
    - WITH문을 사용해서 서브쿼리를 임시테이블처럼 사용
    - WINDOW함수 `LAG()`: 이전 행의 값 가져오기
    - WINDOW함수 `LEAD()`: 특정 위치의 행을 가져오기
  - **Q18**: 일별 구매 금액 기준 가장 많이 지출한 고객 TOP3 추출하기
    - `DENSE_RANK() OVER`를 활용해서 순위 매기기

- [Day16. 프로덕트 분석 심화](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day16/solution4.md)
  - [SQL 파일 바로가기](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/day16/solution4.sql)
  - **Q19**: 신규 유저의 결제 전환율(Paying Conversion within 1 day) 구하기
  - **Q20**: 서비스 재방문률(Day 1 Retention) 구하기
  - **Q21**: Service Age 확인하기. 충성 고객층이 얼마나 되는가?

<br/>

## 3. HackerRank 문제 풀이

- Day17. HackerRank 문제풀이 - Aggregation
  - [The Blunder](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Aggregation/The%20Blunder/the_blunder.md)
  - [Top Earners](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Aggregation/Top%20Earners/top_earners.md)
  - [Weather Observation Station 15](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Aggregation/Weather%20Observation%20Station%2015/solution.sql)
  - [Weather Observation Station 19](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Aggregation/Weather%20Observation%20Station%2019/solution.sql)
  - [Weather Observation Station 20](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Aggregation/Weather%20Observation%20Station%2020/weather_observation_station_20.md)

- Day18. HackerRank 문제풀이 - Advanced Select
  - [Type of Triangle](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Select/Type%20of%20Triangle/type_of_triangle.md)
  - [The PADS](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Select/The%20PADS/solution.sql)
  - [Occupations](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Select/Occupations/occupations.md)
  - [Binary Tree Nodes](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Select/Binary%20Tree%20Nodes/binary_tree_nodes.md)
  - [New Companies](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Select/New%20Companies/new_companies.md)

- Day19. HackerRank 문제풀이 - Basic Join
  - [Average Population of Each Continent](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Basic%20Join/Average%20Population%20of%20Each%20Continent/average_population_of_each_continent.md)
  - [The Report](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Basic%20Join/The%20Report/the_report.md)

- Day20. HackerRank 문제풀이 - Advanced Join
  - [Placements](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Join/Placements/placements.md)
  - [SQL Project Planning](https://github.com/MrKeeplearning/fastcampusHRD-SQL/blob/main/src/hackerrank/Advanced%20Join/SQL%20Project%20Planning/sql_project_planning.md)
