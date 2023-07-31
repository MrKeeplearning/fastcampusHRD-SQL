# New Companies

[문제 바로 가기](https://www.hackerrank.com/challenges/the-company/problem)

## JOIN 없이 작성하는 방법

```mysql
select A.company_code as company_code,
       A.founder as founder_name,
       (select count(distinct lead_manager_code) from Lead_Manager where company_code = A.company_code) as lead_managers_count,
       (select count(distinct senior_manager_code) from Senior_Manager where company_code = A.company_code) as senior_managers_count,
       (select count(distinct manager_code) from Manager where company_code = A.company_code) as managers_count,
       (select count(distinct employee_code) from Employee where company_code = A.company_code) as employees_count
from Company A
order by company_code;
```

## JOIN을 활용해서 작성하는 방법

```mysql
SELECT
    c.company_code,
    c.founder,
    COUNT(DISTINCT e.lead_manager_code),
    COUNT(DISTINCT e.senior_manager_code),
    COUNT(DISTINCT e.manager_code),
    COUNT(DISTINCT e.employee_code)
FROM
    Company c
        JOIN
    Employee e ON (c.company_code = e.company_code)
GROUP BY c.company_code , c.founder
ORDER BY c.company_code;
```