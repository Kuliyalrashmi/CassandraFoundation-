-- creating employees tables for performing DML statements

CREATE TABLE employees (
    id UUID PRIMARY KEY,              -- Unique identifier for each employee (partition key)
    name TEXT,                        -- Employee name
    age INT,                          -- Employee age
    department TEXT,                  -- Department name
    salary DECIMAL,                   -- Employee salary
    join_date TIMESTAMP,              -- Date when the employee joined
    skills SET<TEXT>,                 -- Set of skills (e.g., 'Python', 'SQL')
    projects MAP<TEXT, TEXT>,         -- Map of project name to project status (e.g., 'Project_X' : 'Completed')
    languages LIST<TEXT>,             -- List of languages (e.g., ['English', 'Spanish'])
    address FROZEN<MAP<TEXT, TEXT>>   -- Frozen map of address details (e.g., 'city' : 'New York', 'country' : 'USA')
);


-- populating data into table 
INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Alice', 30, 'Engineering', 80000, '2022-01-15', {'Python', 'Java'}, {'Project_A': 'Completed'}, ['English', 'Spanish'], {'city': 'New York', 'country': 'USA'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Bob', 25, 'Marketing', 55000, '2021-05-10', {'SEO', 'Content Writing'}, {'Campaign_X': 'In Progress'}, ['English'], {'city': 'San Francisco', 'country': 'USA'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Charlie', 35, 'Engineering', 95000, '2019-09-23', {'Python', 'C++', 'Scala'}, {'Project_B': 'Completed', 'Project_C': 'In Progress'}, ['English', 'French'], {'city': 'Austin', 'country': 'USA'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Diana', 40, 'Sales', 70000, '2020-03-12', {'Negotiation', 'CRM'}, {'Account_Y': 'Ongoing'}, ['English', 'German'], {'city': 'Berlin', 'country': 'Germany'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Eve', 28, 'Engineering', 60000, '2022-07-01', {'JavaScript', 'React', 'CSS'}, {'Website_Revamp': 'Completed'}, ['English', 'Mandarin'], {'city': 'Beijing', 'country': 'China'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Frank', 33, 'HR', 50000, '2018-11-30', {'Recruitment', 'People Management'}, {}, ['English'], {'city': 'Chicago', 'country': 'USA'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Grace', 29, 'Finance', 85000, '2021-02-21', {'Financial Modeling', 'Excel'}, {'Quarterly_Review': 'Completed'}, ['English', 'French'], {'city': 'Toronto', 'country': 'Canada'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Henry', 31, 'Product', 78000, '2022-08-15', {'Product Management', 'Agile'}, {'Product_Launch': 'In Progress'}, ['English', 'Japanese'], {'city': 'Tokyo', 'country': 'Japan'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Ivy', 27, 'Engineering', 67000, '2023-01-10', {'Python', 'Data Analysis'}, {'Analytics_Tool': 'In Progress'}, ['English', 'Korean'], {'city': 'Seoul', 'country': 'South Korea'});

INSERT INTO employees (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Jack', 45, 'Management', 120000, '2017-04-18', {'Leadership', 'Strategy'}, {'Company_Growth': 'Ongoing'}, ['English'], {'city': 'London', 'country': 'UK'});




-- to get all records 
select * from employees;
select json * from employees; -- to get result in json format


-- to get specific columns
select name, age department, salary from employees;
select json name, age department, salary from employees; -- result in json format

-- to get distinct values 
select distinct department from employees; -- this will not work because partition key is id  and distinct only work in favour with partition / primary key

-- to do this we have to create new table (as we cannot alter the primary key) to add department as primary/partition key
CREATE TABLE employees2 (
    id UUID ,              -- Unique identifier for each employee (partition key)
    name TEXT,                        -- Employee name
    age INT,                          -- Employee age
    department TEXT,                  -- Department name
    salary DECIMAL,                   -- Employee salary
    join_date TIMESTAMP,              -- Date when the employee joined
    skills SET<TEXT>,                 -- Set of skills (e.g., 'Python', 'SQL')
    projects MAP<TEXT, TEXT>,         -- Map of project name to project status (e.g., 'Project_X' : 'Completed')
    languages LIST<TEXT>,             -- List of languages (e.g., ['English', 'Spanish'])
    address FROZEN<MAP<TEXT, TEXT>>,  -- Frozen map of address details (e.g., 'city' : 'New York', 'country' : 'USA')
    primary key((department) , name, age , salary)
);

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Alice', 30, 'Engineering', 80000, '2022-01-15', {'Python', 'Java'}, {'Project_A': 'Completed'}, ['English', 'Spanish'], {'city': 'New York', 'country': 'USA'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Bob', 25, 'Marketing', 55000, '2021-05-10', {'SEO', 'Content Writing'}, {'Campaign_X': 'In Progress'}, ['English'], {'city': 'San Francisco', 'country': 'USA'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Charlie', 35, 'Engineering', 95000, '2019-09-23', {'Python', 'C++', 'Scala'}, {'Project_B': 'Completed', 'Project_C': 'In Progress'}, ['English', 'French'], {'city': 'Austin', 'country': 'USA'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Diana', 40, 'Sales', 70000, '2020-03-12', {'Negotiation', 'CRM'}, {'Account_Y': 'Ongoing'}, ['English', 'German'], {'city': 'Berlin', 'country': 'Germany'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Eve', 28, 'Engineering', 60000, '2022-07-01', {'JavaScript', 'React', 'CSS'}, {'Website_Revamp': 'Completed'}, ['English', 'Mandarin'], {'city': 'Beijing', 'country': 'China'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Frank', 33, 'HR', 50000, '2018-11-30', {'Recruitment', 'People Management'}, {}, ['English'], {'city': 'Chicago', 'country': 'USA'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Grace', 29, 'Finance', 85000, '2021-02-21', {'Financial Modeling', 'Excel'}, {'Quarterly_Review': 'Completed'}, ['English', 'French'], {'city': 'Toronto', 'country': 'Canada'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Henry', 31, 'Product', 78000, '2022-08-15', {'Product Management', 'Agile'}, {'Product_Launch': 'In Progress'}, ['English', 'Japanese'], {'city': 'Tokyo', 'country': 'Japan'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Ivy', 27, 'Engineering', 67000, '2023-01-10', {'Python', 'Data Analysis'}, {'Analytics_Tool': 'In Progress'}, ['English', 'Korean'], {'city': 'Seoul', 'country': 'South Korea'});

INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) VALUES (uuid(), 'Jack', 45, 'Management', 120000, '2017-04-18', {'Leadership', 'Strategy'}, {'Company_Growth': 'Ongoing'}, ['English'], {'city': 'London', 'country': 'UK'});


-- now we can perform distinct querry search 
select distinct department from employees2;


-- to perform multiple condition where condition not contain primary key
select * from employees2 where age > 24 and department = 'Engineering' allow filtering;



-- to get multiple matches 
select * from employees2 where department in ('Engineering' , 'Finance');



-- to get records based on certain attributes
select name, skills from employees2 where skills contains 'Python' allow filtering;


-- to perform grouping
select department , count(*) from employees2 group by department;


-- to permorm ordering you must have to use partition key with some equality condition ('=')
select * from employees2 where department  = 'Engineering' order by name asc;



-- to limit records
select name from employees2 where department = 'Engineering' limit 2;

-- to limit per partition
select name from employees2 where department = 'Enginnering' per partition limit 2;


-- to perform certain condition without partition key
SELECT * FROM employees2 WHERE projects['Project_A'] = 'Completed' ALLOW FILTERING;




-- to perform updation

-- basic update 



-- delete 
DELETE FROM employees2 
WHERE department = 'Engineering' AND name = 'Alice' AND age = 30;


-- insert 
INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address)
VALUES (uuid(), 'Alice', 30, 'Marketing', 85000.00, '2022-01-15 10:00:00', {'Python', 'Java'}, {'Project_A': 'Completed'}, ['English', 'Spanish'], {'city': 'New York', 'country': 'USA'});


-- mulitple updates
UPDATE employees2 SET salary = 95000, age = 32 WHERE id = 123e4567-e89b-12d3-a456-426614174000;


-- conditional update 
UPDATE employees2 SET department = 'Management' WHERE id = 123e4567-e89b-12d3-a456-426614174000 IF EXISTS;


-- conditional update with condition
UPDATE employees2 SET salary = 100000 WHERE id = 123e4567-e89b-12d3-a456-426614174000 IF salary < 100000;


-- complex assignment
UPDATE employees2 SET age = age + 1, skills = skills + {'C#'} WHERE id = 123e4567-e89b-12d3-a456-426614174000;


-- updating map
UPDATE employees2 SET projects['Project_A'] = 'In Progress' WHERE id = 123e4567-e89b-12d3-a456-426614174000;


-- update list
UPDATE employees2 SET languages = languages + ['French'] WHERE id = 123e4567-e89b-12d3-a456-426614174000;




-- perform mulitple operation using batches 
BEGIN BATCH
   INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) 
   VALUES (uuid(), 'Bob', 28, 'HR', 70000.00, '2022-02-20 10:00:00', {'Communication', 'Management'}, {'Project_B': 'Ongoing'}, ['English'], {'city': 'Los Angeles', 'country': 'USA'});

   UPDATE employees2 
   SET salary = 95000.00 
   WHERE department = 'Engineering' AND name = 'Alice' AND age = 30;

   INSERT INTO employees2 (id, name, age, department, salary, join_date, skills, projects, languages, address) 
   VALUES (uuid(), 'Charlie', 25, 'Engineering', 65000.00, '2022-03-15 10:00:00', {'Java', 'C++'}, {'Project_C': 'Planned'}, ['English', 'French'], {'city': 'Seattle', 'country': 'USA'});

   DELETE address FROM employees2 
   WHERE department = 'HR' AND name = 'Bob' AND age = 28;
APPLY BATCH;



-- update using batch
BEGIN BATCH
   UPDATE employees2 SET salary = 70000.00 WHERE department = 'Engineering' AND name = 'Alice' AND age = 30;
   UPDATE employees2 SET age = 29 WHERE department = 'HR' AND name = 'Bob' AND age = 28;
   UPDATE employees2 SET join_date = '2022-02-25 09:00:00' WHERE department = 'Engineering' AND name = 'Charlie' AND age = 25;
APPLY BATCH;
