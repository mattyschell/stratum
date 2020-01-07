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
--Also, a note on junk columns and maintenance-only columns
--    I am dropping created_by and last_modified_by, these are maintenance
--    I am dropping all instances of globalid, this is internal, ESRI-maintained
--    Other columns where I am less sure I am leaving here in the storage layer
--       but filtering out in the view. If someone has an edge case need for 
--       these columns they should request them. The alternative, which all too 
--       often comes to pass, is that I am maintaining garbage columns for no
--       use by theoretical (but ultimately non-existent) users
--
-- tax_lot_polygon 
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
   ,lot_note                varchar(255) -- editing notes, drop from view
   ,nycmap_bldg_flag        numeric(1) check (nycmap_bldg_flag in (0, 1, 2)) 
   ,missing_rpad_flag       numeric(1) check (missing_rpad_flag in (0, 1))
   ,conversion_exception_flag numeric(1) check (conversion_exception_flag in (0, 1))
   ,value_reflected_out_flag  numeric(1) check (value_reflected_out_flag in (0, 1))
   ,created_date            date  
   ,last_modified_date      date 
   ,av_change               numeric(1) check (av_change in (0, 1)) 
   ,bw_change               numeric(1) check (bw_change in (0, 1))
   ,effective_tax_year      varchar(50) -- dirty vals in here, filter from view
   ,bill_bbl_flag           numeric(5)
   ,shape                   geometry(multipolygon, 2263) --yes, there are a few with multiple outer rings
);  
create index if not exists tax_lot_polygonbbl on tax_lot_polygon (bbl); 
create index if not exists tax_lot_polygonshape on tax_lot_polygon using GIST(shape);
alter table tax_lot_polygon alter column shape set not null;
alter table tax_lot_polygon add constraint tax_lot_polygonshape_check check (st_isvalid(shape));
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
--    It is the condo table why do the columns also have to indicate condo?
--    I am very tempted to drop the extra condos in the taxmap_read view
create table if not exists condo (
    objectid                serial primary key
   ,condo_boro              varchar(1) not null
                           ,check (condo_boro in ('1','2','3','4','5'))
   ,condo_key               numeric(6) -- condo_boro + condo_number
   ,condo_name              varchar(50)
   ,condo_base_bbl          varchar(10) -- references tax_lot_polygon???????????? not unique
   ,condo_billing_bbl       varchar(10) -- references tax_lot_polygon???????????? not unique
   ,condo_base_bbl_key      varchar(15) -- references tax_lot_polygon????????????
   ,air_rights_condo_flag   numeric(1) check (air_rights_condo_flag in (0, 1))
   ,billing_lot_not_in_cogis numeric(1) check (billing_lot_not_in_cogis in (0, 1))
   ,created_date            date
   ,last_modified_date      date
   ,av_change               numeric(1) check (av_change in (0, 1)) -- filter from view no metadata on what it means
   ,bw_change               numeric(1) --all null filter from view
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
create table if not exists air_rights_condos (
	objectid                serial primary key
   ,condo_key               numeric(10)
   ,condo_base_bbl          varchar(10) -- references condo ( condo_base_bbl ) -- not unique there -- either function or references tax_lot_polygon?
   ,condo_base_bbl_key      varchar(15) -- references condo ( condo_base_bbl_key ) -- can be NULL -- either function or references tax_lot_polygon?
   ,air_rights_bbl          varchar(10)
   ,av_change               numeric(5) -- all null filter in view
   ,bw_change               numeric(5) -- all null filter in view
);
create index if not exists air_rights_condoscondo_base_bbl on air_rights_condos (condo_base_bbl); 
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
--   8 total records
create table if not exists air_rights_holders (
	objectid                serial primary key
   ,air_rights_bbl          varchar(10)
   ,holding_bbl             varchar(10)
   ,air_rights_size         numeric(10) -- all null filter in view
   ,created_date            date
   ,last_modified_date      date
   ,av_change               numeric(5) -- all null filter in view
   ,bw_change               numeric(5) -- all null filter in view
);
create index if not exists air_rights_holdersair_rights_bbl on air_rights_holders (air_rights_bbl); 
create index if not exists air_rights_holdersholding_bbl on air_rights_holders (holding_bbl); 
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
    'air_rights_holders'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- air_rights_lots
 --Air rights lot numbers must be between 9000 and 9989.
create table if not exists air_rights_lots (
	objectid                serial primary key
   ,donating_boro           varchar(1) not null
                                      ,check (donating_boro in ('1','2','3','4','5'))
   ,donating_block          numeric(10) not null
   ,donating_lot            numeric(5) not null
   ,donating_bbl            varchar(10)
   ,air_rights_size         numeric(10) -- all null filter in view
   ,used_by_donor_flag      numeric(5)  -- all null filter in view
   ,created_date            date -- all null
   ,last_modified_date      date -- all null
   ,av_change               numeric(5) -- all null filter in view
   ,bw_change               numeric(5) -- all null filter in view          
   ,effective_tax_year      varchar(50) -- full of junk and nulls
   ,air_rights_lot_number   numeric(4) check (air_rights_lot_number between 9000 and 9989)
  );
create index if not exists air_rights_lotsdonating_bbl on air_rights_lots (donating_bbl); 
create index if not exists air_rights_lotsair_rights_lot_number on air_rights_lots (air_rights_lot_number); 
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
    'air_rights_lots'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- boundary
create table if not exists boundary (
	objectid                serial primary key
   ,boundary_type           numeric(2) not null
                                      ,check (boundary_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14))
   ,type                    numeric(1) check (type in (0, 2, 6))
   ,id_number               varchar(50)
   ,description             varchar(50)
   ,length                  numeric 
   ,modifier                numeric(1) check (modifier in (0, 1))
   ,created_date            date -- all null, filter in view
   ,last_modified_date      date  -- all null, filter in view
   ,effective_tax_year      varchar(50) --messy
   ,shape                   geometry (linestring,2263)
  );
