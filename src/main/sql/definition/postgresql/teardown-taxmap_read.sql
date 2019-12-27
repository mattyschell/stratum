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
and a.dataset_name = 'air_rights_conods';