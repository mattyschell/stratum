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
   ,nycmap_bldg_flag 
   ,missing_rpad_flag
   ,conversion_exception_flag
   ,value_reflected_out_flag
   ,created_date  
   ,last_modified_date
   ,av_change 
   ,bw_change
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
create or replace view condo 
as select
    objectid
   ,condo_boro 
   ,condo_key
   ,condo_name 
   ,condo_base_bbl 
   ,condo_billing_bbl 
   ,condo_base_bbl_key
   ,air_rights_condo_flag
   ,billing_lot_not_in_cogis
   ,created_date
   ,last_modified_date
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
create or replace view air_rights_condos 
as select
    objectid
   ,condo_key
   ,condo_base_bbl
   ,condo_base_bbl_key
   ,air_rights_bbl
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
-- air_rights_holders 
create or replace view air_rights_holders 
as select
	objectid
   ,air_rights_bbl
   ,holding_bbl
   ,created_date
   ,last_modified_date
from taxmap_blue.air_rights_holders;
grant select on air_rights_holders to public;
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
   ,'air_rights_holders'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- air_rights_lots 
create or replace view air_rights_lots 
as select
	objectid
   ,donating_boro
   ,donating_block
   ,donating_lot
   ,donating_bbl        
   ,effective_tax_year
   ,air_rights_lot_number
from taxmap_blue.air_rights_lots;
grant select on air_rights_lots to public;
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
   ,'air_rights_lots'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- boundary 
create or replace view boundary 
as select
    objectid
   ,boundary_type
   ,type
   ,id_number
   ,description
   ,length
   ,modifier
   ,effective_tax_year
   shape
from taxmap_blue.boundary;
grant select on boundary to public;
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
   ,'boundary'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- condo_units 
create or replace view condo_units 
as select
    objectid
   ,condo_boro
   ,condo_number
   ,condo_key
   ,condo_base_boro
   ,condo_base_block
   ,condo_base_lot
   ,condo_base_bbl
   ,condo_base_bbl_key
   ,unit_boro
   ,unit_block
   ,unit_lot
   ,unit_bbl
   ,effective_tax_year
   ,unit_designation
from taxmap_blue.condo_units;
grant select on condo_units to public;
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
   ,'condo_units'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- lot_face_possession_hooks 
create or replace view lot_face_possession_hooks 
as select
    objectid
   ,lot_face_possession_hook_type
   ,rotation
   ,shape
from taxmap_blue.lot_face_possession_hooks;
grant select on lot_face_possession_hooks to public;
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
   ,'lot_face_possession_hooks'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- misc_text 
create or replace view misc_text 
as select
    objectid
   ,misc_text
   ,rotation
   ,shape
from taxmap_blue.misc_text;
grant select on misc_text to public;
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
   ,'misc_text'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- possession_hooks 
create or replace view possession_hooks 
as select
    objectid
   ,hook_type
   ,rotation   
   ,shape
from taxmap_blue.possession_hooks;
grant select on possession_hooks to public;
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
   ,'possession_hooks'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- reuc_lots 
create or replace view reuc_lots 
as select
    objectid                       
   ,appurtenant_boro
   ,appurtenant_block
   ,appurtenant_lot
   ,appurtenant_bbl
   ,reuc_number
   ,deleted_flag
   ,av_change 
   ,bw_change
   ,effective_tax_year
from taxmap_blue.reuc_lots;
grant select on reuc_lots to public;
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
   ,'reuc_lots'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- reuc_lots 
create or replace view subterranean_lots 
as select
    objectid
   ,appurtenant_boro
   ,appurtenant_block
   ,appurtenant_lot
   ,appurtenant_bbl
   ,subterranean_lot_number
   ,av_change
   ,bw_change
   ,effective_tax_year
from taxmap_blue.subterranean_lots;
grant select on subterranean_lots to public;
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
   ,'subterranean_lots'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- tax_block_polygon 
create or replace view tax_block_polygon 
as select
    objectid
   ,boro
   ,block
   ,eop_overlap_flag
   ,jagged_st_flag
   ,created_date
   ,last_modified_date
   ,section_number
   ,volume_number
   ,shape
from taxmap_blue.tax_block_polygon;
grant select on tax_block_polygon to public;
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
   ,'tax_block_polygon'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);
-- tax_lot_face 
create or replace view tax_lot_face 
as select
    objectid
   ,tax_lot_face_type
   ,boro
   ,block
   ,lot
   ,bbl
   ,lot_face_length
   ,source
   ,block_face_flag
   ,lot_face_length_error
   ,created_date
   ,last_modified_date
   ,av_change
   ,bw_change
   ,approx_length_flag   
   ,shape
from taxmap_blue.tax_lot_face;
grant select on tax_lot_face to public;
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
   ,'tax_lot_face'
   ,'taxmap_blue'
   ,null
   ,'NYC Dept. of Finance' 
   ,null
   ,now()
);