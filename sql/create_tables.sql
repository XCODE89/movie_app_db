CREATE DATABASE movie_app_db;

\c movie_app_db

CREATE TYPE character_role AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    code CHAR(3) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE File (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE person_role AS ENUM ('director', 'actor');

CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender CHAR(1),
    home_country_id INTEGER,
    primary_photo_id INTEGER,
    role person_role NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (home_country_id) REFERENCES Country(id),
    FOREIGN KEY (primary_photo_id) REFERENCES File(id)
);

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (avatar_id) REFERENCES File(id)
);

CREATE TABLE Movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(15, 2) NOT NULL,
    release_date DATE NOT NULL,
    duration INTERVAL NOT NULL,
    director_id INTEGER,
    country_id INTEGER,
    poster_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (director_id) REFERENCES Person(id),
    FOREIGN KEY (country_id) REFERENCES Country(id),
    FOREIGN KEY (poster_id) REFERENCES File(id)
);

CREATE TABLE Character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role character_role NOT NULL,
    movie_id INTEGER,
    actor_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (actor_id) REFERENCES Person(id)
);

CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MovieGenre (
    movie_id INTEGER,
    genre_id INTEGER,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);

CREATE TABLE FavoriteMovie (
    user_id INTEGER,
    movie_id INTEGER,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES "user"(id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id)
);



-- "Country"
INSERT INTO Country (name, code) VALUES
('United States', 'USA'),
('Canada', 'CAN'),
('Mexico', 'MEX'),
('United Kingdom', 'GBR'),
('France', 'FRA'),
('Germany', 'DEU'),
('Italy', 'ITA'),
('Spain', 'ESP'),
('Australia', 'AUS'),
('Japan', 'JPN');

-- "File"
INSERT INTO File (file_name, mime_type, key, url) VALUES
('avatar1.png', 'image/png', 'key1', 'http://example.com/avatar1.png'),
('avatar2.png', 'image/png', 'key2', 'http://example.com/avatar2.png'),
('poster1.jpg', 'image/jpeg', 'key3', 'http://example.com/poster1.jpg'),
('poster2.jpg', 'image/jpeg', 'key4', 'http://example.com/poster2.jpg'),
('photo1.jpg', 'image/jpeg', 'key5', 'http://example.com/photo1.jpg'),
('photo2.jpg', 'image/jpeg', 'key6', 'http://example.com/photo2.jpg'),
('photo3.jpg', 'image/jpeg', 'key7', 'http://example.com/photo3.jpg'),
('photo4.jpg', 'image/jpeg', 'key8', 'http://example.com/photo4.jpg'),
('photo5.jpg', 'image/jpeg', 'key9', 'http://example.com/photo5.jpg'),
('photo6.jpg', 'image/jpeg', 'key10', 'http://example.com/photo6.jpg');

-- "Person"
INSERT INTO Person (first_name, last_name, home_country_id, primary_photo_id, role) VALUES
('John', 'Doe', 1, 5, 'director'),
('Jane', 'Smith', 2, 6, 'actor'),
('Robert', 'Johnson', 3, 7, 'actor'),
('Emily', 'Davis', 1, 8, 'director'),
('Michael', 'Brown', 3, 9, 'actor'),
('Sarah', 'Wilson', 6, 10, 'actor'),
('David', 'Taylor', 1, 5, 'director'),
('Emma', 'Moore', 8, 6, 'actor'),
('Daniel', 'Anderson', 2, 7, 'director'),
('Sophia', 'Thomas', 10, 8, 'actor');

-- "user"
INSERT INTO "user" (username, first_name, last_name, email, password, avatar_id) VALUES
('johndoe', 'John', 'Doe', 'johndoe@example.com', 'password123', 1),
('janesmith', 'Jane', 'Smith', 'janesmith@example.com', 'password456', 2),
('robertjohnson', 'Robert', 'Johnson', 'robertjohnson@example.com', 'password789', 3),
('emilydavis', 'Emily', 'Davis', 'emilydavis@example.com', 'password321', 4),
('michaelbrown', 'Michael', 'Brown', 'michaelbrown@example.com', 'password654', 5),
('sarahwilson', 'Sarah', 'Wilson', 'sarahwilson@example.com', 'password987', 6),
('davidtaylor', 'David', 'Taylor', 'davidtaylor@example.com', 'password111', 7),
('emmamoore', 'Emma', 'Moore', 'emmamoore@example.com', 'password222', 8),
('danielanderson', 'Daniel', 'Anderson', 'danielanderson@example.com', 'password333', 9),
('sophiathomas', 'Sophia', 'Thomas', 'sophiathomas@example.com', 'password444', 10);

-- "Movie"
INSERT INTO Movie (title, description, budget, release_date, duration, director_id, country_id, poster_id) VALUES
('Movie 1', 'Description of movie 1', 1000000, '2023-01-01', '2 hours 30 minutes', 1, 1, 3),
('Movie 2', 'Description of movie 2', 2000000, '2011-06-15', '1 hour 45 minutes', 4, 2, 4),
('Movie 3', 'Description of movie 3', 1500000, '2020-03-10', '2 hours', 1, 3, 3),
('Movie 4', 'Description of movie 4', 3000000, '2019-11-20', '2 hours 20 minutes', 4, 4, 4),
('Movie 5', 'Description of movie 5', 2500000, '2018-07-05', '2 hours 45 minutes', 7, 5, 3),
('Movie 6', 'Description of movie 6', 1200000, '2022-09-25', '2 hours 50 minutes', 1, 1, 4),
('Movie 7', 'Description of movie 7', 1800000, '2023-04-12', '1 hour 50 minutes', 1, 7, 3),
('Movie 8', 'Description of movie 8', 2200000, '2017-05-30', '2 hours 5 minutes', 9, 2, 4),
('Movie 9', 'Description of movie 9', 1700000, '2013-10-07', '2 hours 30 minutes', 9, 1, 3),
('Movie 10', 'Description of movie 10', 1300000, '2014-02-14', '2 hours 40 minutes', 1, 1, 4);

-- "Character"
INSERT INTO Character (name, description, role, movie_id, actor_id) VALUES
('Character 1', 'Description of character 1', 'leading', 1, 2),
('Character 2', 'Description of character 2', 'supporting', 5, 5),
('Character 3', 'Description of character 3', 'background', 3, 3),
('Character 4', 'Description of character 4', 'leading', 1, 8),
('Character 5', 'Description of character 5', 'supporting', 5, 5),
('Character 6', 'Description of character 6', 'background', 3, 2),
('Character 7', 'Description of character 7', 'leading', 7, 8),
('Character 8', 'Description of character 8', 'supporting', 3, 8),
('Character 9', 'Description of character 9', 'background', 1, 6),
('Character 10', 'Description of character 10', 'leading', 1, 10);

-- "Genre"
INSERT INTO Genre (name) VALUES
('Action'),
('Drama'),
('Comedy'),
('Thriller'),
('Horror'),
('Romance'),
('Sci-Fi'),
('Fantasy'),
('Adventure'),
('Documentary');

-- "MovieGenre"
INSERT INTO MovieGenre (movie_id, genre_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2),
(6, 1),
(7, 2),
(8, 3),
(9, 1),
(10, 2);

-- "FavoriteMovie"
INSERT INTO FavoriteMovie (user_id, movie_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);
