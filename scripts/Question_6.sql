

/********************** Question 6 ******************/



/* All in a single query, execute all of the steps below and provide the results as your final answer: */

/* a. create a single list of all per_capita records for year 2009 that includes columns:
 * 
 * continent_name
 * country_code
 * country_name
 * gdp_per_capita
 * 
 * */


select 
ct.continent_name,
pc.country_code,
c.country_name,
concat('$', round(pc.gdp_per_capita, 2)) as gdp_per_capita
from per_capita pc
join countries c 
on pc.country_code = c.country_code 
join continent_map cm
on cm.country_code = c.country_code
join continents ct
on ct.continent_code = cm.continent_code
where year = 2009;



/* b. order this list by:
 * 
 * continent_name ascending
 * characters 2 through 4 (inclusive) of the country_name descending
 * */

select 
ct.continent_name,
pc.country_code,
c.country_name,
concat('$', round(pc.gdp_per_capita, 2)) as gdp_per_capita
from per_capita pc
join countries c 
on pc.country_code = c.country_code 
join continent_map cm
on cm.country_code = c.country_code
join continents ct
on ct.continent_code = cm.continent_code
where year = 2009
order by ct.continent_name asc, substring(country_name, 2, 3) desc;



/* c. create a running total of gdp_per_capita by continent_name */

select 
ct.continent_name,
pc.country_code,
c.country_name,
concat('$', round(pc.gdp_per_capita, 2)) as gdp_per_capita,
concat('$', round(sum(pc.gdp_per_capita) over (partition by ct.continent_name order by ct.continent_name asc, substring(country_name, 2, 3) desc), 2)) as running_total
from per_capita pc
join countries c 
on pc.country_code = c.country_code 
join continent_map cm
on cm.country_code = c.country_code
join continents ct
on ct.continent_code = cm.continent_code
where year = 2009
order by ct.continent_name asc, substring(country_name, 2, 3) desc;



/* d. return only the first record from the ordered list for which each continent's running total of gdp_per_capita meets or exceeds $70,000.00 with the following columns:
 * 
 * continent_name
 * country_code
 * country_name
 * gdp_per_capita
 * running_total
 * 
*/

with list as (
select 
ct.continent_name,
pc.country_code,
c.country_name,
concat('$', round(pc.gdp_per_capita, 2)) as gdp_per_capita,
concat('$', round(sum(pc.gdp_per_capita) over (partition by ct.continent_name order by ct.continent_name asc, substring(country_name, 2, 3) desc), 2)) as running_total
from per_capita pc
join countries c 
on pc.country_code = c.country_code 
join continent_map cm
on cm.country_code = c.country_code
join continents ct
on ct.continent_code = cm.continent_code
where year = 2009
order by ct.continent_name asc, substring(country_name, 2, 3) desc
)

select 
continent_name,
country_code,
country_name,
gdp_per_capita,
running_total
from 
(select *, 
rank() over (partition by continent_name order by continent_name asc, substring(country_name, 2, 3) desc) as running_rank
from list
where substring(running_total, 2)::decimal >= 70000.00
) as ranking
where ranking.running_rank = 1;




