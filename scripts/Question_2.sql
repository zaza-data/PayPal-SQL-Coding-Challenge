
/************************* Question 2 **************************/


/* List the countries ranked 10-12 in each continent by the percent of year-over-year growth descending from 2011 to 2012.

* The percent of growth should be calculated as: ((2012 gdp - 2011 gdp) / 2011 gdp)

* The list should include the columns:

* rank
* continent_name
* country_code
* country_name
* growth_percent
* 
* */

with gdp_2012 as (
select 
pc.country_code,
pc.year,
pc.gdp_per_capita,
cm.continent_code 
from per_capita pc 
join continent_map cm 
on pc.country_code = cm.country_code
where year = 2012 
), 

gdp_2011 as (select 
pc.country_code,
pc.year,
pc.gdp_per_capita,
cm.continent_code 
from per_capita pc 
join continent_map cm 
on pc.country_code = cm.country_code
where year = 2011
)

select 
ranking.rank,
ct.continent_name,
ranking.country_code,
cn.country_name,
concat(round(ranking.growth_percent*100,2), '%') 
from
(select 
gdp_2012.continent_code,
gdp_2012.country_code,
(gdp_2012.gdp_per_capita - gdp_2011.gdp_per_capita)/gdp_2011.gdp_per_capita as growth_percent,
rank() over(partition by gdp_2012.continent_code order by (gdp_2012.gdp_per_capita - gdp_2011.gdp_per_capita)/gdp_2011.gdp_per_capita desc) as rank
from gdp_2012 
join gdp_2011
on gdp_2012.country_code = gdp_2011.country_code
)as ranking
join continents ct 
on ct.continent_code = ranking.continent_code
join countries cn
on cn.country_code = ranking.country_code
where ranking.rank in (10, 11, 12)
order by ranking.continent_code desc, ranking.rank asc;


