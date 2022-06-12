-----------------------Normalization-----------------------
--Normalization is used to minimize the redundancy from a relation or set of relations.
--Normalization divides the larger table into smaller and links them using relationships.

------------------------------------------------------------------------------------------------
--If we will keep all the attributes in one table then data redundancy will increase ,
--while spliting tables we also take care for redundancy.
--so let's create seperate table for player name , age and their medals .
--So we have created Players table as 1st table and 2nd is medal table.
--To uniquely identify each records of sports and country we have created sports_id and country_id column
--We have created sportss table as third table
--and ceated country table as 4th table
--In order to preserve to make our decomposition losslesss we are creating one main_table as 5th table 
--                     to connect all other tables with the help of this main _table 


--cretate table Players
CREATE TABLE IF NOT EXISTS Players (
    player_id varchar(51) NOT NULL ,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (player_id)
);

--Create table medal
CREATE TABLE IF NOT EXISTS Medal (
    player_id VARCHAR(51) NOT NULL,
    age INT(3) NOT NULL,
    YEAR INT(4) NOT NULL,
    Date_Given DATE NOT NULL,
    gold_medal INT(3) NOT NULL,
    silver_medal INT(3) NOT NULL,
    bronze_medal INT(3) NOT NULL,
    total_medal INT(11) NOT NULL,
    PRIMARY KEY (player_id)
);

--create table country
CREATE TABLE IF NOT EXISTS Country (
    country_id VARCHAR(51) NOT NULL,
    country_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (country_id)
);

--create table Sport
CREATE TABLE IF NOT EXISTS Sport (
    sport_id VARCHAR(51) NOT NULL,
    sport_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (sport_id)
);



--create table Sport_Player
CREATE TABLE IF NOT EXISTS join_table (
    player_id VARCHAR(51) NOT NULL,
    sport_id VARCHAR(51) NOT NULL,
    country_id VARCHAR(51) NOT NULL,
    PRIMARY KEY (player_id)
);


--------------------------------------------Quires--------------------------------------------


--Find the average number of medals won by each country
select c.country, avg(m.total_medal) as 'Avg medal'
from medal m
join join_table a on m.player_id = a.player_id
join country c on c.country_id = a.country_id
group by c.country_id;


--Display the countries and the number of gold medals they have won in decreasing order
select c.country, sum(m.gold_medal)
from medal m
join join_table a on m.player_id = a.player_id
join country c on c.country_id = a.country_id
group by c.country_id
ORDER BY sum(m.gold_medal) DESC;


--Display the list of people and the medals they have won in descending order, grouped by their country
select c.country, p.name, sum(m.gold_medal),sum(m.silver_medal),sum(m.bronze_medal),sum(m.total_medal)
from medal m
join players p on p.player_id = m.player_id
join join_table j on j.player_id = m.player_id
join country c on c.country_id = j.country_id
GROUP BY  c.country_id , p.name
order by (sum(m.total_medal)) desc;

--Display the list of people with the medals they have won according to their age
select p.name, m.age, m.gold_medal,m.silver_medal,m.bronze_medal,m.total_medal
from medal m
join players p on p.player_id = m.player_id
order by m.age ;

--Which country has won the most number of medals (cumulative)
select c.country, sum(m.total_medal)
from medal m
join join_table a on m.player_id = a.player_id
join country c on c.country_id = a.country_id
group by c.country_id
order by sum(m.total_medal) desc limit 1;



