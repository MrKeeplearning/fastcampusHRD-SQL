# Day14. 날짜와 시간별 분석

## Q6. 2020년 7월 평균 DAU를 구해주세요. Active User 수가 추세 증가하는 추세인가요?

- DAU는 Daily Active User의 약자로, 일별로 active user가 몇 명인지 구하는 것이다.
- 항상 시간 정보를 다룰 때는 잘못된 정보가 나올 수도 있기 때문에 유의해야 한다. 아래의 쿼리문은 2020년 7월의 일별 방문객 수를 조회하는 것인데 이상하게 7월 1일의 방문객 수는 매우 낮고, 심지어 8월 1일에 해당하는 데이터가 담겨 있다.

```mysql
select date_format(visited_at, '%Y-%m-%d') as date_at, count(distinct customer_id)
from tbl_visit
where visited_at like '2020-07%'
group by 1;
```

<p align="center">
    <img src="/src/resources/day14_q6_1.png">
</p>

<p align="center">
    <img src="/src/resources/day14_q6_2.png">
</p>

- 이러한 결과가 나오는 이유는 시간까지 확인하면 알 수 있다.

```mysql
select *, date_format(visited_at, '%Y-%m-%d %T') as date_at
from tbl_visit
where visited_at like '2020-07%';
```

<p align="center">
    <img src="/src/resources/day14_q6_3.png">
</p>

- 위의 sql문을 실행한 결과를 살펴보면 원래 테이블에 있는 시간과 달리 formating을 한 컬럼은 9시간 정도가 더 추가된 것을 확인할 수 있다.
- 이러한 일들은 실무에서도 비일비재하게 발생한다. 포맷팅을 할 때 제대로 명시해주지 않는다면 한국표준시인 KST가 UTC로 바뀌는 일이 발생할 수 있고, 그래서 9시간의 차이가 나는 것이다.
- 위에서 발생한 문제를 해결하기 위해서 9시간을 `visited_at`에서 빼주면 된다.

```mysql
select date_format(visited_at - interval 9 hour, '%Y-%m-%d') as date_at, count(distinct customer_id)
from tbl_visit
where visited_at like '2020-07%'
group by 1
order by 1;
```

- 구해야 하는 것은 평균 DAU이기 때문에 위에서 다룬 쿼리문을 서브 쿼리로 빼서 새롭게 작성하면 된다.

```mysql
select avg(users)
from (select date_format(visited_at - interval 9 hour, '%Y-%m-%d') as date_at,
             count(distinct customer_id)                           as users
      from tbl_visit
      where visited_at like '2020-07%'
      group by 1
      order by 1) as foo;
```

<br/>

## Q7. 2020년 7월의 평균 WAU를 구해주세요.

- Date Format 함수의 `%U`는 입력한 날짜가 해당 연도의 몇 번째 주인지를 알려주는 역할을 한다.

```mysql
select date_format(visited_at - interval 9 hour, '%Y-%m week%U') as date_at,
       count(distinct customer_id)                               as users
from tbl_visit
where visited_at like '2020-07-%'
group by 1
order by 1;
```

<p align="center">
    <img src="/src/resources/day14_q7.png">
</p>

- 그런데 위와 같이 구하게 되면 문제가 있다. 7월의 어떤 주는 월요일부터 일요일까지 모두 포함하기도 하지만, 또 어떤 주는 모든 요일을 다 가지지 못하는 주가 있을 수도 있다. 이처럼 모든 요일이 포함되지 않은 주에서 추출한 WAU는 올바른 값이라고 하기 힘들다.
- 여기에서는 이러한 문제를 해결하기 위해서 모든 요일을 담고 있는 주에서만 데이터를 추출할 수 있도록 범위를 좁혀서 계산한다.
- 한 주의 시작을 일요일로 잡는다면, 7월 5일부터 7월 25일 사이에 있는 주는 모두 모든 요일을 가지고 있는 주이다.
- 최종적으로 구해야 하는 것은 7월의 WAU이기 때문에 결과적으로 아래와 같은 쿼리문을 작성할 수 있다.

```mysql
select round(avg(users), 2)
from (select date_format(visited_at - interval 9 hour, '%Y-%m week%U') as date_at,
             count(distinct customer_id)                               as users
      from tbl_visit
      where visited_at >= '2020-07-05'
        and visited_at < '2020-07-26'
      group by 1
      order by 1) foo;
```

