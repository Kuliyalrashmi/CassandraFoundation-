--  create a keyspace called killrvideo. Use SimpleStrategy for the replication class with a replication factor of one.
create keyspace KillrVideo with replication = { 'class' : 'SimpleStrategy' , 'replication_factor' : 1};

-- switch to the newly created keyspace with the USE command
USE killrVideo;


-- Create a single table called videos with the same structure as shown above. video_id is the primary key.
create table videos(
  video_id timeuuid,
  added_date timestamp,
  Title text,
  primary key(video_id)
);

--  Manually insert a single record using into the table using INSERT command. 
insert into videos(video_id , added_date , title) values (1645ea59-14bd-11e5-a993-8138354b7e31 , toTimeStamp('2014-01-29'),'Cassandra History');
insert into videos(video_id , added_date , title) values (245e8024-14bd-11e5-9743-8238356b7e32 , toTimeStamp('2012-04-03'),'Cassandra & SSDs');
insert into videos(video_id , added_date , title) values (3452f7de-14bd-11e5-855e-8738355b7e3a , toTimeStamp('2013-03-17'),'Cassandra Intro' );
insert into videos(video_id , added_date , title) values (4845ed97-14bd-11e5-8a40-8338255b7e33 , toTimeStamp('2012-10-16'),'DataStax DevCenter');
insert into videos(video_id , added_date , title) values (5645f8bd-14bd-11e5-af1a-8638355b8e3a , toTimeStamp('2013-04-16'),'What is DataStax Enterprise?');


-- Write a select statement to verify your record was inserted
select * from videos;

-- Let's remove the data you inserted using the TRUNCATE command.

TRUNCATE videos;

-- Execute the following command to import data into your videos table.
COPY videos(video_id, added_date, title) FROM '/workspace/ds201-lab01/data-files/videos.csv' WITH HEADER=TRUE;


-- Use SELECT to verify the data loaded correctly
select * from videos;


-- Use SELECT to COUNT(*) the number of imported rows. It should match the number of rows COPY reported as imported
select count(*) from videos;

-- leave cqlsh
quit;