drop view if exists building;
delete from 
    stratum_catalog.st_catalog a
where
    a.dataset_schema = current_schema
and a.dataset_name = 'BUILDING';