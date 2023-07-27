# Day16. 프로덕트 분석 심화

## Q19

- **2020년 7월에 신규유저가 하루 안에 결제로 넘어가는 비율이 어떻게 되나요?**
- **그 비율이 어떤지 알고 싶고, 결제까지 보통 몇 분 정도가 소요되는지 알고 싶어요.**
- 신규 유저의 결제 전환율(Paying Conversion within 1 day)을 구하는 문제이다. 신규 유저가 100명이라면 100명 중에서 몇 명이 결제로 넘어가는지 알아보는 것이다.
- 매출을 높이기 위해서는 결제율을 높여야 하는데 이 때 확인하는 지표이고, 실무에서 굉장히 자주 확인하는 지표이기도 하다.
- 신규 유저의 결제 전환율을 알아내기 위해서는 2가지를 알아야 한다. -> **1. 신규 유저의 가입일**, **2. 최초 구매일**
  - 가입일이 있고 구매일이 있는 고객은 결제를 한 고객이다.
  - 가입일은 존재하지만 결제테이블에는 없는 고객이라면 맵핑이 안 될 것이고, 결제를 한 번도 하지 않은 고객임을 알 수 있다.
  - 가입일과 최초구매일을 빼면 이 사이의 시간 간격을 가지고 지표에 활용할 수 있다.
- 결제를 하지 않은 고객의 정보도 필요하다. 왜냐하면 7월에 가입한 전체 신규 고객을 알아야 하기 때문이다. 따라서 일반적인 INNER JOIN이 아니라 가입일이 나타나는 tbl_customer를 기준으로 LEFT JOIN을 한다.

```mysql
select A.customer_id,
	   A.created_at,
       B.customer_id as paying_user,
       B.purchased_at

from fastcampus.tbl_customer A
left join (select customer_id, min(purchased_at) as purchased_at
		   from fastcampus.tbl_purchase
           group by 1) B

on A.customer_id = B.customer_id
and B.purchased_at < A.created_at + interval 1 day

where A.created_at >= '2020-07-01' and A.created_at < '2020-08-01';
```

<p align="center">
  <img src="/src/resources/day16_q19.png">
</p>

- 위의 쿼리문에서 on절에서 and 뒤에 나오는 `B.purchased_at < A.created_at + interval 1 day`는 계정을 생성한 날짜에서 하루가 지나기 전에 구매활동이 있었는지를 확인할 수 있도록 도와준다.
- 위의 결과 테이블에서 가입 후 구매까지 이어진 고객의 ID를 나타내는 `paying user`가 NULL인 경우가 있는데, NULL인 이유는 2가지로 생각해 볼 수 있다.
  - 첫째, 결제를 한 번도 하지 않은 고객이기 때문에 JOIN할 때 맵핑할 값이 없어 NULL이 뜨는 경우
  - 둘째, 결제를 했지만 가입 후 결제까지 하루 안에 이루어지지 않아서 맵핑이 되지 않은 경우

### 최종 결과

```mysql
with rt_tbl as (
	select A.customer_id,
		   A.created_at,
		   B.customer_id as paying_user,
		   B.purchased_at,
		   # 계정 생성과 첫 구입 사이의 시간을 초로 변환 후 시간 단위로 최종 변환
		   time_to_sec(timediff(B.purchased_at, A.created_at)) / 3600 as diff_hour

	from fastcampus.tbl_customer A
	left join (select customer_id, min(purchased_at) as purchased_at
			   from fastcampus.tbl_purchase
			   group by 1) B

	on A.customer_id = B.customer_id
	and B.purchased_at < A.created_at + interval 1 day

	where A.created_at >= '2020-07-01' and A.created_at < '2020-08-01'
)
# 26.45%가 하루 안에 가입에서 첫 결제까지 이루어진다.
select round(count(paying_user) / count(customer_id) * 100, 2) as paying_conversion_within_1day
from rt_tbl

union all

# 결제까지 14.15시간이 소요가 된다.
select round(avg(diff_hour),2)
from rt_tbl;
```

<p align="center">
  <img src="/src/resources/day16_q19_2.png">
</p>

<br/>

