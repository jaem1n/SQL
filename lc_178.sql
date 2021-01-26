SELECT Score, DENSE_RANK() OVER (ORDER BY Score DESC) 'Rank'
FROM Scores
;

SELECT S.Score, COUNT(SD.Score) 'Rank' 
FROM Scores S, (SELECT DISTINCT Score 
                FROM Scores) SD
WHERE S.Score <= SD.Score   -- 내 점수보다 높거나 같은 점수와만 같은 row에 놓임
GROUP BY S.Id, S.Score   -- score에는 중복값이 있어서 그룹핑할 때 id도 필요
ORDER BY S.Score DESC
;