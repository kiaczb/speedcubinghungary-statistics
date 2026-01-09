SELECT
    SUM(
        (r.regional_single_record IS NOT NULL) +
        (r.regional_average_record IS NOT NULL)
    ) AS number_of_records
FROM results r
INNER JOIN persons p ON r.person_id = p.wca_id
WHERE p.country_id = "Hungary"
  AND r.competition_id LIKE "%:YEAR";