<br/>

## Q8. 2020년 7월의 Daily Revenue는 증가하는 추세인가요? 평균 Daily Revenue도 구해주세요.

- 7월의 Daily Revenue는 아래와 같이 날짜 별 revenue를 구할 수 있다. 이렇게 나온 데이터를 기반으로 그래프를 그려본다면 증가 추세인지, 감소 추세인지 확인할 수 있다.

```mysql
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at,
       sum(price)                                              as daily_revenue
from tbl_purchase
where purchased_at like '2020-07-%'
group by 1
order by 1;
```

- 평균 Daily Revenue는 아래와 같이 구할 수 있다.

```mysql
select round(avg(daily_revenue), 2)
from (
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at,
	   sum(price) as daily_revenue
from tbl_purchase
where purchased_at like '2020-07-%'
group by 1
order by 1 ) as foo;
```

<br/>

## Q9. 2020년 7월의 평균 Weekly Revenue를 구해주세요.

```mysql
select round(avg(revenue))
from (select date_format(purchased_at - interval 9 hour, '%Y-%m week%U') as date_at,
             sum(price)                                                  as revenue
      from tbl_purchase
      where purchased_at >= '2020-07-05'
        and purchased_at < '2020-07-26'
      group by 1) foo;
```

<br/>

## Q10. 2020년 7월 요일별 Daily Revenue를 구해주세요. 어느 요일이 Revenue가 가장 높고 낮나요?

```mysql
# 7월의 요일 별 Daily Revenue
SELECT
    DATE_FORMAT(date_at, '%w') AS day_of_week,
    DATE_FORMAT(date_at, '%W') AS day_name,
    AVG(revenue) AS daily_revenue
FROM
    (SELECT
         DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
         SUM(price) AS revenue
     FROM
         tbl_purchase
     WHERE
         purchased_at LIKE '2020-07-%'
     GROUP BY 1) foo
GROUP BY 1 , 2
ORDER BY 1;
```

<p align="center">
    <img src="/src/resources/day14_q10_1.png">
</p>

```mysql
# 7월의 요일 별 Daily revenue를 금액에 따라서 정렬하여 최대값과 최솟값을 확인
# 월요일에 daily revenue가 가장 높고, 토요일이 가장 낮다.
SELECT 
    day_name, ROUND(daily_revenue)
FROM
    (SELECT 
        DATE_FORMAT(date_at, '%w') AS day_of_week,
		DATE_FORMAT(date_at, '%W') AS day_name,
		AVG(revenue) AS daily_revenue
    FROM
        (SELECT 
			DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
			SUM(price) AS revenue
		FROM
			tbl_purchase
		WHERE
			purchased_at LIKE '2020-07-%'
		GROUP BY 1) foo
    GROUP BY 1 , 2
    ORDER BY 1) AS maxmin
ORDER BY daily_revenue DESC;
```

<p align="center">
    <img src="/src/resources/day14_q10_2.png">
</p>

<br/>

## Q11. 2020년 7월 시간대별 시간당 Revenue를 구해주세요. 어느 시간대가 Revenue가 가장 높고 낮나요?

```mysql
SELECT 
    hour_at, AVG(revenue)
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at,
		SUM(price) AS revenue
    FROM
        tbl_purchase
    WHERE
        purchased_at LIKE '2020-07%'
    GROUP BY 1 , 2) foo
GROUP BY 1
ORDER BY 2 DESC;
```

<p align="center">
    <img src="/src/resources/day14_q11.png">
</p>

- 18시에 가장 높은 Revenue를 보여주고 있고, 6시에 가장 낮다.

<br/>

## Q12. 2020년 7월 요일 및 시간대별 Revenue를 구해주세요.

```mysql
SELECT
    day_of_week_at, hour_at, AVG(revenue)
FROM
    (SELECT
         DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
         DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%w') AS day_of_week_at,
         DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at,
         SUM(price) AS revenue
     FROM
         tbl_purchase
     GROUP BY 1 , 2 , 3) foo
GROUP BY 1 , 2
ORDER BY 3;
```

<p align="center">
    <img src="/src/resources/day14_q12.png">
</p>

- 토요일 6시가 가장 높은 Revenue를 보여주었다.
- 월요일 17시는 가장 낮은 Revenue를 보여주었다.