## Q20.
- **우리 서비스는 유저의 재방문율이 높은 서비스인가요?**
- **이를 파악하기 위해 7월 기준 Day1 Retention이 어떤지 구하고, 추세를 보기 위해 Daily로 추출해주세요.**
- Retention은 시간이 지날수록 얼마나 많은 유저가 제품이나 서비스로 다시 돌아오는지 측정하는 지표이다. 쉽게 말해 재방문율이라고 볼 수 있다.
- N-day Retention에 대해서 예시를 들어보자.
  - 7월 1일을 기준으로 1 day retention을 확인하려면 7월 2일에 몇 명이 남아 있는지 확인하면 된다.
  - 7월 1일을 기준으로 7 day retention을 확인하려면 7월 8일에 몇 명이 남아 있는지 확인하면 된다.

### 최종 결과

```mysql
select customer_id, count(customer_id)
from tbl_visit
where visited_at like '2020-07-%'
group by 1;

select date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') as d_date,
	   count(distinct A.customer_id) as active_user,
       count(distinct B.customer_id) as retained_user,
       count(distinct B.customer_id) / count(distinct A.customer_id) as retention

# A테이블은 당일, B테이블은 다음 날이라고 간주한다. 당일과 다음날을 당일 기준으로 맵핑.
from fastcampus.tbl_visit A
left join fastcampus.tbl_visit B
on A.customer_id = B.customer_id
# 시간이 아니라 1 day 차이가 나면 다음 날 들어온 것으로 간주한다.
# 현재 포맷팅에서 시간은 표현하지 않기 때문에 '일'만 바뀌면 다음 날로 간주할 수 있다.
and date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') = date_format(B.visited_at - interval 9 hour - interval 1 day, '%Y-%m-%d')

where A.visited_at >= '2020-07-01'
  and A.visited_at < '2020-08-01'

group by 1;
```

<p align="center">
  <img src="/src/resources/day16_q20.png">
</p>

<br/>

## Q21

- **우리 서비스는 신규 유저가 많나요? 기존 유저가 많나요?**
- **유저들이 가입한 기간별로 그룹지어 고객 분포가 어떤지 알려주세요. DAU 기준으로 부탁합니다.**
- DAU를 서비스의 나이를 기준으로 분류한다. 1년 이상된 유저인지, 2년 이상된 유저인지 등 service age를 고려해야 한다.
- 전체 유저가 100명이고 2년 이상된 유저가 20명일 때 DAU는 20%가 되는 것처럼 service age를 기준으로 분류해야 한다.

### 접근 방법
- `tbl_visit` 테이블의 방문기록을 일자별로 계산.
- 각 일자별로 고객의 `last_visit`을 체크.
- 해당 고객의 계정 생성일자를 `tbl_customer`테이블에서 가져옴.
- `last_visit`에서 `created_at`을 빼면 특정 날짜의 고객의 service age를 알 수 있다.

### 최종 결과

```mysql
WITH tbl_visit_by_joined as (
	SELECT 
		DATE_FORMAT(A.visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS d_date,
		A.customer_id,
		B.created_at AS d_joined,
		MAX(A.visited_at) AS last_visit,
		DATEDIFF(MAX(A.visited_at), B.created_at) AS date_diff
	FROM
		fastcampus.tbl_visit A
			LEFT JOIN
		fastcampus.tbl_customer B ON A.customer_id = B.customer_id
	WHERE
		A.visited_at >= '2020-07-01'
			AND A.visited_at < '2020-08-01'
	GROUP BY 1 , 2 , 3
)

select A.d_date,
	   case when A.date_diff >= 730 then '2년 이상'
			when A.date_diff >= 365 then '1년 이상'
            when A.date_diff >= 183 then '6개월 이상'
            when A.date_diff >= 91 then '3개월 이상'
            when A.date_diff >= 30 then '1개월 이상'
            else '1개월 미만'
            end as segment,
	   B.all_users as all_users,
	   count(A.customer_id) as segment_users,
       round(count(A.customer_id) / B.all_users * 100, 2) as per
from tbl_visit_by_joined A
left join (select d_date,
				  count(customer_id) as all_users
		   from tbl_visit_by_joined
           group by 1) B
on A.d_date = B.d_date

group by 1, 2, 3
order by 1, 2;
```