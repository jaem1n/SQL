SELECT C.*, COUNT(DISTINCT lead_manager_code), COUNT(DISTINCT senior_manager_code), COUNT(DISTINCT manager_code), COUNT(DISTINCT employee_code)
FROM Company C 
    JOIN Employee E ON C.company_code = E.company_code
GROUP BY C.company_code, C.Founder
ORDER BY C.company_code
;

SELECT company_code
     , founder
     , (SELECT COUNT(DISTINCT lead_manager_code)
        FROM Lead_Manager
        WHERE company_code = C.company_code)  -- total number of lead managers
     , (SELECT COUNT(DISTINCT senior_manager_code)
        FROM Senior_Manager
        WHERE company_code = C.company_code)  -- total number of senior managers
     , (SELECT COUNT(DISTINCT manager_code)
        FROM Manager
        WHERE company_code = C.company_code)  -- total number of managers
     , (SELECT COUNT(DISTINCT employee_code)
        FROM Employee
        WHERE company_code = C.company_code)   -- total number of employees
FROM Company C
ORDER BY company_code
;