use Netflix;
select * from devices as d;
select * from movies as m ;
select * from ratings as r ;
select * from subscriptions as s;
select * from users as u ;
select * from watch_history as h;

#1.	How many users signed up in each month of 2023?

select Date_format(start_date,'%Y-%m') as Month_wise,count(*) as 'Subscribers'
from subscriptions
where Year(start_date) = 2023
group by Month_wise
order by Month_wise;



#2.	Which 5 countries have the highest number of users?

select country,count(*) as 'users'
from users
group by country
order by users DESC
LIMIT 5;



#3.	How many users are currently on an active subscription?

select Date_format(end_date,'%Y-%m') as CurrentMonth,count(*) Active_users
from subscriptions
where Year(end_date) = 2024 and month(end_date) = 06
group by CurrentMonth;



#4.	What is the average subscription duration per plan (in days)?

select avg(datediff(end_date,start_date)) as Avg_Sub_Duration,plan
from subscriptions
group by plan
order by Avg_Sub_Duration;



#5.	List users who haven’t watched any movies yet?

select u.user_id
from users as u
left join watch_history as w
on u.user_id = w.user_id
where watch_date is null;




#6.	What are the top 5 most-watched movies of all time?
select m.title,count(w.movie_id) as mostwatched
from movies as m 
left join 
watch_history as w 
on m.movie_id = w.movie_id
group by m.title
having  mostwatched > 1
order by mostwatched DESC
limit 5;


#7.	Which genre has the highest total watch count?

select genre,count(*) watch_count
from movies
group by genre
order by watch_count desc
limit 1;


#8.	What is the average movie duration by genre?

select genre, avg(duration_min) as Avg_duration
from movies
group by genre
order by Avg_duration desc;



#9.	Which movies have never been watched by any user?

select m.title,w.movie_id
from movies as m
left join watch_history as w
on m.movie_id = w.movie_id
where w.movie_id is null;

#10. Which movie has the highest average rating ?

select m.title,m.movie_id, avg(r.rating) as highest_average_rating
from ratings as r
left join 
movies as m 
on m.movie_id = r.movie_id
group by m.movie_id,m.title
order by highest_average_rating desc
limit 1;


#11. How many users use each type of device (e.g., Mobile, Smart TV, etc.)?

select device_type,count(*) as Total_users
from devices 
group by device_type
order by Total_users;


#12. Which operating system is most used among users?

select os,count(*) as Most_used
from devices 
group by os
order by Most_used desc
limit 1;


#13. How many users rated a movie but didn’t watch it?

select count(distinct(r.user_id)) as users_didnt_watch
from ratings as r 
left join 
watch_history as w 
on r.user_id = w.user_id AND r.movie_id = w.movie_id
where watch_date is null;


#14. Which day of the week sees the most streaming activity?
select dayname(w.watch_date) as weekdayname ,dayofweek(w.watch_date) as weekday_num,sum(m.duration_min) as Total_streaming
from movies as m
right join
watch_history as w 
on w.movie_id = m.movie_id
group by dayname(w.watch_date),dayofweek(w.watch_date)
order by weekdayname,Total_streaming desc
limit 1;


#15. Which month in 2024 had the highest total movie views?

select monthname(watch_date) as Name_of_month,count(movie_id) as Total_Movie_views
from watch_history
group by monthname(watch_date)
order by Total_Movie_views desc
limit 1;

#16. Find the average number of movies watched per user.
select avg(mve_count) as AVG_mve_count
from (select user_id,count(movie_id) as mve_count
from watch_history
group by user_id
) as Avg_mve_watched;


#17. Which users have watched the most movies in the last 3 months

select user_id,count(distinct month(watch_date)) as Active_during_last
from watch_history
where watch_date between '2024-03-01' and '2024-05-31'
group by user_id
order by user_id;

#18. Find the top 3 most active users by number of ratings.

select user_id,count(rating_id) as Active_users
from ratings
group by user_id
order by Active_users desc
Limit 3;


#19. What is the average rating given by users on each subscription plan?

select s.plan,avg(r.rating) as Avg_rating
from subscriptions as s 
left join
ratings as r
on r.user_id = s.user_id
group by s.plan
order by Avg_rating desc;












