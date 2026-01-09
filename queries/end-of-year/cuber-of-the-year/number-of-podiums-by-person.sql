SELECT person_name,
       Sum(pos = 1)                               AS first,
       Sum(pos = 2)                               AS second,
       Sum(pos = 3)                               AS third,
       Sum(pos = 1) + Sum(pos = 2) + Sum(pos = 3) AS total
FROM   results
WHERE  country_id = 'Hungary'
       AND competition_id LIKE '%:YEAR'
       AND round_type_id IN ( 'c', 'f' )
       AND best > 0
GROUP  BY person_id,
          person_name
ORDER  BY total DESC; 