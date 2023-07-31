select min(case when A.Occupation = 'Doctor' then A.Name else null end) as Doctor,
       min(case when A.Occupation = 'Professor' then A.Name else null end) as Professor,
       min(case when A.Occupation = 'Singer' then A.Name else null end) as Singer,
       min(case when A.Occupation = 'Actor' then A.Name else null end) as Actor
from (select Name,
             Occupation,
             rank() over(partition by Occupation order by Name asc) as name_order
      from OCCUPATIONS) A
group by A.name_order;