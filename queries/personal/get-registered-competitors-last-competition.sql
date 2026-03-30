SELECT DISTINCT p.name AS person_name,
       c.cell_name AS last_competition,
       c.start_date
FROM (
    SELECT r.person_id,
           MAX(c.start_date) AS last_date
    FROM registrations reg
    JOIN users u ON u.id = reg.user_id
    JOIN results r ON r.person_id = u.wca_id
    JOIN competitions c ON c.id = r.competition_id
    WHERE reg.competing_status = 'accepted'
      AND reg.is_competing = 1
      AND reg.competition_id = ':COMPETITION_ID'
    GROUP BY r.person_id
) t
JOIN results r ON r.person_id = t.person_id
JOIN competitions c ON c.id = r.competition_id
JOIN persons p ON p.wca_id = r.person_id
WHERE c.start_date = t.last_date
ORDER BY c.start_date ASC;