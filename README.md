# 🎬 Netflix-Streaming-Analysis-using-SQL
![image](https://github.com/user-attachments/assets/7a7b3e91-232f-4dbf-a26e-29093ebd1ae0)
A portfolio project that explores user behavior, subscription trends, movie ratings, and content consumption patterns using SQL queries on a simulated Netflix-style dataset. Covers key business questions like top watched movies, genre popularity, most active users, and average ratings by plan.

## 📌 Project Overview

This project focuses on analyzing data from a Netflix-style streaming platform using SQL. Through 19 insightful queries, it uncovers key business and user engagement metrics such as subscription trends, most-watched content, user behavior, ratings distribution, and platform usage. The goal is to demonstrate practical SQL skills and the ability to derive meaningful insights from relational databases.

## 📊 Dataset Overview
The dataset is a simulated Netflix-style database composed of the following relational tables:

- users – User ID, name, country, and demographic data
- subscriptions – Subscription details including plan type, start and end dates
- movies – Movie metadata including title, genre, and duration
- watch_history – Movie watch records linked to users and dates
- ratings – User-provided movie ratings
- devices – Device and operating system information per user
- The dataset reflects real-world streaming service scenarios with relationships between users, content, and activity.

## Project structure 
- **Database Setup**: Creation of the `Netflix` database.
- **Importing data**: Importing sample csv file into tables.
- **Business Problems**: Solving 19 specific business problems using SQL queries.

## Database Setup
```sql
CREATE DATABASE `Netflix`;
```
## Data Import

## Business Problems Solved


### 1.	How many users signed up in each month of 2023?
```sql
select Date_format(start_date,'%Y-%m') as Month_wise,count(*) as 'Subscribers'
from subscriptions
where Year(start_date) = 2023
group by Month_wise
order by Month_wise;
```

### Output:
<img width="148" alt="image" src="https://github.com/user-attachments/assets/f30de5b1-81ad-4723-997f-dd7625a36945" />

### 2. Which 5 countries have the highest number of users?
```sql
select country,count(*) as 'users'
from users
group by country
order by users DESC
LIMIT 5;
```
### Output:
<img width="102" alt="image" src="https://github.com/user-attachments/assets/1b689f96-76f9-4a83-9f14-657bb02d32fb" />

### 3.	How many users are currently on an active subscription?
```sql
select Date_format(end_date,'%Y-%m') as CurrentMonth,count(*) Active_users
from subscriptions
where Year(end_date) = 2024 and month(end_date) = 06
group by CurrentMonth;
```
### Output:
<img width="175" alt="image" src="https://github.com/user-attachments/assets/bfafa2ff-a3fc-4494-a299-e92bf3970751" />


### 4.	What is the average subscription duration per plan (in days)?
```sql
select avg(datediff(end_date,start_date)) as Avg_Sub_Duration,plan
from subscriptions
group by plan
order by Avg_Sub_Duration;
```
### Output:
<img width="164" alt="image" src="https://github.com/user-attachments/assets/68af1620-0b4d-47bb-b3c9-310a28bd0ca6" />


### 5.	List users who haven’t watched any movies yet?
```sql
select u.user_id
from users as u
left join watch_history as w
on u.user_id = w.user_id
where watch_date is null;
```

### Output:
<img width="63" alt="image" src="https://github.com/user-attachments/assets/708be7d7-72fb-489b-a605-d5ca13ff8fd8" />

### 6.	What are the top 5 most-watched movies of all time?
```sql
select m.title,count(w.movie_id) as mostwatched
from movies as m 
left join 
watch_history as w 
on m.movie_id = w.movie_id
group by m.title
having  mostwatched > 1
order by mostwatched DESC
limit 5;
```
### Output:
<img width="142" alt="image" src="https://github.com/user-attachments/assets/c5520dc2-371a-4f96-a48e-c14f6ca028dd" />


### 7.	Which genre has the highest total watch count?
```sql
select genre,count(*) watch_count
from movies
group by genre
order by watch_count desc
limit 1;
```

### Output:
<img width="117" alt="image" src="https://github.com/user-attachments/assets/f6a6151d-e977-497d-a97a-dbaf86d950aa" />

### 8.	What is the average movie duration by genre?
```sql
select genre, avg(duration_min) as Avg_duration
from movies
group by genre
order by Avg_duration desc;
```
### Output:
<img width="155" alt="image" src="https://github.com/user-attachments/assets/03902d05-237c-4976-a543-bf80953c8f28" />


### 9.	Which movies have never been watched by any user?
```sql
select m.title,w.movie_id
from movies as m
left join watch_history as w
on m.movie_id = w.movie_id
where w.movie_id is null;
```
### Output:
<img width="98" alt="image" src="https://github.com/user-attachments/assets/5640ba48-d1eb-4fdb-915b-ab56003e7a87" />
- Null because there is no movie that never been watched.

### 10. Which movie has the highest average rating ?
```sql
select m.title,m.movie_id, avg(r.rating) as highest_average_rating
from ratings as r
left join 
movies as m 
on m.movie_id = r.movie_id
group by m.movie_id,m.title
order by highest_average_rating desc
limit 1;
```
### Output:
<img width="247" alt="image" src="https://github.com/user-attachments/assets/f94d19f9-498c-44fb-924e-487342616b75" />

### 11. How many users use each type of device (e.g., Mobile, Smart TV, etc.)?
```sql
select device_type,count(*) as Total_users
from devices 
group by device_type
order by Total_users;
```
### Output:
<img width="141" alt="image" src="https://github.com/user-attachments/assets/d6dde76e-9d16-46f4-97b4-e61951eedce6" />

### 12. Which operating system is most used among users?
```sql
select os,count(*) as Most_used
from devices 
group by os
order by Most_used desc
limit 1;
```
### Output:
<img width="141" alt="image" src="https://github.com/user-attachments/assets/d6dde76e-9d16-46f4-97b4-e61951eedce6" />

### 13. How many users rated a movie but didn’t watch it?
```sql
select count(distinct(r.user_id)) as users_didnt_watch
from ratings as r 
left join 
watch_history as w 
on r.user_id = w.user_id AND r.movie_id = w.movie_id
where watch_date is null;
```
### Output:
<img width="124" alt="image" src="https://github.com/user-attachments/assets/4a78303a-1616-41cb-a42e-1013e8bfb9f3" />

### 14. Which day of the week sees the most streaming activity?
```sql
select dayname(w.watch_date) as weekdayname ,dayofweek(w.watch_date) as weekday_num,sum(m.duration_min) as Total_streaming
from movies as m
right join
watch_history as w 
on w.movie_id = m.movie_id
group by dayname(w.watch_date),dayofweek(w.watch_date)
order by weekdayname,Total_streaming desc
limit 1;
```
### Output:
<img width="263" alt="image" src="https://github.com/user-attachments/assets/5c85cc2c-25be-43ef-a864-54641c9e8b90" />

### 15. Which month in 2024 had the highest total movie views?
```sql
select monthname(watch_date) as Name_of_month,count(movie_id) as Total_Movie_views
from watch_history
group by monthname(watch_date)
order by Total_Movie_views desc
limit 1;
```
### Output:
<img width="199" alt="image" src="https://github.com/user-attachments/assets/5c185b64-db83-496d-b9a8-62e1d299fffd" />

### 16. Find the average number of movies watched per user.
```sql
select avg(mve_count) as AVG_mve_count
from (select user_id,count(movie_id) as mve_count
from watch_history
group by user_id
) as Avg_mve_watched;
```
### Output:
<img width="98" alt="image" src="https://github.com/user-attachments/assets/6222e955-7152-4cec-9c45-0c38b0891479" />

### 17. Which users have watched the most movies in the last 3 months
```sql
select user_id,count(distinct month(watch_date)) as Active_during_last
from watch_history
where watch_date between '2024-03-01' and '2024-05-31'
group by user_id
order by user_id;
```
### Output:
<img width="164" alt="image" src="https://github.com/user-attachments/assets/b886616b-1a78-4961-a6fb-81b51900990a" />
<img width="164" alt="image" src="https://github.com/user-attachments/assets/568331be-f0ad-4da2-b318-631cea2343a5" />
<img width="164" alt="image" src="https://github.com/user-attachments/assets/c78ad1cb-b884-482a-b7eb-4b2701ac9c24" />
<img width="164" alt="image" src="https://github.com/user-attachments/assets/7cc25eaa-54ec-4574-a9a2-76727e78b553" />
<img width="164" alt="image" src="https://github.com/user-attachments/assets/67aac63e-aed0-434a-9a9e-64588571a765" />


### 18. Find the top 3 most active users by number of ratings.
```sql
select user_id,count(rating_id) as Active_users
from ratings
group by user_id
order by Active_users desc
Limit 3;
```
### Output:
<img width="122" alt="image" src="https://github.com/user-attachments/assets/d28831b6-cb96-452e-9423-7733bfcbc1ce" />

### 19. What is the average rating given by users on each subscription plan?
```sql
select s.plan,avg(r.rating) as Avg_rating
from subscriptions as s 
left join
ratings as r
on r.user_id = s.user_id
group by s.plan
order by Avg_rating desc;
```
### Output:
<img width="122" alt="image" src="https://github.com/user-attachments/assets/1ad502ad-7bfe-4850-a456-cbfd04fab0ee" />


## 🔧 Tools Used
- SQL (MySQL) – Core analysis performed using SQL queries.

## 💡 Skills Demonstrated

- Data Cleaning & Aggregation
- Conditional Filtering
- Joins (INNER, LEFT, RIGHT)
- Window and Aggregate Functions
- GROUP BY, HAVING, CASE WHEN
- Performance Optimization using subqueries

## ✅ Conclusion
This project demonstrates how SQL can be used to generate meaningful insights from streaming platform data. By addressing real-world business questions, it highlights user engagement patterns, content trends, and subscription behaviors. It serves as a practical showcase of SQL skills for data analysis and decision-making.

## 📬 Contact

📧 akhilmadanu21@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/akhil-madanu/)  







