SELECT Count(*)
FROM   competitions c
WHERE  Year(c.start_date) = :YEAR
       AND c.country_id = "Hungary"  