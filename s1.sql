CREATE DATABASE IF NOT EXISTS MovieDB;
USE MovieDB;
-- in case of duplicated tables 
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS movies;
-- Create actors table
CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    nationality VARCHAR(50),
    height FLOAT,
    weight FLOAT,
    hair_color VARCHAR(20),
    eye_color VARCHAR(20)
);

-- Create directors table
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

-- Create movies table
CREATE TABLE movies (
    title VARCHAR(100),
    genres VARCHAR(50),
    release_date DATE,
    rating FLOAT,
    director VARCHAR(100),
    cast VARCHAR(100),
    budget VARCHAR(50),
    box_office VARCHAR(50),
    duration INT
);

-- Insert data into actors table
INSERT INTO actors (actor_id, first_name, last_name, age, gender, nationality, height, weight, hair_color, eye_color) VALUES
(1, 'Gloriane', 'Girod', 42, 'Female', 'China', 161.6, 78.8, 'brown', 'blue');

-- Insert data into directors table
INSERT INTO directors (director_id, first_name, last_name, age, email, country, phone_number, years_of_experience, education_level, awards_received) VALUES
(1, 'Ronna', 'Dalgetty', 42, 'rdalgetty0@t.co', 'Indonesia', '119-755-5172', 5, 'PhD', 35);

-- Insert data into movies table
INSERT INTO movies (title, genres, release_date, rating, director, cast, budget, box_office, duration) VALUES
('Manderlay', 'Drama', '1991-01-19', 2.7, 'Candie Troni', 'Actor 4', 'Yuan Renminbi', 'Naira', 1);

-- select from with LIMIT
SELECT first_name, last_name, age 
FROM actors 
LIMIT 1;

-- WHERE
SELECT title, rating 
FROM movies 
WHERE rating > 3.0;

-- JOIN  actors and movies 
SELECT a.first_name, a.last_name, m.title 
FROM actors a 
JOIN movies m ON a.actor_id = m.cast;

-- ORDER BY clause
SELECT first_name, last_name, age 
FROM actors 
ORDER BY age DESC;

-- DISTINCT clause
SELECT DISTINCT nationality 
FROM actors;

-- retrieves a list of actors, the movies they starred in, and the directors of those movies. It filters for actors older than 30, orders the movies by their release date in descending order, and limits the results to the first 5 records.
SELECT a.first_name, a.last_name, m.title, d.first_name AS director_first_name, d.last_name AS director_last_name 
FROM actors a 
JOIN movies m ON a.actor_id = m.cast 
JOIN directors d ON m.director = d.first_name || ' ' || d.last_name 
WHERE a.age > 30 
ORDER BY m.release_date DESC 
LIMIT 5;

-- retrieves a list of unique nationalities of the actors and orders this list in ascending alphabetical order
SELECT DISTINCT nationality 
FROM actors 
ORDER BY nationality ASC;