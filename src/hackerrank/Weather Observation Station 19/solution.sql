/*
 Weather Observation Station 19: https://www.hackerrank.com/challenges/weather-observation-station-19/problem
 */

SELECT
    ROUND(SQRT(POW(b - a, 2) + POW(d - c, 2)), 4)
FROM
    (SELECT
         MIN(LAT_N) AS a,
         MAX(LAT_N) AS b,
         MIN(LONG_W) AS c,
         MAX(LONG_W) AS d
     FROM
         STATION) foo;