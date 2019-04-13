# Create Table for storing Tweets with metadata around candidate
CREATE TABLE tweets_preagg(
	party varchar(255),
	constituency varchar(255),
	counciller BOOLEAN,
	name varchar(255),
	user_id bigint,
	screen_name varchar(255),
	created_date date,
	created_time time,
	tweet_id bigint,
	tweet_text varchar(500),
	in_reply_to_status_id bigint,
	retweet_count int,
	favorite_count int, 
	favorited BOOLEAN, 
	retweeted BOOLEAN
);  

# DB ALTER statements to support 😌 🇬🇧 ❤️  
# 😂 ✌️ at database, table and column levels

ALTER DATABASE
db1222856_ie_election_2019
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

ALTER TABLE
tweets_preagg
CONVERT TO CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

ALTER TABLE
tweets_preagg
CHANGE tweet_text tweet_text
VARCHAR(500)
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

ALTER TABLE tweets_preagg DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

# Test Insert into Tweets Table
INSERT INTO tweets_preagg(party, constituency, counciller, 
	name, user_id, screen_name, created_date, created_time, tweet_id, tweet_text, 
	in_reply_to_status_id, retweet_count, favorite_count, favorited, retweeted)
VALUES ('Social Democrats', 'Dublin Central', false, 'Ellie Kisyombe', 1034091560126873600, 
	'elliekisyombe1', '2019-03-02', '12:10:12', 3348219707, 	 
	'It is with great peled! ☺️🎉 🎇… https:leasure to announce it to you that we made it to The Irish Cafe Awards#keepingthelagancy#Rightton… https://t.co/lGEGlgChS2',
	null, 1, 6, false, false);