WITH ranked_results AS (
    SELECT r.*, c.start_date,
        ROW_NUMBER() OVER (PARTITION BY r.event_id ORDER BY r.:TYPE, c.start_date DESC) as rn_all,
        ROW_NUMBER() OVER (PARTITION BY r.event_id ORDER BY 
            CASE WHEN YEAR(c.start_date) < :YEAR THEN 1 ELSE 2 END,
            r.:TYPE, c.start_date DESC) as rn_by_year
    FROM results r
    INNER JOIN competitions c ON c.id = r.competition_id
    WHERE r.person_id = ':WCA_ID' AND r.:TYPE > 0
)
SELECT 
    prev.competition_id as previous_comp,
    cur.competition_id as current_comp,
    cur.event_id,
    wca_statistics_time_format(prev.:TYPE, cur.event_id, ':TYPE') AS before_:YEAR,
    wca_statistics_time_format(cur.:TYPE, cur.event_id, ':TYPE') AS end_of_2025,
    CONCAT(ROUND(
        CASE
            WHEN cur.event_id = '333mbf' THEN
                ((99 - FLOOR(cur.:TYPE / 10000000)) / (99 - FLOOR(prev.:TYPE / 10000000)) - 1) * 100
            ELSE
                (1 - cur.:TYPE / prev.:TYPE) * 100
        END, 2), ' %') AS improvement
FROM (SELECT * FROM ranked_results WHERE rn_all = 1) cur
INNER JOIN (SELECT * FROM ranked_results WHERE rn_by_year = 1 AND YEAR(start_date) < :YEAR) prev 
    ON cur.event_id = prev.event_id
WHERE (cur.event_id = '333mbf' AND (99 - FLOOR(cur.:TYPE / 10000000)) > (99 - FLOOR(prev.:TYPE / 10000000)))
    OR (cur.event_id != '333mbf' AND cur.:TYPE < prev.:TYPE)
ORDER BY 
    CASE 
        WHEN cur.event_id = '333mbf' THEN (99 - FLOOR(cur.:TYPE / 10000000)) / (99 - FLOOR(prev.:TYPE / 10000000)) - 1
        ELSE 1 - cur.:TYPE / prev.:TYPE
    END DESC;


--Note:
--For the TYPE you need to enter "average" or "best"