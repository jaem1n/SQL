SELECT Start_Date, End_Date
FROM (SELECT Start_Date, ROW_NUMBER() OVER (ORDER BY Start_Date) row_no    -- 두 테이블의 조인 키로 사용하기 위해 row_number를 만듦 
      FROM Projects 
      WHERE Start_Date NOT IN (SELECT End_Date 
                               FROM Projects)) S
    INNER JOIN (SELECT End_Date, ROW_NUMBER() OVER (ORDER BY End_Date) row_no 
                FROM Projects 
                WHERE End_Date NOT IN (SELECT Start_Date 
                                       FROM Projects)) E 
    ON S.row_no = E.row_no
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date
;