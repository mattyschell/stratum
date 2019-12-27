-- This is NYC Tax Map data as released for public consumption.
-- It is not the same as the schema and data used to support the Digital Tax
-- Map on the web (http://maps.nyc.gov/taxmap/map.htm) and maintained internally
-- at the NYC Department of Finance.
-- This schema-taxmap.sql roughly mirrors what is available on NYC Open Data
--   (https://data.cityofnewyork.us/Housing-Development/Department-of-Finance-Digital-Tax-Map/smk3-tmxj)
-- And documented here: 
--   https://github.com/CityOfNewYork/nyc-geo-metadata/blob/master/Metadata/Metadata_DigitalTaxMap.md
-- When in doubt however I am guided by the source data in oracle DOF_TAXMAP  
-- However part 2 I am building wild and crazy constraints and keys that exist 
--   only here.  The source data is ESRI world so many constraints are either
--   inside the ESRI ransomware or are impossible to enfoprce due to ESRI 
--   versioning and editing workflows
--
--
-- tax_lot_polygon 
--    I am dropping created_by and last_modified_by, unsure why 
--    they are in open data
CREATE TABLE tax_lot_polygon (
    objectid                serial primary key
   ,boro                    varchar(1) not null
                           ,check (boro in ('1','2','3','4','5'))
   ,block                   numeric(10) not null
   ,lot                     numeric(5) not null
   ,bbl                     varchar(10)
   ,community_district      numeric(5) -- isnt maintained it seems, drop from view
   ,regular_lot_indicator   varchar(1) check (regular_lot_indicator in ('I', '0', '+')) -- 4real might want to decode in view
   ,number_lot_sides        numeric(4) --max is around 300 
   ,condo_flag              varchar(1) check (condo_flag = 'C')
   ,reuc_flag               varchar(1) check (reuc_flag = 'R')
   ,air_rights_flag         varchar(1) check (air_rights_flag = 'A')
   ,subterranean_flag       varchar(1) check (subterranean_flag = 'S')
   ,easement_flag           varchar(1) check (easement_flag = 'E')
   ,section_number          numeric(2) -- mostly null, <= 63
   ,volume_number           numeric(2) -- mostly null, <= 12
   ,page_number             varchar(4) -- mostly null, '1-2', '33A'
   ,lot_note                varchar(255)
   ,nycmap_bldg_flag        numeric(1) check (nycmap_bldg_flag in (0, 1, 2)) 
   ,missing_rpad_flag       numeric(1) check (missing_rpad_flag in (0, 1))
   ,conversion_exception_flag numeric(1)
   ,value_reflected_out_flag  numeric(1)
   ,created_date            date  
   ,last_modified_date      date 
   ,av_change               numeric(1) check (av_change in (0, 1)) 
   ,bw_change               numeric(1) check (bw_change in (0, 1))
   ,effective_tax_year      varchar(50) -- dirty vals in here
   ,bill_bbl_flag           numeric(5)
   ,shape                   geometry(multipolygon, 2263) --yes, there are a few with multiple outer rings
);  
create index if not exists tax_lot_polygonbbl on tax_lot_polygon (bbl); 
create index tax_lot_polygonshape on tax_lot_polygon using GIST(shape);
alter table tax_lot_polygon alter column shape set not null;
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
    'tax_lot_polygon'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- condo
--    (possibly) referenced by air_rights_condos
--    https://github.com/CityOfNewYork/nyc-geo-metadata/blob/master/Metadata/Metadata_Condo.md
--    I am dropping created_by and last_modified_by, unsure why 
--    they are in open data
--    I am also tempted to axe all of these condos from the column names
--        It is the condo table why do the columns also have to indicate condo?
--        I will drop them in the taxmap_read view
create table if not exists condo (
    objectid                serial primary key
   ,condo_boro              varchar(1) not null
                           ,check (condo_boro in ('1','2','3','4','5'))
   ,condo_key               numeric(6) -- condo_boro + condo_number
   ,condo_name              varchar(50)
   ,condo_base_bbl          varchar(10) -- references tax_lot_polygon???????????? not unique
   ,condo_billing_bbl       varchar(10) -- references tax_lot_polygon????????????
   ,condo_base_bbl_key      varchar(15) -- references tax_lot_polygon????????????
   ,air_rights_condo_flag   numeric(5)
   ,billing_lot_not_in_cogis numeric(10)
   ,created_date            date
   ,last_modified_date      date
   ,av_change               numeric(5)
   ,bw_change               numeric(5)
   ,condo_number            numeric(5)  
);
create index if not exists condocondo_base_bbl on condo (condo_base_bbl); 
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
    'condo'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- air_rights_condos
--   https://github.com/CityOfNewYork/nyc-geo-metadata/blob/master/Metadata/Metadata_AirRightsCondos.md
--   github column names do not precisely match open data 
--      oid vs objectid
--      condo_ba00 vs condo_ba_1
--      open data includes ESRI globalid
create table if not exists air_rights_condos (
	objectid                serial primary key
   ,condo_key               numeric(10)
   ,condo_base_bbl          varchar(10) -- references condo ( condo_base_bbl ) -- not unique there -- either function or references tax_lot_polygon?
   ,condo_base_bbl_key      varchar(15) -- references condo ( condo_base_bbl_key ) -- can be NULL -- either function or references tax_lot_polygon?
   ,air_rights_bbl          varchar(10)
   ,av_change               numeric(5)
   ,bw_change               numeric(5)
);
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
    'air_rights_condos'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);

 

-- air_rights_holders

-- air_rights_lots

-- boundary

-- condo_units

-- lot_face_possession_hooks

-- misc_text ** no metadata

-- possession_hooks ** no metadata

-- reuc_lots

-- subterranean_lots

-- tax_block_polygon

-- tax_lot_face

