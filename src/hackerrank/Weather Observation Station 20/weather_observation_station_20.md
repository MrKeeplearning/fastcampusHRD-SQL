# Weather Observation Station 20

[문제 바로가기](https://www.hackerrank.com/challenges/weather-observation-station-20/problem)

```mysql
with ordering as (
	select LAT_N,
		   row_number() over(order by LAT_N) as LAT_N_ORDER
	from STATION
)

select round(avg(LAT_N), 4)
from ordering
where LAT_N_ORDER = (select floor(avg(LAT_N_ORDER)) from ordering)
   or LAT_N_ORDER = (select ceil(avg(LAT_N_ORDER)) from ordering)
```

- median, 즉 중간값을 알기 위해서는 대상이 되는 컬럼인 LAT_N의 value를 내림차순 혹은 오름차순으로 정렬한 뒤 중간에 해당하는 값을 찾아야 한다.
- 이 때 중간값을 찾기 위해서 인덱스 역할을 할 수 있도록 `row_number()`를 사용해서 랭킹을 매긴다. `row_number()`는 같은 값이 있어도 상관없이 순서대로 랭크 번호를 부여한다.
- 전체 로우가 홀수 개라면 정확히 중간에 해당하는 값을 구할 수 있지만, 짝수 개일 때는 정확히 중간에 해당되는 값을 구할 수 없다. 따라서 반으로 나눈 값에서 내림과 올림에 해당되는 값을 찾아(where절 내용) median을 구한다.