SELECT COUNT(DISTINCT r.person_id) AS person_count
FROM competitions c
INNER JOIN results r ON c.id = r.competition_id
WHERE c.country_id = 'Hungary'
AND c.id LIKE 'HungarianAllRounder%:YEAR';