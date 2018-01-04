with 
	context as (select ST_MakePoint(64.68375, 24.47645) as reference_point)
select 
	places.id as place_id,
	places.name as place_name,
	deals.id as deal_id,
	deals.title as deal_title,
	ST_Distance(coords::geometry(Point), (select reference_point from context)) as distance
from
	places
join
	deals on deals.place_id = places.id
where
	ST_DWithin (coords::geometry(Point), (select reference_point from context), 1000)
order by
	distance desc