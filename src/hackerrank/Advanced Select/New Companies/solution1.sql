select A.company_code as company_code,
       A.founder as founder_name,
       (select count(distinct lead_manager_code) from Lead_Manager where company_code = A.company_code) as lead_managers_count,
       (select count(distinct senior_manager_code) from Senior_Manager where company_code = A.company_code) as senior_managers_count,
       (select count(distinct manager_code) from Manager where company_code = A.company_code) as managers_count,
       (select count(distinct employee_code) from Employee where company_code = A.company_code) as employees_count
from Company A
order by company_code;