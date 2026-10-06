-- ============================================================
-- LIVE DEMO QUERIES — SQL Seminar
-- 37th National Statistics Month: Tuklas Pilipinas
-- Tables: tourists · visits · destinations
-- Tool: SQLiteOnline.com
-- ============================================================

-- ────────────────────────────────────────────────────────────
-- SECTION A — Getting to Know the Data
-- ────────────────────────────────────────────────────────────

SELECT * FROM tourists LIMIT 10;

SELECT * FROM visits LIMIT 10;

SELECT * FROM destinations LIMIT 10;


-- ────────────────────────────────────────────────────────────
-- SECTION B — Inclusive Tourism: Who is Visiting?
-- ────────────────────────────────────────────────────────────

-- How many tourists do we have by nationality?
SELECT nationality, COUNT(*) AS tourist_count
FROM tourists
GROUP BY nationality
ORDER BY tourist_count DESC;

-- Domestic vs foreign split
SELECT tourist_type, COUNT(*) AS count
FROM tourists
GROUP BY tourist_type;

-- Which age groups are most represented?
SELECT age_group, COUNT(*) AS count
FROM tourists
GROUP BY age_group
ORDER BY age_group;

-- Gender breakdown
SELECT sex, COUNT(*) AS count
FROM tourists
GROUP BY sex;


-- ────────────────────────────────────────────────────────────
-- SECTION C — Inclusive Tourism: Where Are They Going?
-- ────────────────────────────────────────────────────────────

-- How many visits did each region receive?
SELECT d.region, COUNT(*) AS total_visits
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
GROUP BY d.region
ORDER BY total_visits DESC;

-- Which destinations have the fewest visits? (underserved)
SELECT d.destination_name, d.region, COUNT(v.visit_id) AS visit_count
FROM destinations d
LEFT JOIN visits v ON d.destination_id = v.destination_id
GROUP BY d.destination_id
ORDER BY visit_count ASC;


-- ────────────────────────────────────────────────────────────
-- SECTION D — Sustainable Tourism: Overloaded or Underserved?
-- ────────────────────────────────────────────────────────────

-- Which destinations receive the most visits?
SELECT d.destination_name, d.category, COUNT(*) AS visit_count
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
GROUP BY d.destination_id
ORDER BY visit_count DESC;

-- Which destination categories attract the most tourists?
SELECT d.category, COUNT(*) AS visit_count
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
GROUP BY d.category
ORDER BY visit_count DESC;

-- Which destinations have more than 50 visits? (HAVING)
SELECT d.destination_name, COUNT(*) AS visit_count
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
GROUP BY d.destination_id
HAVING COUNT(*) > 50
ORDER BY visit_count DESC;


-- ────────────────────────────────────────────────────────────
-- SECTION E — Resilient Tourism: How Clean Is Our Data?
-- ────────────────────────────────────────────────────────────

-- Are there visits with missing spending data?
SELECT * FROM visits
WHERE spending_php IS NULL;

-- How many visits are missing spending per destination?
SELECT d.destination_name,
       COUNT(*) AS total_visits,
       SUM(CASE WHEN v.spending_php IS NULL THEN 1 ELSE 0 END) AS missing_spending
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
GROUP BY d.destination_id
ORDER BY missing_spending DESC;

-- Which destinations are missing spending entirely?
SELECT d.destination_name, COUNT(v.visit_id) AS total_visits,
       COUNT(v.spending_php) AS visits_with_spending
FROM destinations d
LEFT JOIN visits v ON d.destination_id = v.destination_id
GROUP BY d.destination_id
HAVING visits_with_spending = 0 OR visits_with_spending IS NULL;


-- ────────────────────────────────────────────────────────────
-- SECTION F — Sustainable Tourism: What Does a Visit Look Like?
-- ────────────────────────────────────────────────────────────

-- Avg, min, max spending per destination category
SELECT d.category,
       ROUND(AVG(v.spending_php), 2) AS avg_spending,
       ROUND(MIN(v.spending_php), 2) AS min_spending,
       ROUND(MAX(v.spending_php), 2) AS max_spending,
       COUNT(*) AS n_visits
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
WHERE v.spending_php IS NOT NULL
GROUP BY d.category
ORDER BY avg_spending DESC;

-- Average length of stay per destination
SELECT d.destination_name,
       ROUND(AVG(v.length_of_stay), 1) AS avg_nights
FROM visits v
JOIN destinations d ON v.destination_id = d.destination_id
GROUP BY d.destination_id
ORDER BY avg_nights DESC;

-- Which purpose of visit generates the highest average spending?
SELECT v.purpose,
       ROUND(AVG(v.spending_php), 2) AS avg_spending,
       COUNT(*) AS n_visits
FROM visits v
WHERE v.spending_php IS NOT NULL
GROUP BY v.purpose
ORDER BY avg_spending DESC;


-- ────────────────────────────────────────────────────────────
-- SECTION G — The Full Picture: A 3-Table JOIN
-- ────────────────────────────────────────────────────────────

-- Complete visitor profile
SELECT t.first_name, t.last_name, t.nationality, t.tourist_type,
       d.destination_name, d.region, d.category,
       v.visit_date, v.length_of_stay, v.purpose,
       v.accommodation, v.spending_php
FROM tourists t
INNER JOIN visits v ON t.tourist_id = v.tourist_id
INNER JOIN destinations d ON v.destination_id = d.destination_id
ORDER BY t.last_name, v.visit_date;
