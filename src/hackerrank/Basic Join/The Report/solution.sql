/*
 HackerRank - The Report (https://www.hackerrank.com/challenges/the-report/problem)
 */

select case when G.grade < 8 then NULL
            else S.name
           end as name,
       G.grade as grade,
       S.marks as marks
from Students S join Grades G
                     on S.marks >= G.min_mark and S.marks <= G.max_mark
order by grade desc, name asc, marks asc;
