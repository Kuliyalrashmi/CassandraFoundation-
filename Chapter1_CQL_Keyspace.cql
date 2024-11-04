-- keyspace  : Is is similar to concept of database in relational model... it  holds tables and defines replication strategies.

-- Creating keyspace :
create keyspace if not exists students with replication = {'class': 'SimpleStrategy' ,'r
eplication_factor' : 3};

-- class : replication strategy that is used in data model...
    -- SimpleStrategy : It is used when layout of datacentre is unknown .  It is a simple strategy that is recommended for multiple nodes over multiple racks in a single data center.
    -- NetworkTopologyStrategy : It is the strategy in which we can store multiple copies of data on different data centers as per need.

-- replication_factor : It tells the no of nodes that hold the copies of data sent by client



-- Creating Simple Strategy Based Keyspace
create keyspace if not exists simp_strat_keyspace with replication =  {
    'class' : 'SimpleStrategy',
    'replication_factor' : 3 
};


-- Creating NetworkTopology Strategy Keyspace
create keyspace if not exists net_topo_strat_keyspace with replication = {
    'class' : 'NetworkTopologyStrategy',
    'dc1' : 3, -- it says that there is a replication factor of 3 in datacentre1.
    'dc2' : 2 -- it says that there is a replication factor of 2 in datacentre2.
};


-- to ensure data engrity (data must write in commit log)
create keyspace temp with replication  = {
    'class' : 'NetworkTopologyStrategy',
    'dc1' : 2,
    'dc2' : 3
} with durable_writes = true;


-- to use a certain keyspace  : to be in a certain keyspace , entre name of keyspace using 'use' keyword 
USE temp;
use net_topo_strat_keyspace;


-- alter keyspace : any modification to kespace strategies and attributes
alter keyspace if exists net_topo_strat_keyspace with replication = {
    'class' : 'NetworkTopologyStrategy'
    'dc1' : 3,
    'dc2' : 2,
    'dc3' : 3
}with durable_writes = false;


-- defining transient replication : 
create keyspace some_keyspace with replication = {
    'class' : 'NetworkTopologyStrategy',
    'dc1' : '3/1',
    'dc2' : '5/2'
} with durable_writes = true;


-- to delete certain keyspace : 'drop'
drop keyspace temp;


-- to understand the keyspace: 
desc keyspace_name;

-- to get list of al keyspaces :
desc keyspaces;