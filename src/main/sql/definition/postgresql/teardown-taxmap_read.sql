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