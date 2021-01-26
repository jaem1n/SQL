SELECT MIN(doctor), MIN(professor), MIN(singer), MIN(actor)    
FROM (SELECT CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END doctor
           , CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END professor
           , CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END singer
           , CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END actor
           , ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) row_no  -- 직업(컬럼)별 알파벳순 정렬을 위해 
      FROM OCCUPATIONS) O
GROUP BY row_no
ORDER BY row_no
;