select B.continent,
       floor(avg(A.population))
from CITY A join COUNTRY B
                 on A.countrycode = B.code
group by 1;