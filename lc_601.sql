SELECT id, visit_date, people
FROM (SELECT *
           , LAG(people, 2) OVER (ORDER BY visit_date) lag_2  
           , LAG(people) OVER (ORDER BY visit_date) lag_1     
           , LEAD(people) OVER (ORDER BY visit_date) lead_1    
           , LEAD(people, 2) OVER (ORDER BY visit_date) lead_2
      FROM Stadium) S
WHERE (lag_2 >= 100 AND lag_1 >= 100 AND people >= 100)    -- 2일 전, 1일 전, 당일 모두 방문객 수 100 이상
   OR (lag_1 >= 100 AND people >= 100 AND lead_1 >= 100)   -- 1일 전, 당일, 1일 후
   OR (people >= 100 AND lead_1 >= 100 AND lead_2 >= 100)  -- 당일, 1일 후, 2일 후 
ORDER BY visit_date
;