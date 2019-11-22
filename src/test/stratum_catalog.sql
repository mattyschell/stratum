select 
    relation_database || '.' || relation_schema || '.' || relation_name 
from 
    stratum_catalog.stratum_catalog
order by relation_database
        ,relation_schema
        ,relation_name;