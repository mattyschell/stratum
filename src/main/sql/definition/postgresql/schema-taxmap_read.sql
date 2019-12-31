-- tax_lot_polygon
--   dropping community_district
--   may want to ditch more that are not maintained
create or replace view tax_lot_polygon
as select    
    objectid
   ,boro
   ,block
   ,lot
   ,bbl
   ,regular_lot_indicator
   ,number_lot_sides
   ,condo_flag
   ,reuc_flag
   ,air_rights_flag
   ,subterranean_flag
   ,easement_flag
   ,section_number
   ,volume_number
   ,page_number
   ,lot_note --consider dropping
   ,nycmap_bldg_flag 
   ,missing_rpad_flag
   ,conversion_exception_flag
   ,value_reflected_out_flag
   ,created_date  
   ,last_modified_date
   ,av_change 
   ,bw_change
   ,effective_tax_year -- dirty vals in here, consider dropping
   ,bill_bbl_flag
   ,shape       
from taxmap_blue.tax_lot_polygon;  
grant select on tax_lot_polygon to public;
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
   ,'tax_lot_polygon'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- condo
--   removing some redundant condo_ prefixes
create or replace view condo 
as select
    objectid
   ,condo_boro as boro
   ,condo_key
   ,condo_name as name
   ,condo_base_bbl as base_bbl
   ,condo_billing_bbl as billing_bbl
   ,condo_base_bbl_key as base_bbl_key
   ,air_rights_condo_flag
   ,billing_lot_not_in_cogis
   ,created_date
   ,last_modified_date
   ,av_change
   ,bw_change
   ,condo_number  
from taxmap_blue.condo;
grant select on condo to public;
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
   ,'condo'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- air_rights_condos 
--   removing some redundant condo_ prefixes
create or replace view air_rights_condos 
as select
    objectid
   ,condo_key
   ,condo_base_bbl as base_bbl
   ,condo_base_bbl_key as base_bbl_key
   ,air_rights_bbl
   ,av_change
   ,bw_change  
from taxmap_blue.air_rights_condos;
grant select on air_rights_condos to public;
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
   ,'air_rights_condos'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);