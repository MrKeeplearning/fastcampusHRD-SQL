/*
 HackerRank - SQL Project Planning
 (https://www.hackerrank.com/challenges/sql-projects/problem)
 */

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