create index if not exists boundaryshape on boundary using GIST(shape);
alter table boundary alter column shape set not null;
alter table boundary add constraint boundaryshape_check check (st_isvalid(shape));
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
    'boundary'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- condo_units
create table if not exists condo_units (
    objectid                serial primary key
   ,condo_boro              varchar(1) not null
                                      ,check (condo_boro in ('1','2','3','4','5'))
   ,condo_number            numeric(5) not null
   ,condo_key               numeric(10)
   ,condo_base_boro         varchar(1) check (condo_base_boro in ('1','2','3','4','5'))
   ,condo_base_block        numeric(10)
   ,condo_base_lot          numeric(5)
   ,condo_base_bbl          varchar(10)
   ,condo_base_bbl_key      varchar(15)
   ,unit_boro               varchar(1) not null
                                      ,check (unit_boro in ('1','2','3','4','5'))
   ,unit_block              numeric(10) not null
   ,unit_lot                numeric(5) not null
   ,unit_bbl                varchar(10)
   ,created_date            date -- 1899 AD is the only date, filter from view
   ,last_modified_date      date -- 1899 AD is the only date, filter from view
   ,av_change               numeric(5) -- filter from view
   ,bw_change               numeric(5) -- filter from view 
   ,effective_tax_year      varchar(50)
   ,unit_designation        varchar(10)
);
create index if not exists condo_unitscondo_base_bbl on condo_units (condo_base_bbl); 
create index if not exists condo_unitsunit_bbl on condo_units (unit_bbl); 
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
    'condo_units'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- lot_face_possession_hooks
create table if not exists lot_face_possession_hooks (
    objectid                        serial primary key
   ,lot_face_possession_hook_type   numeric(1) not null 
                                   ,check (lot_face_possession_hook_type in (0, 1))
   ,rotation                        numeric
   ,created_date                    date -- all null, filter in view
   ,last_modified_date              date -- all null, filter in view
   ,shape                           geometry (point,2263)      
);
create index if not exists lot_face_possession_hooksshape on lot_face_possession_hooks using GIST(shape);
alter table lot_face_possession_hooks alter column shape set not null;
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
    'lot_face_possession_hooks'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- misc_text 
create table if not exists misc_text (
    objectid                        serial primary key
   ,misc_text                       varchar(250)
   ,rotation                        numeric check (rotation >= 0 and rotation <= 360)
   ,shape                           geometry (point,2263)      
);
create index misc_textshape on misc_text using GIST(shape);
alter table misc_text alter column shape set not null;
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
    'misc_text'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- possession_hooks
create table if not exists possession_hooks (
    objectid                        serial primary key
   ,hook_type                       numeric(5) check (hook_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14))
   ,rotation                        numeric not null
                                   ,check (rotation >= 0 and rotation <= 360)
   ,created_date                    date -- all null filter from view
   ,last_modified_date              date -- all null filter from view
   ,shape                           geometry (point,2263)      
);
create index if not exists possession_hooksshape on possession_hooks using GIST(shape);
alter table possession_hooks alter column shape set not null;
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
    'possession_hooks'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- reuc_lots
