use fastcampus;

select * from tbl_customer;
select * from tbl_purchase;
select * from tbl_visit;

select now();
select current_date();
select extract(month from '2023-07-24');
select day('2023-07-24');
select date_add('2023-07-24', interval 7 day);
select date_sub('2023-07-24', interval 7 day);
select datediff('2023-07-24', '2023-07-03');
select timediff('2023-07-24 17:47:00', '2023-07-24 17:30:00');
select date_format(now(), "%Y.%m.%d");

/*
Q6. 2020년 7월의 평균 DAU를 구해주세요. Active User 수가 추세 증가하는 추세인가요?
*/
SELECT 
    ROUND(AVG(users))
FROM
    (SELECT 
        DATE_FORMAT(visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		COUNT(DISTINCT customer_id) AS users
    FROM
        tbl_visit
    WHERE
        visited_at LIKE '2020-07%'
    GROUP BY 1
    ORDER BY 1) AS foo;


/*
Q7. 2020년 7월의 평균 WAU를 구해주세요.
*/
SELECT 
    ROUND(AVG(users), 2)
FROM
    (SELECT 
        DATE_FORMAT(visited_at - INTERVAL 9 HOUR, '%Y-%m week%U') AS date_at,
		COUNT(DISTINCT customer_id) AS users
    FROM
        tbl_visit
    WHERE
        visited_at >= '2020-07-05' AND visited_at < '2020-07-26'
    GROUP BY 1
    ORDER BY 1) foo;


/*
Q8. 2020년 7월의 Daily Revenue는 증가하는 추세인가요? 평균 Daily Revenue도 구해주세요.
*/
SELECT 
    DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
    SUM(price) AS daily_revenue
FROM
    tbl_purchase
WHERE
    purchased_at LIKE '2020-07-%'
GROUP BY 1
ORDER BY 1;

SELECT 
    ROUND(AVG(daily_revenue), 2)
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		SUM(price) AS daily_revenue
    FROM
        tbl_purchase
    WHERE
        purchased_at LIKE '2020-07-%'
    GROUP BY 1
    ORDER BY 1) AS foo;


/*
Q9. 2020년 7월의 평균 Weekly Revenue를 구해주세요.
*/
SELECT 
    ROUND(AVG(revenue))
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m week%U') AS date_at,
            SUM(price) AS revenue
    FROM
        tbl_purchase
    WHERE
        purchased_at >= '2020-07-05'
            AND purchased_at < '2020-07-26'
    GROUP BY 1) foo;


/*
Q10. 2020년 7월 요일별 Daily Revenue를 구해주세요. 어느 요일이 Revenue가 가장 높고 낮나요?
*/
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


/*
Q11. 2020년 7월 시간대별 시간당 Revenue를 구해주세요.
어느 시간대가 Revenue가 가장 높고 낮나요?
*/
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


/*
Q12. 2020년 7월 요일 및 시간대별 Revenue를 구해주세요.
어느 요일 및 시간대의 Revenue가 가장 높고 어느 시간대가 Revenue가 가장 낮나요?
*/
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
