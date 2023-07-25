use fastcampus;
select * from tbl_customer;
select * from tbl_purchase;
select * from tbl_visit;

# Q1. 2020년 7월의 총 Revenue를 구해주세요.
select sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01' and purchased_at < '2020-08-01';
-- where purchased_at like '2020-07-%';


# Q2. 2020년 7월의 MAU를 구해주세요.
select count(distinct customer_id) as JUL_MAU, count(*), count(customer_id)
from fastcampus.tbl_visit
where visited_at like '2020-07%';


# Q3. 7월에 우리 Active 유저의 구매율(Paying Rate)은 어떻게 되나요?
use fastcampus;
select * from tbl_visit limit 5;

select
	(select count(distinct customer_id) from tbl_purchase where purchased_at like '2020-07%') as user_purchased,
    (select count(distinct customer_id) from tbl_visit where visited_at like '2020-07%') as active_user,
	round(user_purchased/active_user*100, 2) as july_paying_rate;
    
select count(distinct customer_id) from tbl_purchase where purchased_at like '2020-07%';
select count(distinct customer_id) from tbl_visit where visited_at like '2020-07%';

       
select count(distinct customer_id)
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01' and purchased_at < '2020-08-01';

select count(distinct customer_id)
from fastcampus.tbl_visit
where visited_at >= '2020-07-01' and visited_at < '2020-08-01';




with
	cte1 as (select count(distinct customer_id) from tbl_purchase where purchased_at like '2020-07%'),
    cte2 as (select count(distinct customer_id) from tbl_visit where visited_at like '2020-07%')
select cte1 / cte2;

with temp as
(
	select count(distinct customer_id) from tbl_purchase where purchased_at like '2020-07%' as user_purchased,
    select count(distinct customer_id) from tbl_visit where visited_at like '2020-07%' as active user
)

SELECT ... (생략) AS user_purchased, AS active_user
SELECT ROUND(user_purchased / active_user, 2) AS july_paying_rate FROM temp


# Q4. 7월에 구매 유저의 월 평균 구매금액은 어떻게 되나요?
select round(avg(revenue), 2) as JUL_ARPPU
from
(
	select customer_id, sum(price) as revenue
    from fastcampus.tbl_purchase
    where purchased_at like '2020-07-%'
    group by 1
) foo;


# Q5. 7월에 가장 많이 구매한 고객 Top3와 Top10~15 고객을 뽑아주세요.
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
