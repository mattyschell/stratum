select 
    dataset_database || '.' || dataset_schema || '.' || dataset_name 
from 
    stratum_catalog.stratum_catalog
order by dataset_database
        ,dataset_schema
        ,dataset_name;