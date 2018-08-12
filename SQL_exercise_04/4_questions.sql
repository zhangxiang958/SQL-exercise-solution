-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
-- 4.1 Select the title of all movies.
SELECT title FROM movies;
-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT rating FROM movies;
-- 4.3  Show all unrated movies.
SELECT * FROM movies WHERE rating IS NULL;
-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT * FROM movietheaters WHERE moviesthreaters.movies IS NULL;
-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT * FROM movies, movietheaters WHERE movietheaters.movie IS NOT NULL;
-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT * FROM movies, movietheaters WHERE movietheaters.movie IS NOT NULL;
-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT title FROM moviethreaters , movies WHERE movietheaters.movie IS NULL;
-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO movies(title, rating) VALUES('one', NULL);
INSERT INTO movies(title, rating) VALUES('two', NULL);
INSERT INTO movies(title, rating) VALUES('three', NULL);
-- 4.9 Set the rating of all unrated movies to "G".
UPDATE movies SET rating = 'G' WHERE rating IS NULL;
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM moviesthreaters WHERE movies = (SELECT code FROM moies WHERE rating = 'NC-17');