SELECT
    p.id AS actor_id,
    p.first_name,
    p.last_name,
    COALESCE(SUM(m.budget), 0) AS total_movies_budget
FROM
    Person p
LEFT JOIN
    Character c ON p.id = c.actor_id
LEFT JOIN
    Movie m ON c.movie_id = m.id
WHERE
    p.role = 'actor'
    AND c.role IN ('leading', 'supporting', 'background')
GROUP BY
    p.id, p.first_name, p.last_name;