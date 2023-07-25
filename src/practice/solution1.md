# Day13. 서비스 이해 기본

## Q1. 2020년 7월의 총 Revenue를 구해주세요.

```mysql
select sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at like '2020-07-%';
```

## Q2. 2020년 7월의 MAU를 구해주세요.

- MAU: 월 활성 유저 수
- Active에 대한 정의는 서비스나 산업에 따라서 다를 수 있다. 여기에서는 방문기록이 담긴 `tbl_visit`테이블에서 방문을 한 번이라도 하면 active 유저로 여기는 것으로 한다.
- 일반적으로는 앱이나 웹을 방문한 기록을 바탕으로 액티브 유저를 판별한다.

```mysql
 # 방법1
select count(distinct customer_id) as JUL_MAU
from fastcampus.tbl_visit
where visited_at >= '2020-07-01' and visited_at < '2020-08-01';

# 방법2
select count(distinct customer_id) as JUL_MAU
from fastcampus.tbl_visit
where visited_at like '2020-07%'; 
```

- `distinct`를 select 문에서 사용하지 않게 되면 `select count(customer_id)`는 7월에 방문한 모든 유저들의 방문 횟수를 구하게 되는 것이다.
- MAU를 구한다는 것은 총 방문횟수가 아니라 active user의 수를 구하는 것이기 때문에 `distinct`를 명시해주고 조회해야 한다.
- `count(*)`는 전체 row의 수를 구하게 된다.
- `count(customer_id)`는 null값을 제외한 `customer_id` 컬럼에 값이 있는 row의 수를 구한다.

## Q3. 2020년 7월에 우리 Active 유저의 구매율(Paying Rate)은 어떻게 되나요?

- 구매율: 구매유저 수 / 전체 활성유저 수
- Active 유저가 100명 있다면 그 중에서 몇 명이 구매를 한 유저인지 알고 싶은 것이다.

## Q4. 2020년 7월에 구매 유저의 월 평균 구매금액은 어떻게 되나요?

- 객단가(ARPPU): Average Revenue per Paying User

```mysql
select round(avg(revenue), 2) as JUL_ARPPU
from (select customer_id, sum(price) as revenue
      from fastcampus.tbl_purchase
      where purchased_at like '2020-07-%'
      group by 1) foo;
```

## Q5. 7월에 가장 많이 구매한 고객 Top3와 Top10~15 고객을 뽑아주세요.

```mysql
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
```

- `offset`키워드를 사용하면 offset 뒤에 있는 수 만큼을 건너뛰고 시작한다.
- 위에서 `limit 6 offset 9` 라는 제약조건을 걸어두었기 때문에 1번부터 9번까지의 row는 건너뛰고 10번부터 15번까지의 row를 가져오게 된다.