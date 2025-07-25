DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

SELECT * FROM netflix;

SELECT COUNT(*) AS total_content
FROM netflix;

SELECT DISTINCT type
FROM netflix;

SELECT * FROM netflix;

-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows
SELECT type,
	COUNT(*)
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows
SELECT DISTINCT ON (type)
    type,
    rating AS most_frequent_rating
FROM (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
    ORDER BY type, rating_count DESC
) AS counts
ORDER BY type, rating_count DESC;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT *
FROM netflix
WHERE release_year=2020;

-- 4. Find the top 5 countries with the most content on Netflix
SELECT * 
FROM
(
	SELECT 
		UNNEST(STRING_TO_ARRAY(country, ',')) as country,
		COUNT(*) as total_content
	FROM netflix
	GROUP BY 1
) as t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;

-- 5. Identify the longest movie
SELECT 
  title,
  type,
  duration,
  CAST(REGEXP_REPLACE(duration, '\D', '', 'g') AS INTEGER) AS duration_minutes
FROM netflix
WHERE type = 'Movie' AND duration ILIKE '%min%'
ORDER BY duration_minutes DESC
LIMIT 1;




-- 6. Find content added in the last 5 years
SELECT
*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';


-- 7. Find all the movies/TV shows by director 'Martin Scorsese'!
SELECT *
FROM (
    SELECT *,
           UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix
) AS sub
WHERE TRIM(director_name) = 'Martin Scorsese';


-- 8. List all TV shows with more than 5 seasons
SELECT *
FROM
(
	SELECT 
	*,
	SPLIT_PART(duration, ' ', 1)::INT AS seasons
	FROM netflix
	WHERE type='TV Show'
)
WHERE seasons>5;


-- 9. Count the number of content items in each genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY 1;


-- 10.Find each year and the average numbers of content release in Spain on netflix.
-- return top 5 year with highest avg content release!
SELECT 
  country,
  release_year,
  COUNT(*) AS content_count
FROM netflix
WHERE country = 'Spain'
GROUP BY country, release_year
ORDER BY content_count DESC
LIMIT 5;



-- 11. List all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries';

-- 12. Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL;

-- 13. Find how many movies actor 'Adam Sandler' appeared in last 10 years!
SELECT COUNT(DISTINCT show_id) AS adam_sandler_movies_last_10_years
FROM netflix,
     unnest(string_to_array(casts, ',')) AS actor
WHERE 
    actor ILIKE 'Adam Sandler'
    AND type = 'Movie'
    AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;



-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in Spain.
SELECT 
  TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
  COUNT(DISTINCT show_id) AS num_of_movies
FROM netflix
WHERE country ILIKE '%spain%'
GROUP BY actor
ORDER BY num_of_movies DESC
LIMIT 10;


-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.
SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2

