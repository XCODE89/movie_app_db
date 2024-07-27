SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url
    ) AS poster,
    json_build_object(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name,
        'photo', json_build_object(
            'id', pf.id,
            'file_name', pf.file_name,
            'mime_type', pf.mime_type,
            'key', pf.key,
            'url', pf.url
        )
    ) AS director,
    json_agg(
        json_build_object(
            'id', c.id,
            'first_name', c.first_name,
            'last_name', c.last_name,
            'photo', json_build_object(
                'id', cf.id,
                'file_name', cf.file_name,
                'mime_type', cf.mime_type,
                'key', cf.key,
                'url', cf.url
            )
        )
    ) AS actors,
    json_agg(
        json_build_object(
            'id', g.id,
            'name', g.name
        )
    ) AS genres
FROM
    Movie m
LEFT JOIN
    File f ON m.poster_id = f.id
LEFT JOIN
    Person p ON m.director_id = p.id
LEFT JOIN
    File pf ON p.primary_photo_id = pf.id
LEFT JOIN
    Character ch ON m.id = ch.movie_id
LEFT JOIN
    Person c ON ch.actor_id = c.id
LEFT JOIN
    File cf ON c.primary_photo_id = cf.id
LEFT JOIN
    MovieGenre mg ON m.id = mg.movie_id
LEFT JOIN
    Genre g ON mg.genre_id = g.id
WHERE
    m.id = 1
GROUP BY
    m.id, f.id, p.id, pf.id;
