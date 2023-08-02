# Placements

[문제 바로 가기](https://www.hackerrank.com/challenges/placements/problem)

## 아이디어

- inner join을 실행한 테이블1과 inner join을 실행한 테이블2를 다시 서로 inner join을 한 번 더 시키는 아이디어를 떠올려야 한다.
- on 절에서 `=` 뿐만 아니라 and를 사용해서 `<`로 조건을 부여해서 원하는 결과를 출력한다.

## 최종 쿼리문

```mysql
select A.name
from students A
inner join packages B
on A.id = B.id

inner join (select C.id as my_id,
				   C.friend_id,
                   D.salary as friend_salary
			from friends C
            inner join packages D
            on C.friend_id = D.id) E
on A.id = E.my_id
and B.salary < E.friend_salary
order by E.friend_salary;
```