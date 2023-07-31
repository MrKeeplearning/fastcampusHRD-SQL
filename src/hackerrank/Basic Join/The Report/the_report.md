# The Report

[문제 바로 가기](https://www.hackerrank.com/challenges/the-report/problem)

## 참고사항

- `JOIN ON` 관련
  - `JOIN`을 사용할 때 `ON`절에서 매핑되는 컬럼은 반드시 서로 `=`로 연결될 필요는 없다.
  - 특정 범위에 포함된다면 부등호를 사용해서 `ON`절을 작성해도 된다.
- `order by`관련
  - 가장 첫 번째로 `grade`는 내림차순으로 정렬되어야 한다.
  - 두 번째로 8~10등급 사이에서 같은 등급에 해당될 경우 이름을 기준으로 정렬을 한다고 했다. 알파벳 순에 따라서 정렬하기 때문에 `name asc`를 사용한다.
  - 세 번째로 고려해야 하는 것은 8등급 미만의 경우이다. `grade`를 기준으로 내림차순 정렬이 가장 우선적으로 진행되기 때문에 8등급 미만의 케이스들은 else에 해당되는 것들이라고 봐도 좋다.
  - 앞의 두 가지 조건에 해당되지 않을 경우 7등급 이하에서 같은 등급은 점수(`marks`)를 기준으로 정렬하는데 이 때 특이하게 오름차순 정렬을 한다. 하지만, 7등급 이하는 **이름이 없기 때문에** `name asc` 정렬은 고민하지 않아도 된다. 따라서 `marks asc`에 따라 같은 등급인 경우를 정렬한다.

## 최종 쿼리문

```mysql
select case when G.grade < 8 then NULL
            else S.name
            end as name,
       G.grade as grade,
       S.marks as marks
from Students S join Grades G
on S.marks >= G.min_mark and S.marks <= G.max_mark
order by grade desc, name asc, marks asc;
```