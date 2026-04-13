
-- Création de la base de données : 

create database countries_gdp_db;


-- Création des tables : 

create table if not exists continent_map (
	country_code varchar(3),
	continent_code varchar(2)
);

create table if not exists continents (
	continent_code varchar(2),
	continent_name varchar(20)
);

create table if not exists countries ( 
	country_code varchar(3),
	country_name varchar
);

create table if not exists per_capita (
	country_code varchar(3),
	year smallint,
	gdp_per_capita decimal
);

        
