select * from actor
select * from director
select * from genres
select * from movie
select * from movie_cast where role = 'Eyes Wide Shut'
select * from movie_direction
select * from movie_genres
select * from rating
select * from reviewer

SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('reviewer')
exec sp_help
--1 Write a SQL query to find the name and year of the movies. Return movie title, movie release year.
select mov_title, mov_year from movie

--2 write a SQL query to find when the movie ‘American Beauty’ released. Return movie release year.
select mov_year from movie where mov_title = 'American Beauty'

--3 write a SQL query to find the movie, which was made in the year 1999. Return movie title.
select mov_title from movie where mov_year = 1999

--4 write a SQL query to find those movies, which was made before 1998. Return movie title.
select * from movie where mov_year < 1998

--5 write a SQL query to find the name of all reviewers and movies together in a single list.
select mov_title, r.rev_id, rev_name from movie m
inner join rating r on m.mov_id = r.mov_id
inner join reviewer re on re.rev_id = r.rev_id

--6 write a SQL query to find all reviewers who have rated 7 or more stars to their rating. Return reviewer name.
select rev_name, rev_stars from reviewer re
right join rating ra on re.rev_id = ra.rev_id
where rev_stars >= 7

--7 write a SQL query to find the movies without any rating. Return movie title.
select mov_title, num_o_ratings from rating
join movie on rating.mov_id = movie.mov_id
where num_o_ratings is null

--8 write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.
select mov_id, mov_title from movie 
where mov_id in(905,907,917)

--9 write a SQL query to find those movie titles, which include the words 'Boogie Nights'. 
--Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.
select * from movie 
where mov_title like '%Boogie Nights%'
order by mov_year

--10 write a SQL query to find those actors whose first name is 'Woody' and the last name is 'Allen'. Return actor ID
select * from actor
where act_fname = 'Woody' and act_lname = 'Allen'

--Subqueries

--1  Find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table.
select * from actor a
join movie_cast c on a.act_id = c.act_id
join movie m on m.mov_id = c.mov_id
where mov_title = 'Annie Hall'

select * from actor
where act_id = (select act_id from movie_cast
				where mov_id = (select mov_id from movie
								where mov_title = 'Annie Hall'))

--2  write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name.
select * from director
where dir_id = (select dir_id from movie_direction
				where mov_id = (select mov_id from movie
								where mov_title = 'Eyes Wide Shut'))
															   								 							  
--3  write a SQL query to find those movies, which released in the country besides UK. 
--Return movie title, movie year, movie time, date of release, releasing country.
select * from movie 
where mov_rel_country in ('ireland', 'Netherlands')

--4  write a SQL query to find those movies where reviewer is unknown. 
--   Return movie title, year, release date, director first name, last name, actor first name, last name.
select mov_title, mov_year, mov_dt_rel, dir_fname, dir_lname, act_fname, act_lname from movie m
join movie_cast mc on m.mov_id  = mc.mov_id 
join movie_direction md on md.mov_id = m.mov_id
join rating r on r.mov_id = m.mov_id
join actor a on a.act_id = mc.act_id
join director d on d.dir_id = md.dir_id
where rev_id in (select rev_id from reviewer 
				where rev_name = '')
				
--5  write a SQL query to find those movies directed by the director whose first name is ‘Woddy’ and last name is ‘Allen’. Return movie title. 
select mov_title from movie 
where mov_id = (select mov_id from movie_direction
				where dir_id = (select dir_id from director
								where dir_fname = 'Woody' and dir_lname = 'Allen'))

--6  write a SQL query to find those years, which produced at least one movie and that, received a rating of more than three stars. 
--Sort the result-set in ascending order by movie year. Return movie year.
select mov_year from movie 
where mov_id in (select mov_id from rating
					where rev_stars > 3)

--7  write a SQL query to find those movies, which have no ratings. Return movie title.
select mov_title from movie
where mov_id in (select mov_id from rating 
					where num_o_ratings is null)
					
--8  write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name.
select rev_name from reviewer
where rev_id in (select rev_id from rating
					where rev_stars is null)
					
--9  write a SQL query to find those movies, which reviewed by a reviewer and got a rating. 
--Sort the result-set in ascending order by reviewer name, movie title, review Stars. 
--Return reviewer name, movie title, review Stars.
select rev_name, mov_title, rev_stars from movie m
join rating r on m.mov_id = r.mov_id
join reviewer re on re.rev_id = r.rev_id
where m.mov_id in (select mov_id from rating
					where rev_stars is not null)
	and rev_name != ''
order by rev_name, mov_title, rev_stars

--10 write a SQL query to find those reviewers who rated more than one movie. Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title.
select reviewer.rev_name,movie.mov_title from rating
inner join reviewer on rating.rev_id=reviewer.rev_id 
inner join movie on rating.mov_id=movie.mov_id
where rating.rev_id = any(select rev_id from rating group by rev_id having count(*) > 1) 
						group by reviewer.rev_name,movie.mov_title
						
--11 write a SQL query to find those movies, which have received highest number of stars. 
--Group the result set on movie title and sorts the result-set in ascending order by movie title. Return movie title and maximum number of review stars. 
select mov_title, max(rev_stars) from rating (nolock)
join movie (nolock) on rating.mov_id = movie.mov_id 
where rev_stars = (select max(rev_stars) from rating)
group by mov_title
order by mov_title 

--12 write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name.
select rev_name from reviewer re
join rating r on re.rev_id = r.rev_id
where mov_id in (select mov_id from movie
					where mov_title = 'American Beauty') 

--13 write a SQL query to find the movies, which have reviewed by any reviewer body except by 'Paul Monks'. Return movie title. 
select mov_title from movie
where mov_id In (select mov_id from rating
				where rev_id in (select rev_id from reviewer 
						where rev_name != 'Paul Monks'))

