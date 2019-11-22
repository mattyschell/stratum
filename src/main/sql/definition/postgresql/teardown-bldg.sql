drop table if exists building;
delete from 
    stratum_catalog.st_catalog a
where
    a.relation_schema = current_schema
and a.relation_name = 'BUILDING';