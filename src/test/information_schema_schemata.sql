-- stratum.basemap_blue
-- stratum.basemap_green ..etc
-- primary purpose is to ensure that stratum in facts owns the schemas
select schema_owner || '.' || schema_name 
from 
    information_schema.schemata
where 
    schema_owner = 'stratum'
and catalog_name = current_catalog
order by schema_owner
        ,schema_name;
