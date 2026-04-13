
/********************* Question 4 ********************/


/* 4a. What is the count of countries and sum of their related gdp_per_capita values for the year 2007 
 * where the string 'an' (case insensitive) appears anywhere in the country name?
 */


select 
count(pc.country_code) as count_countries,
concat('$', round(sum(pc.gdp_per_capita), 2)) as sum_gdp_per_capita
from per_capita pc 
join countries c 
on pc.country_code = c.country_code 
where pc.year = 2007
and lower(c.country_name) like '%an%'; 



/* 4b. Repeat question 4a, but this time make the query case sensitive.*/

select 
count(pc.country_code) as count_countries,
concat('$', round(sum(pc.gdp_per_capita), 2)) as sum_gdp_per_capita
from per_capita pc 
join countries c 
on pc.country_code = c.country_code 
where pc.year = 2007
and c.country_name like '%an%';



