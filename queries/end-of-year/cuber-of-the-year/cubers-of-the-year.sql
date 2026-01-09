SELECT person_name,
       person_id,
       COALESCE(Sum(number_of_records), 0) AS records_count,
       COALESCE(Sum(champion_count), 0)    AS champion_count,
       COALESCE(Sum(total), 0)             AS total_medals,
       COALESCE(Sum(first), 0)             AS gold_medals,
       COALESCE(Sum(second), 0)            AS silver_medals,
       COALESCE(Sum(third), 0)             AS bronze_medals
FROM   (SELECT person_id,
               person_name,
               Sum(pos = 1)                               AS first,
               Sum(pos = 2)                               AS second,
               Sum(pos = 3)                               AS third,
               Sum(pos = 1) + Sum(pos = 2) + Sum(pos = 3) AS total,
               0                                          AS number_of_records,
               0                                          AS champion_count
        FROM   results
        WHERE  country_id = 'Hungary'
               AND competition_id LIKE '%:YEAR'
               AND round_type_id IN ( 'c', 'f' )
               AND best > 0
        GROUP  BY person_id,
                  person_name
        UNION ALL
        SELECT r.person_id,
               r.person_name,
               0                                            AS first,
               0                                            AS second,
               0                                            AS third,
               0                                            AS total,
               Sum(( r.regional_single_record IS NOT NULL ) + (
                   r.regional_average_record IS NOT NULL )) AS number_of_records
               ,
               0                                            AS
               champion_count
        FROM   results r
               INNER JOIN persons p
                       ON r.person_id = p.wca_id
        WHERE  p.country_id = 'Hungary'
               AND r.competition_id LIKE '%:YEAR'
        GROUP  BY r.person_id,
                  r.person_name
        HAVING number_of_records > 0
        UNION ALL
        SELECT person_id,
               person_name,
               0        AS first,
               0        AS second,
               0        AS third,
               0        AS total,
               0        AS number_of_records,
               Count(*) AS champion_count
        FROM   (SELECT person_id,
                       person_name,
                       Row_number()
                         OVER (
                           partition BY event_id
                           ORDER BY pos) AS hun_pos
                FROM   results
                WHERE  competition_id = 'HungarianOpen:YEAR'
                       AND round_type_id IN ( 'c', 'f' )
                       AND country_id = 'Hungary'
                       AND best > 0) hungarian_positions
        WHERE  hun_pos = 1
        GROUP  BY person_id,
                  person_name) combined
GROUP  BY person_id,
          person_name
HAVING Sum(champion_count) > 0
        OR Sum(number_of_records) > 0
ORDER  BY records_count DESC,
          champion_count DESC,
          total_medals DESC; 