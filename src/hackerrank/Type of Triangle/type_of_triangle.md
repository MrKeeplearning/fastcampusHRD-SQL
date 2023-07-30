# Type of Triangle

[문제 바로 가기](https://www.hackerrank.com/challenges/what-type-of-triangle/problem)

## 아이디어

- 삼각형의 성립 조건: 세 변의 길이가 있을 때 가장 긴 변의 길이는 다른 두 변의 길이의 합보다 작아야 삼각형이 될 수 있다.
- 따라서, 'Not a Triangle'이 성립하려면 두 변의 길이의 합보다 가장 긴 변의 길이가 더 길어야 한다.
- 다수의 조건을 고려해야 하기 때문에 `WHEN` 구문을 SELECT절에서 사용한다.

## 최종 쿼리문

```mysql
SELECT
	CASE
		WHEN (A = B AND A = C AND B = C) THEN 'Equilateral'
        WHEN ((A + B <= C) OR (A + C <= B) OR (B + C <= A)) THEN 'Not A Triangle'
        WHEN (A = B OR A = C OR B = C) THEN 'Isosceles'
        ELSE 'Scalene'
	END AS output
FROM TRIANGLES
```