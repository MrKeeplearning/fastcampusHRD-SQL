# Day13. 서비스 이해 기본

use fastcampus;
select * from tbl_customer limit 5;
select * from tbl_purchase limit 5;
select * from tbl_visit limit 5;



/*
Q1. 2020년 7월의 총 Revenue를 구해주세요.
*/
select sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01' and purchased_at < '2020-08-01';
-- where purchased_at like '2020-07-%';



/*
Q2. 2020년 7월의 MAU를 구해주세요.
*/
select count(distinct customer_id) as JUL_MAU, count(*), count(customer_id)
from fastcampus.tbl_visit
where visited_at like '2020-07%';



/*
Q3. 7월에 우리 Active 유저의 구매율(Paying Rate)은 어떻게 되나요?
*/
# 2020년 7월 구매 유저 수 구하기
select count(distinct customer_id)
from fastcampus.tbl_purchase
where purchased_at like '2020-07-%';

# 2020년 7월 Active User 수 구하기
select count(distinct customer_id)
from tbl_visit
where visited_at like '2020-07-%';

# 2020년 7월의 Paying Rate구하기
WITH july_purchased AS (
	SELECT 
		COUNT(DISTINCT customer_id) AS purchased_user
	FROM
		fastcampus.tbl_purchase
	WHERE
		purchased_at LIKE '2020-07-%'
), july_active_user AS (
	SELECT 
		COUNT(DISTINCT customer_id) AS active_user
	FROM
		tbl_visit
	WHERE
		visited_at LIKE '2020-07-%'
)

SELECT 
    ROUND(july_purchased.purchased_user / july_active_user.active_user * 100, 2) AS paying_rate
FROM
    july_purchased,
    july_active_user;
    


/*
Q4. 7월에 구매 유저의 월 평균 구매금액은 어떻게 되나요?
*/
select round(avg(revenue), 2) as JUL_ARPPU
from
(
	select customer_id, sum(price) as revenue
    from fastcampus.tbl_purchase
    where purchased_at like '2020-07-%'
    group by 1
) foo;



/*
Q5. 7월에 가장 많이 구매한 고객 Top3와 Top10~15 고객을 뽑아주세요.
*/
# Top3 구하기
select customer_id, sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at like '2020-07-%'
group by 1
order by 2 desc
limit 3;

# Top 10 ~ 15 구하기 
select customer_id, sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at like '2020-07-%'
group by 1
order by 2 desc
limit 6 offset 9;
