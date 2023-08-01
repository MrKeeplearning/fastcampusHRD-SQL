/*
 HackerRank - Contest Leaderboard
 (https://www.hackerrank.com/challenges/contest-leaderboard/problem)
 */

SELECT
    A.hacker_id, A.name, SUM(max_score) AS total_score
FROM
    hackers A
        JOIN
    (SELECT
         hacker_id, challenge_id, MAX(score) AS max_score
     FROM
         submissions
     GROUP BY 1 , 2) B ON A.hacker_id = B.hacker_id
GROUP BY A.hacker_id , A.name
HAVING SUM(max_score) != 0
ORDER BY total_score DESC , A.hacker_id ASC;