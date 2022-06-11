#1.SQL query to find the actors who were cast in the movie 'Annie Hall'.Return actor first name, last name and role

select act_fname, act_lname, role
from actors 
    join movie_cast on actors.act_id = movie_cast.act_id
    join movie on movie.mov_id = movie_cast.mov_id
where mov_title = 'Annie Hall';

#2.SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'.Return director first name, last name and movie title

select dir_fname, dir_lname, mov_title
from director 
    join movie_direction on director.dir_id = movie_direction.dir_id
    join movie on movie.mov_id = movie_direction.mov_id
    join movie_cast on movie_cast.mov_id = movie.mov_id
where mov_title like '%Eyes Wide Shut%'
and role is NOT NULL;

#3.SQL query to find who directed a movie that casted a role as ‘Sean Maguire’.Return director first name, last name and movie title

select dir_fname, dir_lname, mov_title
from director 
    join movie_direction on director.dir_id = movie_direction.dir_id
    join movie on movie.mov_id = movie_direction.mov_id
    join movie_cast on movie_cast.mov_id = movie.mov_id
where role like '%Sean Maguire%';

#4.SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.).Return actor first name, last name, movie title and release year

select act_fname, act_lname, mov_title, mov_year 
from actors 
    natural join movie_cast 
    natural join movie
where mov_year not BETWEEN 1990 and 2000
and act_id not in (select act_id 
from movie_cast 
    natural join movie 
where mov_year between 1990 and 2000);

#5.SQL query to find the directors with number of genres movies.Group the result set on director first name, last name and generic title.Sort the result-set in ascending order by director first name and last name.Return director first name, last name and number of genres movies

select dir_fname, dir_lname,count(distinct gen_title) as count
from director 
    left join movie_direction on director.dir_id = movie_direction.dir_id
    left join movie on movie.mov_id = movie_direction.mov_id
    left join movie_genres on movie.mov_id = movie_genres.mov_id
    left join genres on movie_genres.gen_id = genres.gen_id
group by dir_fname, dir_lname, gen_title
order by dir_fname, dir_lname;

#6.SQL query to find the movies with year and genres. Return movie title, movie year and generic title

select mov_title, mov_year, gen_title
from movie 
    left join movie_genres on movie.mov_id = movie_genres.mov_id
    left join genres on movie_genres.gen_id = genres.gen_id;

#7.SQL query to find all the movies with year, genres, and name of the director

select mov_title, mov_year, gen_title, CONCAT(dir_fname,' ', dir_lname) as director
from movie 
    left join movie_direction on movie.mov_id = movie_direction.mov_id 
    left join director on movie_direction.dir_id = director.dir_id
    left join movie_genres on movie.mov_id = movie_genres.mov_id
    left join genres on movie_genres.gen_id = genres.gen_id;

#8.SQL query to find the movies released before 1st January 1989.Sort the result-set in descending order by date of release.Return movie title, release year, date of release, duration, and first and last name of the director

select mov_title, mov_year, mov_dt_rel, mov_time, dir_fname, dir_lname
from movie 
    left join movie_direction ON movie.mov_id = movie_direction.mov_id
    left join director ON movie_direction.dir_id = director.dir_id
where mov_year < 1989
order by mov_year desc;