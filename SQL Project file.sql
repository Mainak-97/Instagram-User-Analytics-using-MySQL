# Project file:- Instagram User Analytics

use ig_clone;

### A) Marketing Analysis: ###

# Task 1:- Loyal User Reward: Identify the five oldest users on Instagram

select *, rank() over(order by created_at)
as Rank_No
from users limit 5;

# Task 2:- Loyal User Reward: Task: Identify users who have never posted a single photo on Instagram.

select users.id, users.username from users
left join photos
on users.id = photos.user_id
where photos.id is null;

# Task 3:- Contest Winner Declaration: Identify user with the most likes on a single photo.

select users.id as user_id, users.username, photos.id as photo_id, photos.image_url,
count(likes.user_id) as Total_likes
from photos
inner join likes on
likes.photo_id = photos.id
inner join users on
photos.user_id = users.id
group by photos.id order by Total_likes
desc limit 1;

# Task 4:- Hashtag Research: Identify and suggest the top five most commonly used hashtags on the platform.

select tag_name, count(tag_name) as Total_used
from tags join photo_tags
on tags.id = photo_tags.tag_id
group by id order by Total_used
desc limit 5;

# Task 5:- Ad Campaign Launch: Determine the day of the week when most users register on Instagram.

select dayname(created_at) as Day,
count(*) as Total from users
group by Day order by Total desc limit 2;

### B) Investor Metrics: ###

# Task 1:- User Engagement: 
# a) Calculate the average number of posts per user on Instagram. 
select user_id, avg(id) as avg_post from photos group by user_id;

# b) Provide the total number of photos on Instagram divided by the total number of users. 
select round
((select count(*) from photos) / (select count(*) from users),2)
as Average_post;

# Task 2:-Bots & Fake Accounts: Identify users (potential bots) who have liked every single photo on the site.
select users.username,
count(*) as Total_likes
from users join likes on
users.id = likes.user_id
group by user_id
having Total_likes = (select count(*) from photos);
