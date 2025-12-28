SELECT person_id,
       person_name,
       SUM(num_records) AS total_records
FROM (
    -- Get the number of "single" records per person for the given HungarianAllRounder year.
    SELECT r.person_id,
           r.person_name,
           COUNT(*) AS num_records
    FROM results r
    INNER JOIN competitions c ON c.id = r.competition_id
    WHERE r.best > 0
      AND c.id LIKE 'HungarianAllRounder%:YEAR'
      AND r.best =
        (SELECT MIN(r2.best) --Find the competitor's best result for this event up to this competition
         FROM results r2
         INNER JOIN competitions c2 ON c2.id = r2.competition_id
         WHERE r2.best > 0
           AND r2.event_id = r.event_id
           AND r2.person_id = r.person_id
           AND c2.start_date <= c.start_date)
    GROUP BY r.person_id, r.person_name

    UNION ALL

    -- Get the number of "average" records per person for the given HungarianAllRounder year.
    SELECT r.person_id,
           r.person_name,
           COUNT(*) AS num_records
    FROM results r
    INNER JOIN competitions c ON c.id = r.competition_id
    WHERE r.average > 0
      AND c.id LIKE 'HungarianAllRounder%:YEAR'
      AND r.average =
        (SELECT MIN(r3.average)
         FROM results r3
         INNER JOIN competitions c3 ON c3.id = r3.competition_id
         WHERE r3.average > 0
           AND r3.event_id = r.event_id
           AND r3.person_id = r.person_id
           AND c3.start_date <= c.start_date)
    GROUP BY r.person_id, r.person_name
) AS subquery
GROUP BY person_id, person_name
ORDER BY total_records DESC;