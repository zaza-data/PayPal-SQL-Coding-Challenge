
/*********** Question 1 : Data Integrity Checking & Cleanup **********/



/* Alphabetically list all of the country codes in the continent_map table that appear more than once. 
* Display any values where country_code is null as country_code = "FOO" and make this row appear first in the list, 
* even though it should alphabetically sort to the middle. Provide the results of this query as your answer.
* */

select 'FOO' as country_code
from continent_map
where country_code = ''
group by country_code
having count(country_code) > 1

union all

(select country_code 
from continent_map
where country_code <> ''
group by country_code
having count(country_code) > 1
order by country_code asc);



/* For all countries that have multiple rows in the continent_map table, 
 * delete all multiple records leaving only the 1 record per country. 
 * The record that you keep should be the first one when sorted by the continent_code alphabetically ascending. 
 * Provide the query/ies and explanation of step(s) that you follow to delete these records.
 * */

-- Create a query to partition records by country_code and giving a row number to every record in a partition :
with continent_ranking as (
	select country_code, 
	continent_code,
	row_number() over (partition by country_code order by continent_code asc) as continent_rank,
	ctid -- return the intern pseudo-id ctid (mainly used for duplicates).
	from continent_map
)

-- Delete all records with a row number different from 1 :
delete from continent_map cm using continent_ranking cr
where cm.ctid = cr.ctid -- As we don't have a unique id in the table, we will be using the the intern pseudo-id ctid to have a match as we have duplicates in the table.
and cr.continent_rank <> 1;
