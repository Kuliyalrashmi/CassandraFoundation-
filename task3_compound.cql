-- Ensure you are using the killrvideo keyspace
use killrVideo

-- Drop your videos_by_tag table that you created in the previous exercise
drop table videos_by_tag

-- Modify the following command to create a new videos_by_tag table partitioned based on the tag. The table should also store the rows of each partition so that the newest videos are listed first within the partition.
create table videos_by_tag(
    tag text,
    video_id uuid,
    added_date timestamp,
    title text,
    primary key (tag ,added_date, video_id) 
) with CLUSTERING ORDER by (added_date desc , video_id asc)


-- Import the videos_by_tag.csv again via the COPY command
copy videos_by_tag(tag, video_id,added_date, title ) from '/workspace/ds201-lab01/data-files/videos-by-tag.csv' with header = true;


-- Perform a SELECT * query on videos_by_tag.
select * from videos_by_tag;

-- Execute your query again, but list the oldest videos first.
drop table videos_by_tag;

CREATE TABLE videos_by_tag (
    tag text,
    video_id uuid,
    added_date timestamp,
    title text,
    PRIMARY KEY (tag, added_date, video_id)
) WITH CLUSTERING ORDER BY (added_date ASC, video_id ASC);


-- Change your query to restrict the partition key value to 'cassandra'.
select * from videos_by_tag where tag = 'cassandra';

-- Change your query to retrieve videos made in 2013 or later
select * from videos_by_tag where added_date > toTimeStamp('2013-01-01') allow filtering;

