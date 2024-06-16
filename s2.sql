CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;
-- 1. Create tables
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    nationality VARCHAR(50),
    height DECIMAL(5,2),
    weight DECIMAL(5,2),
    hair_color VARCHAR(50),
    eye_color VARCHAR(50)
);

CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(100),
    country VARCHAR(50),
    phone_number VARCHAR(20),
    years_of_experience INT,
    education_level VARCHAR(50),
    awards_received INT
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    genres VARCHAR(100),
    release_date DATE,
    rating DECIMAL(2,1),
    director_id INT,
    budget DECIMAL(18,2),
    box_office DECIMAL(18,2),
    duration INT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

CREATE TABLE movie_cast (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

-- 2. Insert initial data
INSERT INTO actors (actor_id, first_name, last_name, age, gender, nationality, height, weight, hair_color, eye_color)
VALUES (1, 'Gloriane', 'Girod', 42, 'Female', 'China', 161.6, 78.8, 'brown', 'blue');

INSERT INTO directors (director_id, first_name, last_name, age, email, country, phone_number, years_of_experience, education_level, awards_received)
VALUES (1, 'Ronna', 'Dalgetty', 42, 'rdalgetty0@t.co', 'Indonesia', '119-755-5172', 5, 'PhD', 35);

-- Assuming 'Candie Troni' refers to director_id = 1
INSERT INTO movies (title, genres, release_date, rating, director_id, budget, box_office, duration)
VALUES ('Manderlay', 'Drama', '1991-01-19', 2.7, 1, 0, 0, 1);

-- Assuming 'Actor 4' refers to actor_id = 1
INSERT INTO movie_cast (movie_id, actor_id)
VALUES (1, 1);

-- 3. Aggregation query with FD attributes and both WHERE and HAVING
SELECT 
    nationality, 
    COUNT(*) AS actor_count,
    AVG(age) AS avg_age
FROM 
    actors
WHERE 
    gender = 'Female'
GROUP BY 
    nationality
HAVING 
    COUNT(*) > 0;

-- 4. Sub-query to aggregate aggregations with existential condition
SELECT 
    d.director_id, 
    d.first_name, 
    d.last_name, 
    d.age
FROM 
    directors d
WHERE 
    EXISTS (
        SELECT 
            1
        FROM 
            movies m
        WHERE 
            m.director_id = d.director_id
        GROUP BY 
            m.director_id
        HAVING 
            AVG(m.rating) > 2.0
    );

-- 5. Insert and delete data based on complex query predicates
-- Inserting a new actor only if there is no actor with the same first and last name
INSERT INTO actors (actor_id, first_name, last_name, age, gender, nationality, height, weight, hair_color, eye_color)
SELECT 
    2, 'NewFirst', 'NewLast', 30, 'Male', 'USA', 180.0, 75.0, 'black', 'green'
WHERE 
    NOT EXISTS (
        SELECT 
            1
        FROM 
            actors 
        WHERE 
            first_name = 'NewFirst' AND last_name = 'NewLast'
    );

-- Deleting movies with a rating less than 3 and released before 2000
DELETE FROM 
    movies
WHERE 
    rating < 3.0 AND release_date < '2000-01-01';
