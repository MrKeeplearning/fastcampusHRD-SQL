# SQL Project Planning

[문제 바로 가기](https://www.hackerrank.com/challenges/sql-projects/problem)

## 아이디어

- 주어진 예시 자료에서 프로젝트의 시작일과 종료일을 살펴보면 시작일은 종료일 컬럼에 존재하지 않고, 종료일은 시작일 컬럼에 존재하지 않는다. 따라서, 이런 특징을 기반으로 시작일과 종료일을 먼저 추출해본다.

```mysql
# 시작일이 될 수 있는 값 찾기
select start_date
from projects
where start_date not in (select distinct end_date from projects);

# 종료일이 될 수 있는 값 찾기
select end_date
from projects
where end_date not in (select distinct start_date from projects);
```

- 결국 출력해야 하는 것은 프로젝트의 시작일과 종료일이기 때문에 위에서 구한 두 개의 컬럼 데이터를 JOIN한다.
- 그런데, 이 둘을 그냥 INNER JOIN하게 되면 시작일이 종료일보다 미래의 날짜가 되는 것처럼 말도 안되는 프로젝트 수행 기간이 출력된다.
- 따라서, 시작일은 종료일보다 앞선 날짜가 되어야 한다는 조건을 부여한다.

```mysql
select tbl_start.start_date,
       tbl_end.end_date
from (select start_date
      from projects
      where start_date not in (select distinct end_date from projects)) tbl_start

inner join (select end_date
            from projects
            where end_date not in (select distinct start_date from projects)) tbl_end
            
on tbl_start.start_date < tbl_end.end_date
order by 1, 2;
```

- 위와 같이 쿼리문을 작성하게 되면 이번에는 하나의 start_date에 여러 개의 end_date가 따라오는 것을 확인할 수 있다.

```
2015-10-01 2015-10-05
2015-10-01 2015-10-13
2015-10-01 2015-10-16
2015-10-01 2015-10-18
2015-10-01 2015-10-20
2015-10-01 2015-10-22
2015-10-01 2015-10-31
2015-10-01 2015-11-02
2015-10-01 2015-11-08
2015-10-01 2015-11-13
2015-10-01 2015-11-18
2015-10-11 2015-10-13
2015-10-11 2015-10-16
2015-10-11 2015-10-18
2015-10-11 2015-10-20
...
```

- 2015-10-01에 따라온 많은 end_date가 있는데 이 들은 모두 어떤 날짜의 end_date일 것이다.
- 2015-10-01의 end_date인지는 어떻게 판단할까? 2015-10-01을 기준으로 end_date의 min값을 찾으면 해당 값이 end_date이다. 왜냐하면 2015-10-05이 아닌 다른 값이 오면 end_date인 2015-10-05는 start_date로 2015-10-01 말고는 다른 선택지가 없기 때문이다.
- 따라서 start_date를 기준으로 end_date의 min값을 찾으면 해당 값이 end_date가 된다는 조건을 확인할 수 있다.

## 최종 쿼리문

```mysql
select tbl_start.start_date,
       min(tbl_end.end_date)

-- start date 찾기(start_date의 값 중 end_date에는 없는 값)
from (select start_date
      from projects
      where start_date not in (select distinct end_date from projects)) tbl_start

-- end date 찾기(end_date의 값 중 start_date에는 없는 값)
inner join (select end_date
            from projects
            where end_date not in (select distinct start_date from projects)) tbl_end

on tbl_start.start_date < tbl_end.end_date

group by tbl_start.start_date
order by (min(tbl_end.end_date) - tbl_start.start_date) asc, tbl_start.start_date asc;
```