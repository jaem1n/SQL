--  IF와 IN 사용
SELECT Request_at Day
     , ROUND(SUM(IF(Status != 'completed', 1, 0)) / COUNT(*), 2) 'Cancellation Rate'   -- 완료되지 않은 것은 모두 취소된 것이므로 조건을 !='completed'로 줌, 소수점 2자리까지 표기
FROM Trips
WHERE Client_Id IN (SELECT Users_Id
                    FROM Users
                    WHERE Banned = 'No' AND Role = 'client')
    AND Driver_Id IN (SELECT Users_Id
                      FROM Users
                      WHERE Banned = 'No' AND Role = 'driver')
    AND Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at
;

-- CASE와 JOIN 사용
SELECT Request_at Day
     , ROUND(SUM(CASE WHEN Status != 'completed' THEN 1 ELSE 0 END) / COUNT(*), 2) 'Cancellation Rate'
FROM Trips T
    INNER JOIN Users UC ON T.Client_Id = UC.Users_id     
    INNER JOIN Users UD ON T.Driver_Id = UD.Users_id  -- Users의 users_id를 client_id와 한 번, driver_id와 한 번 붙여야 함
WHERE UC.Banned = 'No' 
    AND UD.Banned = 'No'
    AND Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY Request_at
;