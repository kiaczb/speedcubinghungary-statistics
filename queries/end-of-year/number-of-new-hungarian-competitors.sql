SELECT count(*) FROM persons p
WHERE p.wca_id LIKE ":YEAR%"
AND country_id = "Hungary"