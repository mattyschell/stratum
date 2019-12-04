select catalog_name || '.' || schema_name 
from 
    information_schema.schemata
where 
    schema_owner = 'stratum'
and catalog_name = current_catalog
order by current_catalog
        ,schema_name;