/*
 HackerRank - Placements
 (https://www.hackerrank.com/challenges/placements/problem)
 */

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