SELECT r.*
FROM results r
INNER JOIN persons p ON r.person_id = p.wca_id
WHERE (regional_average_record IS NOT NULL OR regional_single_record IS NOT NULL)
AND p.country_id = "Hungary"
AND competition_id LIKE "%:YEAR";
