


/*********************** Question 7 **********************/


/* Find the country with the highest average gdp_per_capita for each continent for all years. 
 * Now compare your list to the following data set. Please describe any and all mistakes that you can find with the data set below. 
 * Include any code that you use to help detect these mistakes.

 * rank	continent_name	country_code	country_name	avg_gdp_per_capita
 * 1	Africa	SYC	Seychelles	$11,348.66
 * 1	Asia	KWT	Kuwait	$43,192.49
 * 1	Europe	MCO	Monaco	$152,936.10
 * 1	North America	BMU	Bermuda	$83,788.48
 * 1	Oceania	AUS	Australia	$47,070.39
 * 1	South America	CHL	Chile	$10,781.71
 * */


select * from (
select 
rank() over (partition by ct.continent_name order by avg(gdp_per_capita) desc) as rank,
ct.continent_name,
pc.country_code,
c.country_name,
concat('$',round(avg(gdp_per_capita),2)) as avg_gdp_per_capita
from per_capita pc
join continent_map cm 
on pc.country_code = cm.country_code
join continents ct
on ct.continent_code = cm.continent_code 
join countries c
on c.country_code  = pc.country_code 
group by ct.continent_name, pc.country_code, c.country_name 
) as ranking 
where ranking.rank = 1;


