-- Q4: Average critic vs fan score by platform
SELECT
  platform,
  ROUND(AVG(CAST(meta_score AS REAL)), 1) AS avg_critic,
  ROUND(AVG(CAST(user_score AS REAL) * 10), 1) AS avg_fan,
  ROUND(AVG(CAST(meta_score AS REAL)) - AVG(CAST(user_score AS REAL) * 10), 1) AS avg_gap,
  COUNT(*) AS game_count
FROM nintendo_meta
WHERE meta_score <> ''
  AND LOWER(user_score) NOT IN ('', 'tbd', 'tba', 'n/a')
GROUP BY platform
ORDER BY avg_gap DESC;

-- Q5: Average critic vs fan score by release year
SELECT
  SUBSTR(date, -4) AS release_year,
  ROUND(AVG(CAST(meta_score AS REAL)), 1) AS avg_critic,
  ROUND(AVG(CAST(user_score AS REAL) * 10), 1) AS avg_fan,
  COUNT(*) AS game_count
FROM nintendo_meta
WHERE meta_score <> ''
  AND LOWER(user_score) NOT IN ('', 'tbd', 'tba', 'n/a')
  AND LENGTH(SUBSTR(date, -4)) = 4
GROUP BY release_year
ORDER BY release_year;