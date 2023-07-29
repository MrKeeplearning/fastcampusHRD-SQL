# Top Earners

[문제 바로가기](https://www.hackerrank.com/challenges/earnings-of-employees/problem)

## Solution

```mysql
SELECT
    months * salary AS earnings, COUNT(*)
FROM
    Employee
WHERE
    months * salary = (SELECT MAX(months * salary) FROM Employee)
GROUP BY 1;
```