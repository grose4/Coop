# `database-files` Folder

This folder contains the SQL database. It includes CREATE TABLE and INSERT statements. To rebootstrap the database, use the following commands. 

docker exec -it mysql_db mysql -u root -p
DROP DATABASE finalpart2;
CREATE DATABASE finalpart2;
