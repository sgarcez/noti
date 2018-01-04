select *
 from places
 where ST_DWithin (coords::geometry(Point), ST_MakePoint(64.68375, 24.47645), 1000);