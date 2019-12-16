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
-- when rerun "ERROR: duplicate key" is the correct outcome
insert into stratum_catalog.st_catalog (
    dataset_name
   ,dataset_schema
   ,storage_name
   ,storage_schema
   ,dataset_updated
   ,source_agency    
   ,spatial_reference
   ,table_created)
values (
    'building'
   ,current_schema
   ,'bldg_blue'
   ,'building'
   ,null
   ,'NYC Dept. of Information Technology and Telecommunications' 
   ,null
   ,now()
);