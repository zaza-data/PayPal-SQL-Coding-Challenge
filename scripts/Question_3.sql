
/*************************** Question 3 ***************************/

/* For the year 2012, create a 3 column, 1 row report showing the percent share of gdp_per_capita for the following regions:

* (i) Asia, (ii) Europe, (iii) the Rest of the World. Your result should look something like

* Asia	Europe	Rest of World
* 25.0%	25.0%	50.0%
* */


select 
concat(round(sum(case when continent_code = 'AS' then gdp_per_capita end)/sum(gdp_per_capita)*100, 2), '%') as Asia,
concat(round(sum(case when continent_code = 'EU' then gdp_per_capita end)/sum(gdp_per_capita)*100, 2), '%') as Europe,
concat(round(sum(case when continent_code not in ('AS', 'EU') then gdp_per_capita end)/sum(gdp_per_capita)*100, 2), '%') as Rest_of_World
from per_capita pc
join continent_map cm  
on pc.country_code = cm.country_code 
where year = 2012;

