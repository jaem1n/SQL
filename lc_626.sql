-- COALESCE 사용
SELECT id, COALESCE(CASE WHEN MOD(id, 2) = 1 THEN LEAD(student) OVER(ORDER BY id) 
                    ELSE LAG(student) OVER (ORDER BY id) END, student) student
FROM seat
;

-- IFNULL 사용
SELECT id, IFNULL(CASE WHEN MOD(id, 2) = 1 THEN LEAD(student) OVER(ORDER BY id) 
                  ELSE LAG(student) OVER (ORDER BY id) END, student) student
FROM seat
;