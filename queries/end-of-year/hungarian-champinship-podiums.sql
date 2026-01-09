--NOTE: We are assuming that there were at least 3 hungarian competitiors in the final rounds

SELECT hun_pos,
       event_id,
       person_name,
       wca_statistics_time_format(average, event_id, 'average') AS average,
       wca_statistics_time_format(best, event_id, 'single')     AS single
FROM   (SELECT pos,
               event_id,
               person_name,
               average,
               best,
               Row_number()
                 OVER (
                   partition BY event_id
                   ORDER BY pos ) AS hun_pos
        FROM   results
        WHERE  competition_id = 'HungarianOpen:YEAR'
               AND round_type_id IN ( 'c', 'f' )
               AND country_id = 'Hungary'
               AND best > 0) hungarian_positions
WHERE  hun_pos <= 3
ORDER  BY event_id,
          pos; 