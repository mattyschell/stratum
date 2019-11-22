create table building (
	objectid            serial primary key
   ,bin                 numeric(7) unique --will not allow million bins, they are maintenance 
   ,base_bbl            numeric(10)
   ,construction_year   numeric(10) --much nonsense in here, we will pass it along
   ,geom_source         varchar(15)
   ,last_status_type    varchar(256)
   ,doitt_id            numeric(10) unique
   ,height_roof         numeric
   ,feature_code        numeric(4,0)
   ,ground_elevation    numeric(4,0)
   ,last_modified_date  date
   ,mappluto_bbl        numeric(10)
   ,shape               geometry(multipolygon, 2263)
); 
create index buildingshape on building using GIST(shape);
create index buildingbase_bbl on building (base_bbl);
create index buildingmappluto_bbl on building (mappluto_bbl);
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
   ,null
   ,null
   ,now()
   ,now()
);