create table if not exists reuc_lots (
    objectid                        serial primary key
   ,appurtenant_boro                varchar(1) not null 
                                   ,check (appurtenant_boro in ('0','1','2','3','4','5',' ')) -- '0' and ' ' are illegal 
   ,appurtenant_block               numeric(10) not null
   ,appurtenant_lot                 numeric(5) not null
   ,appurtenant_bbl                 varchar(10)
   ,reuc_number                     varchar(20)
   ,deleted_flag                    numeric(1) check (deleted_flag in (0,1))
   ,created_date                    date -- all null filter from view
   ,last_modified_date              date  -- all null filter from view
   ,av_change                       numeric(1) check (av_change in (1)) 
   ,bw_change                       numeric(1) check (bw_change in (0))
   ,effective_tax_year              varchar(50) -- trashy
);
create index if not exists reuc_lotsappurtenant_bbl on reuc_lots (appurtenant_bbl);
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
    'reuc_lots'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- subterranean_lots
create table if not exists subterranean_lots (
    objectid                        serial primary key
   ,appurtenant_boro                varchar(1) not null 
                                   ,check (appurtenant_boro in ('1','2','3','4','5')) -- '0' and ' ' are illegal 
   ,appurtenant_block               numeric(10) not null
   ,appurtenant_lot                 numeric(5) not null
   ,appurtenant_bbl                 varchar(10)
   ,subterranean_lot_number         numeric(10)
   ,created_date                    date -- all null filter from view
   ,last_modified_date              date  -- all null filter from view
   ,av_change                       numeric(1) check (av_change in (1))  --almost all null
   ,bw_change                       numeric(5)  -- all null 
   ,effective_tax_year              varchar(50) -- trashy
);
create index if not exists subterranean_lotsappurtenant_bbl on subterranean_lots (appurtenant_bbl);
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
    'subterranean_lots'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- tax_block_polygon
create table if not exists tax_block_polygon (
    objectid                        serial primary key
   ,boro                            varchar(1) not null
                                   ,check (boro in ('1','2','3','4','5'))
   ,block                           numeric(10) not null
   ,eop_overlap_flag                numeric(1) check (eop_overlap_flag in (0, 1))
   ,jagged_st_flag                  numeric(1) check (jagged_st_flag in (0))
   ,created_date                    date -- mostly null and junk
   ,last_modified_date              date -- mostly null and junk
   ,section_number                  numeric(5) not null
   ,volume_number                   numeric(2) not null
   ,shape                           geometry(multipolygon, 2263) -- need to double check, I think there are a few with multiple outer rings
);  
create index if not exists tax_block_polygonblock on tax_block_polygon (block); 
create index if not exists tax_block_polygonshape on tax_block_polygon using GIST(shape);
alter table tax_block_polygon alter column shape set not null;
alter table tax_block_polygon add constraint tax_block_polygonshape_check check (st_isvalid(shape));
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
    'tax_block_polygon'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);
-- tax_lot_face
create table if not exists tax_lot_face (
    objectid                        serial primary key
   ,tax_lot_face_type               numeric(1) check (tax_lot_face_type in (-1,0,1))
   ,boro                            varchar(1) not null
                                   ,check (boro in ('1','2','3','4','5'))
   ,block                           numeric(10) not null
   ,lot                             numeric(5) not null
   ,bbl                             varchar(10)
   ,lot_face_length                 numeric
   ,source                          numeric(2) check (source in (0,1,2,3,4,36))
   ,block_face_flag                 numeric(1) check (block_face_flag in (0,1))
   ,lot_face_length_error           numeric(1) check (lot_face_length_error in (0,1,2))
   ,created_date                    date -- mostly null and junk
   ,last_modified_date              date -- mostly null and junk
   ,av_change                       numeric(1) check (av_change in (0,1))
   ,bw_change                       numeric(2) check (bw_change in (0,1,14))
   ,approx_length_flag              numeric(5) not null
                                   ,check(approx_length_flag in (0,1))
   ,shape                           geometry (multilinestring,2263) -- need to double check, I think there are a few with multiple outer rings
);  
create index if not exists tax_lot_facebbl on tax_lot_face (bbl); 
create index if not exists tax_lot_faceshape on tax_lot_face using GIST(shape);
alter table tax_lot_face alter column shape set not null;
alter table tax_lot_face add constraint tax_lot_faceshape_check check (st_isvalid(shape));
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
    'tax_lot_face'
   ,current_schema
   ,null
   ,null
   ,null
   ,'NYC Dept. of Finance'
   ,null
   ,now()
);


