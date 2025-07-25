Netflix Content Analysis - SQL Queries
Overview
This project contains SQL scripts to analyze a Netflix dataset, focusing on movies and TV shows metadata. The dataset includes information such as show IDs, titles, directors, cast members, countries, release years, genres, descriptions, and more.

Database Setup
A table netflix is created with columns matching the dataset structure.

Data should be loaded into the netflix table before running queries.

Queries and Business Problems Solved
Count Movies vs TV Shows
Counts total content grouped by type (Movie or TV Show).

Most Common Rating for Movies and TV Shows
Finds the most frequent rating per content type.

Movies Released in a Specific Year
Lists all movies released in the year 2020.

Top 5 Countries with Most Content
Finds countries with the highest volume of Netflix content.

Longest Movie
Identifies the movie with the longest duration (in minutes).

Content Added in the Last 5 Years
Finds all content added to Netflix in the last 5 years.

Content by Director 'Martin Scorsese'
Lists all titles directed by Martin Scorsese.

TV Shows with More Than 5 Seasons
Lists TV shows having more than 5 seasons.

Count Content by Genre
Counts how many content items belong to each genre.

Top 5 Years with Highest Average Content Release in Spain
Lists the top years by content count released in Spain.

Documentaries
Lists all content categorized as documentaries.

Content Without a Director
Finds content entries missing director information.

Movies Featuring Adam Sandler in Last 10 Years
Counts distinct movies starring Adam Sandler released in the last decade.

Top 10 Actors in Spanish Movies
Lists the top actors by number of movies produced in Spain.

Content Categorization by Description Keywords
Labels content as 'Bad' if description contains "kill" or "violence," else 'Good', and counts the number in each category.

How to Use
Load your Netflix dataset into the netflix table.

Run the SQL queries to answer specific business questions.

Modify filters (e.g., country, year) as needed to suit analysis goals.

Notes
The casts, director, country, and listed_in columns often contain comma-separated values; these are handled by splitting strings for detailed analysis.

Dates and durations may require parsing or conversion for accurate filtering and calculations.

Queries assume data consistency but may need adjustments for irregularities in the dataset.

This project helps practice SQL skills such as string manipulation, aggregation, filtering, and subqueries, applied to real-world content analysis scenarios.
