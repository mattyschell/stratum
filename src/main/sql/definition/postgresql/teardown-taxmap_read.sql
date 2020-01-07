drop view if exists tax_lot_polygon;
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'tax_lot_polygon';
drop view if exists condo;
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'condo';
drop view if exists air_rights_condos; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'air_rights_condos';
drop view if exists air_rights_holders; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'air_rights_holders';
drop view if exists air_rights_lots; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'air_rights_lots';
drop view if exists boundary; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'boundary';
drop view if exists condo_units; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'condo_units';
drop view if exists lot_face_possession_hooks; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'lot_face_possession_hooks';
drop view if exists misc_text; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'misc_text';
drop view if exists possession_hooks; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'possession_hooks';
drop view if exists reuc_lots; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'reuc_lots';
drop view if exists subterranean_lots; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'subterranean_lots';
drop view if exists tax_block_polygon; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'tax_block_polygon';
drop view if exists tax_lot_face; 
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'tax_lot_face';