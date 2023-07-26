use fastcampus;
select * from tbl_customer limit 5;
select * from tbl_purchase limit 5;
select * from tbl_visit limit 5;

/*
Q13
- 전체 유저의 Demographic을 알고 싶어요.
- 성·연령별로 유저 숫자를 알려주세요.
- 어느 세그먼트가 가장 숫자가 많나요?
- 참고로 기타 성별은 하나로, 연령은 5세 단위로 적당히 묶어주시고 숫자가 높은 순서대로 보여주세요.
*/
# 성별은 F, M, Others, 그리고 무응답으로 나누어진다.
select distinct gender
from tbl_customer;

# 최대 나이는 57세, 최소 나이는 12세
select max(age), min(age) from tbl_customer;

SELECT 
    CASE
        WHEN LENGTH(gender) < 1 THEN 'Others'
        ELSE gender
    END AS gender,
    CASE
        WHEN age IS NULL THEN '무응답'
        WHEN age <= 15 THEN '15세 이하'
        WHEN age <= 20 THEN '15-20세'
        WHEN age <= 25 THEN '21-25세'
        WHEN age <= 30 THEN '26-30세'
        WHEN age <= 35 THEN '31-35세'
        WHEN age <= 40 THEN '36-40세'
        WHEN age <= 45 THEN '41-45세'
        WHEN age <= 50 THEN '46-50세'
        WHEN age <= 55 THEN '51-55세'
        WHEN age <= 60 THEN '56-60세'
        WHEN age > 60 THEN '61세 이상'
    END AS age,
    COUNT(*) AS cnt
FROM
    tbl_customer
GROUP BY 1 , 2
ORDER BY 3 DESC;



/*
Q14
- Q13 결과의 성·연령을 성별(연령)(e.g., 남성(25-29세 이하))으로 통합해주시고,
  각 성·연령이 전체 고객에서 얼마나 차지하는지 분포(%)를 알려주세요.
- 분포가 높은 순서대로 알려주세요.
*/
select concat(case when gender = 'M' then '남성'
				   when gender = 'F' then '여성'
                   when gender = 'Others' then '기타'
                   when length(gender) < 1 then '기타'
                   end,
              '(',
              case when age is null then '무응답'
				   when age <= 15 then '15세 이하'
                   when age <= 20 then '15-20세'
                   when age <= 25 then '21-25세'
                   when age <= 30 then '26-30세'
                   when age <= 35 then '31-35세'
                   when age <= 40 then '36-40세'
                   when age <= 45 then '41-45세'
                   when age <= 50 then '46-50세'
                   when age <= 55 then '51-55세'
                   when age <= 60 then '56-60세'
                   when age > 60 then '61세 이상'
                   end,
			  ')') as gen_age,
              count(*) as count,
              round(count(*)/(select count(*) from tbl_customer)*100, 2) as per
from tbl_customer
group by 1
order by 2 desc;



/*
Q15
- 2020년 7월의 성별에 따라 구매 건수와, 총 Revenue를 구해주세요.
- 남녀 이외의 성별은 하나로 묶어주세요.
*/
SELECT 
    CASE
        WHEN LENGTH(b.gender) < 1 THEN 'Others'
        ELSE b.gender
    END AS gender,
    COUNT(*) AS count,
    SUM(price) AS revenue
FROM
    tbl_purchase a
        LEFT JOIN
    tbl_customer b ON a.customer_id = b.customer_id
WHERE
    a.purchased_at LIKE '2020-07-%'
GROUP BY 1;



/*
Q16
- 2020년 7월의 성별/연령대에 따라 구매 건수와, 총 Revenue를 구해주세요.
- 남녀 이외의 성별은 하나로 묶어주세요.
*/
SELECT 
    CASE
        WHEN LENGTH(b.gender) < 1 THEN 'Others'
        ELSE b.gender
    END AS gender,
    CASE
        WHEN b.age IS NULL THEN '무응답'
        WHEN b.age <= 15 THEN '0-15세'
        WHEN b.age <= 20 THEN '15-20세'
        WHEN b.age <= 25 THEN '21-25세'
        WHEN b.age <= 30 THEN '26-30세'
        WHEN b.age <= 35 THEN '31-35세'
        WHEN b.age <= 40 THEN '36-40세'
        WHEN b.age <= 45 THEN '41-45세'
        WHEN b.age <= 50 THEN '46-50세'
        WHEN b.age <= 55 THEN '51-55세'
        WHEN b.age <= 60 THEN '56-60세'
        WHEN b.age > 60 THEN '61세 이상'
    END AS age,
    COUNT(*) AS count,
    SUM(price) AS revenue
FROM
    tbl_purchase a
        LEFT JOIN
    tbl_customer b ON a.customer_id = b.customer_id
WHERE
    a.purchased_at LIKE '2020-07-%'
GROUP BY 1 , 2
ORDER BY 4 desc;



/*
Q17
- 2020년 7월 일별 매출의 전일 대비 증감폭, 증감률을 구해주세요.
*/
with tbl_revenue as (
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date,
	   sum(price) as revenue
from tbl_purchase
where purchased_at like '2020-07-%'
group by 1)
select *,
	   revenue - lag(revenue) over(order by d_date asc) as diff_revenue,
       round((revenue - lag(revenue) over(order by d_date asc)) / lag(revenue) over(order by d_date asc) * 100, 2) as percentage_change
from tbl_revenue;



/*
Q18
- 2020년 7월 일별로 많이 구매한 고객들한테 소정의 선물을 주려고 합니다.
- 7월에 일별로 구매 금액 기준으로 가장 많이 지출한 고객 Top3를 뽑아주세요.
*/
select *
from
(select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date,
	   customer_id,
       sum(price) as revenue,
       dense_rank() over (partition by date_format(purchased_at - interval 9 hour, '%Y-%m-%d') order by sum(price) desc) as rank_rev
from fastcampus.tbl_purchase
where purchased_at like '2020-07-%'
group by 1, 2) foo
where rank_rev < 4;