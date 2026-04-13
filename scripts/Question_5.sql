

/*********************** Question 5 **********************/

/* Find the sum of gpd_per_capita by year and the count of countries for each year that have non-null gdp_per_capita 
 * where (i) the year is before 2012 and (ii) the country has a null gdp_per_capita in 2012. Your result should have the columns:
 * 
 * year
 * country_count
 * total
 */


select
year,
count(case when gdp_per_capita is not null then country_code end) as counrty_count,
concat('$', round(sum(gdp_per_capita), 2)) as total
from per_capita  
where year < 2012
and country_code in (select country_code from per_capita pc 
					where gdp_per_capita is null 
					and year = 2012)
group by year
order by year asc;

