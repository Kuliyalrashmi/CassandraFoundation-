

-- Tables :  Tables, also called column families Cassandra. It store data in a set of rows and contain a primary key and a set of columns.


--  creating simple table : 

create table if not exists records(
    id uuid primary key,    
    roll_no int,
    salary float,
    present boolean,
    admission_date timestamp,
    phone_number bigint,
    email text,
    subject_marks map<text,int>,
    documents blob
);

-- you must have to define a primary key.
-- all the datatypes available are mentioned.



--  to create a table with composite primary key (complex primary key)
create table if not exists records2(
    id uuid ,    
    roll_no int,
    percentage float,
    present boolean,
    admission_date timestamp,
    phone_number bigint,
    email text,
    subject_marks map<text,int>,
    documents blob,
    primary key(id , admission_date)
);

-- static coloumns : shared across all rows in coloumn. remain same for all rows within partition.
create table if not exists records3(
    id uuid ,    
    roll_no int,
    percentage float,
    present boolean STATIC,
    admission_date timestamp,
    phone_number bigint,
    email text,
    subject_marks map<text,int>,
    documents blob,
    primary key(id , admission_date)
);

-- to get all the tables in a keyspace :
desc tables;



-- tables also comes with some options : 
    -- clustering order by  : allow you to specify the sort order of clustering coloumns.
create table if not exists records4(
    id uuid ,    
    roll_no int,
    percentage float,
    present boolean STATIC,
    admission_date timestamp,
    phone_number bigint,
    email text,
    subject_marks map<text,int>,
    documents blob,
    primary key(id , admission_date)
) with clustering order by (admission_date ASC);


    -- comments  : to specify some information about table
create table if not exists monkey_species(
    species text PRIMARY KEY,
    common_name text,
    population varint,
    average_size int
) with comment = 'Important biological records';



    -- Compaction :  It refers to the method of merging and reorganizing data on disk to improve read performance, reclaim storage space, and maintain efficient data retrieval.

-- types of Strategies : 
    -- Leveled Compaction Strategy (LCS): This strategy aims to keep a balanced number of SSTables at each level and minimizes the number of reads required for queries. It is well-suited for workloads with high write and read rates.
    -- Size-Tiered Compaction Strategy (STCS): SSTables of similar sizes are merged, which can lead to better write performance but may result in more read amplification.
    -- Time Window Compaction Strategy (TWCS): This strategy is designed for time-series data, allowing for efficient compaction of data that is written within specific time windows.

CREATE TABLE timeline (
    userid uuid,
    posted_month int,
    posted_time uuid,
    body text,
    posted_by text,
    PRIMARY KEY (userid, posted_month, posted_time)
) WITH compaction = { 'class' : 'LeveledCompactionStrategy' };





-- telling you about the concept of partition key and clustering keys

-- whenever you write primary key(col1 , col2 , col3) , then col1 is always be your partition key which mean data got partitioned to different nodes based on that col1 , while col2 and col3 are clustering keys which means data is order in a particular partition according to col2 and col3

create table is not exists temp(
    id uuid,
    city text,
    pin int,
    primary key(city , id, pin) -- this means partition is done on basis of city , and teh records of that partition first ordered with respect to id and then pin.
)


-- we can also create complex partition key
create table is not exists temp(
    id uuid,
    city text,
    pin int,
    state text,
    primary key((city,text) , id, pin) -- this means partition is done on basis of complex hash created by city and state , and teh records of that partition first ordered with respect to id and then pin.
)



--  to insert values.
INSERT INTO temp(id, city , pin, state) values (uuid(), 'New York', 10001, 'NY');
INSERT INTO temp(id, city, pin, state) VALUES (uuid(), 'Los Angeles', 90001, 'CA');
INSERT INTO temp(id, city, pin, state) VALUES (uuid(), 'Chicago', 60601, 'IL');
INSERT INTO temp(id, city, pin, state) VALUES (uuid(), 'Miami', 33101, 'FL');
INSERT INTO temp(id, city, pin, state) VALUES (uuid(), 'Dallas', 75201, 'TX');


-- to querry all
SELECT * from  temp;

-- while querrying you have to ensure that condition must relat regarding partition or primary key. any querry that will not able to queery with help of partition key will throw error.

-- querry using partition key
SELECT * FROM temp WHERE city = 'Los Angeles' AND state = 'CA';

-- queery using partition and clustering columns
SELECT * FROM temp WHERE city = 'Los Angeles' AND state = 'CA' AND id = some_uuid_value;


-- queery without partition key
SELECT * FROM temp WHERE city = 'Los Angeles'; -- thorws error

-- to work with queery without partition key, we have to use 'allow filtering'
SELECT * FROM temp WHERE city = 'Los Angeles' allow filtering;



-- alter table commands : 


-- simple alter table with check 
alter table if exists temp `some_instructions`;

-- add a single new coloumn
alter table if exists temp add zipcode int; 

-- add multiple coloumns
alter table if exists temp add (country text , continent text);

-- add coloumns if not exists
alter table if exists temp add if not exists timezone text;

-- dop coloumns
alter table temp drop zipcode;

--drop mulitple columns 
alter table temp DROP country, continent;

-- dop coloumn if exist
alter table temp DROP IF EXISTS timezone;

-- coloumn rename
alter table temp rename state to region; 

-- renaming multiple coloumns 
alter table temp RENAME city TO locality and pin to postal_code;


-- to set compaction strategy to table
alter table temp with compaction  = {'class' : 'LeveledCompactionStrategy'};

--  to set default ttl (time to live)
alter table temp with default_time_to_live = 86400;


-- set comment to table 
alter table temp with comment = 'this table is used to explain altering experiment of cassandra';


-- to delete tabel 
drop table temp;

-- to remove only records from table
truncate table temp;

