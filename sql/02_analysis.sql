-- Q1: Top 10 rated nintendo games by crritics
SELECT 
    title,
	platform,
	meta_score,
	user_score,
	date
FROM nintendo_meta
WHERE meta_score IS NOT NULL
ORDER BY meta_score DESC
LIMIT 10;

-- Q2: Biggest critic vs fan gaps (critic - fan*10)
SELECT
  title,
  platform,
  CAST(meta_score AS REAL) AS meta_score,
  CAST(user_score AS REAL) AS user_score,
  ROUND(CAST(meta_score AS REAL) - (CAST(user_score AS REAL) * 10), 1) AS critic_minus_fan
FROM nintendo_meta
WHERE meta_score <> ''
  AND LOWER(user_score) NOT IN ('', 'tbd', 'tba', 'n/a')
ORDER BY critic_minus_fan DESC
LIMIT 10;

-- Q3: Average critic vs fan score by genre
SELECT
  genres,
  ROUND(AVG(CAST(meta_score AS REAL)), 1) AS avg_critic,
  ROUND(AVG(CAST(user_score AS REAL) * 10), 1) AS avg_fan,
  ROUND(AVG(CAST(meta_score AS REAL)) - AVG(CAST(user_score AS REAL) * 10), 1) AS avg_gap
FROM nintendo_meta
WHERE meta_score <> ''
  AND LOWER(user_score) NOT IN ('', 'tbd', 'tba', 'n/a')
GROUP BY genres
ORDER BY avg_gap DESC;