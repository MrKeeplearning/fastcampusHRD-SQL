# 프로덕트 분석 심화

use fastcampus;
select * from tbl_customer limit 5;
select * from tbl_purchase limit 5;
select * from tbl_visit limit 5;


/*
Q19
- 2020년 7월에 신규유저가 하루 안에 결제로 넘어가는 비율이 어떻게 되나요?
- 그 비율이 어떤지 알고 싶고, 결제까지 보통 몇 분 정도가 소요되는지 알고 싶어요.
*/
with rt_tbl as (
	select A.customer_id,
		   A.created_at,
		   B.customer_id as paying_user,
		   B.purchased_at,
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



/*
Q20
- 우리 서비스는 유저의 재방문율이 높은 서비스인가요?
- 이를 파악하기 위해 7월 기준 Day1 Retention이 어떤지 구하고, 추세를 보기 위해 Daily로 추출해주세요.
*/
select date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') as d_date,
	   count(distinct A.customer_id) as active_user,
       count(distinct B.customer_id) as retained_user,
       count(distinct B.customer_id) / count(distinct A.customer_id) as retention

# A테이블은 당일, B테이블은 다음 날이라고 간주한다. 당일과 다음날을 당일 기준으로 맵핑.
from fastcampus.tbl_visit A
left join fastcampus.tbl_visit B
on A.customer_id = B.customer_id
and date_format(A.visited_at - interval 9 hour, '%Y-%m-%d') = date_format(B.visited_at - interval 9 hour - interval 1 day, '%Y-%m-%d')

where A.visited_at >= '2020-07-01'
  and A.visited_at < '2020-08-01'

group by 1;



/*
Q21
- 우리 서비스는 신규 유저가 많나요? 기존 유저가 많나요?
- 유저들이 가입한 기간별로 그룹지어 고객 분포가 어떤지 알려주세요. DAU 기준으로 부탁합니다.
*/
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