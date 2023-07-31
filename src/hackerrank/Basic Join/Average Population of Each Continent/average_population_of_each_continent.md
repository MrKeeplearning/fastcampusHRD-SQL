# Average Population of Each Continent

[문제 바로 가기](https://www.hackerrank.com/challenges/average-population-of-each-continent/problem)

```mysql
select B.continent,
       floor(avg(A.population))
from CITY A join COUNTRY B
on A.countrycode = B.code
group by 1;
```