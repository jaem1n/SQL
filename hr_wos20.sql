SELECT ROUND(AVG(LAT_N), 4)    
FROM (SELECT LAT_N, ROW_NUMBER() OVER (ORDER BY LAT_N) row_no
      FROM STATION) S
   , (SELECT COUNT(*) n
      FROM STATION) T
WHERE CASE WHEN MOD(n, 2) = 1 
      THEN row_no = (n + 1) / 2 
      ELSE row_no IN (n / 2, (n + 1) / 2) 
      END
;