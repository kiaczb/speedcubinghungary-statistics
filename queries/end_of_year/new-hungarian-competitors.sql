SELECT p.wca_id, p.name FROM persons p
WHERE p.wca_id LIKE ":YEAR%"
AND country_id = "Hungary"