--14 write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies.
select rev_name, mov_title,rev_stars from movie m
join rating r on m.mov_id = r.mov_id
join reviewer re on re.rev_id = r.rev_id
where m.mov_id = (select mov_id from rating 
				where rev_stars in (select min(rev_stars) from rating))


--15 write a SQL query to find the movies directed by 'James Cameron'. Return movie title. 
select mov_title from movie
where mov_id in (select mov_id from movie_direction
				where dir_id in (select dir_id from director
								where dir_fname + ' ' + dir_lname = 'James Cameron'))

--16 Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies.
select mov_title from movie
where mov_id in (select mov_id from movie_cast
					where act_id in (select act_id from movie_cast 
									 group by act_id having count(act_id) >= 2))


									 --join--
--1  write a SQL query to find the name of all reviewers who have rated their ratings with a NULL value. Return reviewer name.
select rev_stars, rev_name from rating ra
join reviewer re on ra.rev_id = re.rev_id
where rev_stars is null

--2  write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role. 
select act_fname, act_lname, role, mov_title from movie m
join movie_cast mc on m.mov_id = mc.mov_id
join actor a on a.act_id = mc.act_id
where mov_title = 'Annie Hall'

--3  write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.
select dir_fname, dir_lname, mov_title from movie m
join movie_direction md on m.mov_id = md.mov_id
join director d on md.dir_id = d.dir_id
where mov_title = 'Eyes Wide Shut'

--4  write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title.
select dir_fname, dir_lname, mov_title, role from movie_cast mc
join movie_direction md on mc.mov_id = md.mov_id
join director d on d.dir_id = md.dir_id
join movie m on m.mov_id = mc.mov_id
where role = 'Sean Maguire'

--5  write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.). 
	--Return actor first name, last name, movie title and release year.
select act_fname, act_lname, mov_title, mov_dt_rel, mov_year from movie m
join movie_cast mc on m.mov_id = mc.mov_id
join actor a on a.act_id = mc.act_id
where mov_year not between 1990 and 2000

--6  write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title. 
	--Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.
select dir_fname, dir_lname, count(gen_title) as num_gen_mov from movie_genres mg
join genres g on mg.gen_id = g.gen_id
join movie_direction md on md.mov_id = mg.mov_id
join director d on md.dir_id = d.dir_id
group by dir_fname, dir_lname, gen_title

--7  write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.
select mov_title, mov_year, gen_title from movie m
join movie_genres mg on mg.mov_id = m.mov_id
join genres g on g.gen_id = mg.gen_id

--8  write a SQL query to find all the movies with year, genres, and name of the director.
select mov_year, gen_title, dir_fname, dir_lname from movie m
join movie_genres mg on mg.mov_id = m.mov_id
join genres g on g.gen_id = mg.gen_id
join movie_direction md on md.mov_id = m.mov_id
join director d on d.dir_id = md.dir_id

--9  write a SQL query to find the movies released before 1st January 1989. 
	 --Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director.
select mov_title, mov_dt_rel, YEAR(mov_dt_rel) as rel_year, mov_time, dir_fname, dir_lname from movie m 
join movie_direction md on md.mov_id = m.mov_id
join director d on md.dir_id = d.dir_id
where mov_dt_rel < DATETIMEFROMPARTS (1989, 1, 1, 0, 0, 0, 0)
order by mov_dt_rel desc

--10 write a SQL query to compute the average time and count number of movies for each genre. Return genre title, average time and number of movies for each genre.
select g.gen_id, avg(mov_time) as avg_time, COUNT(g.gen_id) as num_mov from genres g
join movie_genres mg on mg.gen_id = g.gen_id
join movie m on m.mov_id = mg.mov_id
group by g.gen_id

--11 write a SQL query to find movies with the lowest duration. Return movie title, movie year, director first name, last name, actor first name, last name and role.
select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role from movie m
join movie_direction md on m.mov_id = md.mov_id
join movie_cast mc on mc.mov_id = m.mov_id
join actor a on a.act_id = mc.act_id
join director d on d.dir_id = md.dir_id
and mov_time in (select min(mov_time) from movie)

--12 write a SQL query to find those years when a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. Return move year. 
select mov_year from rating r
join movie m on m.mov_id = r.mov_id
where rev_stars in (3, 4)
order by mov_year

--13 write a SQL query to get the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.
select rev_name, mov_title, rev_stars from reviewer re
join rating r on r.rev_id = re.rev_id
join movie m on m.mov_id = r.mov_id
order by rev_name, mov_title, rev_stars

--14 write a SQL query to find those movies that have at least one rating and received highest number of stars. Sort the result-set on movie title. 
	--Return movie title and maximum review stars.
select mov_title, rev_stars from rating r
join movie m on m.mov_id = r.mov_id 
where num_o_ratings >= 1 and rev_stars in (select MAX(rev_stars) from rating)
order by mov_time

--15 write a SQL query to find those movies, which have received ratings. Return movie title, director first name, director last name and review stars.
select mov_title, dir_fname, dir_lname, rev_stars from rating r
join movie m on m.mov_id = r.mov_id
join movie_direction md on md.mov_id = m.mov_id
join director d on d.dir_id = md.dir_id
where rev_stars is not null

--16 Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies.
select mov_title from movie
where mov_id in (select mov_id from movie_cast
					where act_id in (select act_id from movie_cast 
									 group by act_id having count(act_id) >= 2))

select mov_title, act_fname, act_lname, role from movie m
join movie_cast mc on mc.mov_id = m.mov_id
join actor a on a.act_id = mc.act_id
where a.act_id in (select act_id from movie_cast 
									 group by act_id having count(act_id) >= 2)