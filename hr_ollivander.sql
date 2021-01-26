SELECT W.id, WP.age, PM.price_min, W.power
FROM Wands W 
    INNER JOIN Wands_Property WP ON W.code = WP.code
    INNER JOIN (SELECT power, age, MIN(coins_needed) price _min
                FROM Wands W
                    INNER JOIN Wands_Property WP ON W.code = WP.code
                WHERE is_evil = 0 
                GROUP BY power, age) PM
        ON W.power = PM.power AND WP.age = PM.age AND W.coins_needed = PM.price_min
ORDER BY power DESC, age DESC
;