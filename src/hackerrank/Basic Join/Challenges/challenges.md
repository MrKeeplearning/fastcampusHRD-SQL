# Challenges

[문제 바로 가기](https://www.hackerrank.com/challenges/challenges/problem)

```mysql
select main.hacker_id,
	   main.name,
       main.counts

from (select A.hacker_id,
             A.name,
             count(B.challenge_id) as counts
      from hackers A
      inner join challenges B
      on A.hacker_id = B.hacker_id
      group by 1, 2) main

# foo.counts가 max값일 때는 딱히 고려할 부분이 없다.
where main.counts = (select max(t1.cnt_challenge)
                     from (select hacker_id,
                                  count(challenge_id) as cnt_challenges
                           from challenges
                           group by hacker_id) t1)
# 생성한 챌린지의 수가 max 값은 아니지만 같은 값을 가지는 케이스가 여럿 있다면 해당 케이스는 고려하지 않는다.
or main.counts in (select t2.cnt_challenges
				   from (select hacker_id, count(challenge_id) as cnt_challenges from challenges group by hacker_id) t2
				   group by cnt_challenges
                   having count(*) < 2)

order by main.counts desc, main.hacker_id asc;
```