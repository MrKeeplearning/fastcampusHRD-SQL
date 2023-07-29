# The Blunder

[문제 바로가기](https://www.hackerrank.com/challenges/the-blunder/problem)

## CEIL 함수와 FLOOR 함수

- CEIL함수를 사용하면 인수로 전달받은 값과 같거나 반올림한 정수를 반환한다.
- `CEIL(10.1)`은 정수 11을 반환한다.
- FLOOR함수는 인수로 전달 받은 값과 같거나 내림한 정수를 반환한다.
- `FLOOR(11.003)`는 정수 11을 반환한다.

## REPLACE 함수

- `REPLACE('string', 'from_string', 'new_string')`의 형태를 가진다.
- string에는 원본 문자열이 들어가고 from_string에는 원본 문자열에서 교체 대상인 substring이 들어간다.
- new_string은 교체하게 될 문자열이 들어간다.

```mysql
SELECT REPLACE("SQL tutorial", "SQL", "HTML")

>>> HTML tutorial
```

## Solution

```mysql
select ceil(avg(salary) - avg(replace(salary, '0', '')))
from employees;
```