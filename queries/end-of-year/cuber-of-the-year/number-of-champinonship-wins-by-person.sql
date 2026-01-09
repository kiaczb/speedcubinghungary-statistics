--NOTE: We are assuming that there were at least 3 hungarian competitiors in the final rounds

SELECT person_name,
       Count(*) AS champion_count
FROM   (SELECT pos,
               event_id,
               person_name,
               person_id,
               Row_number()
                 OVER (
                   partition BY event_id
                   ORDER BY pos ) AS hun_pos
        FROM   results
        WHERE  competition_id = 'HungarianOpen:YEAR'
               AND round_type_id IN ( 'c', 'f' )
               AND country_id = 'Hungary'
               AND best > 0) hungarian_positions
WHERE  hun_pos = 1
GROUP  BY person_id
ORDER  BY champion_count DESC 