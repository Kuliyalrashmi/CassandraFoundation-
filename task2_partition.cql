-- Switch to the killrvideo keyspace via the USE command
USE KillrVideo;

-- Execute the following command to view the metadata for the videos table you created earlier.
describe table video;

-- Execute the following query to view the partitioner token value for each video id.
select token(video_id) , video_id from videos;

-- Your mission, should you choose to accept it, is to write a CREATE TABLE statement that will store this data partitioned by tags. With this given data set, there should be two partitions, one for each tag. Call your table videos_by_tag.
create table videos_by_tag(
    tag text,
    video_id uuid,
    added_date timestamp,
    title text,
    primary key (tag,video_id)
);


-- Execute the COPY command to import the videos-by-tag.csv data.
copy videos_by_tag(tag, video_id , added_date , title) from '/workspace/ds201-lab01/data-files/videos-by-tag.csv' with header  = true;


-- Verify CQL imported your data correctly by writing a SELECT * command.
select * from videos_by_tag;

-- Write a SELECT statement to retrieve all rows tagged with cassandra.
 select * from videos_by_tag where tag = 'cassandra';



--  Now, find all videos tagged with datastax (similar to the previous query).
select * from videos_by_tag where tag = 'datastax';


--  Finally, write a query to retrieve the video having a title of Cassandra Intro
select * from  videos_by_tag where title = "Cassandra Intro" ALLOW FILTERING; 