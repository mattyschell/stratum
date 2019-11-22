create or replace view building (
    objectid
   ,bin
   ,base_bbl
   ,construction_year
   ,geom_source
   ,last_status_type
   ,doitt_id
   ,height_roof
   ,feature_code
   ,ground_elevation
   ,last_modified_date
   ,mappluto_bbl
   ,shape
) as select
    objectid
   ,bin
   ,base_bbl
   ,construction_year
   ,geom_source
   ,last_status_type
   ,doitt_id
   ,height_roof
   ,feature_code
   ,ground_elevation
   ,last_modified_date
   ,mappluto_bbl
   ,shape
from bldg_blue.building;
grant select on building to public;
insert into stratum_catalog.st_catalog (
    relation_name
   ,relation_schema
   ,storage_name
   ,storage_schema
   ,created
   ,last_updated)
values (
    'building'
   ,current_schema
   ,'building'
   ,'building_blue'
   ,now()
   ,now()
);