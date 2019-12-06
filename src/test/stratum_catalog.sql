--bldg_blue.bldg
--bldg_read.building etc
select 
    dataset_schema || '.' || dataset_name
from 
    stratum_catalog.stratum_catalog
order by dataset_schema
        ,dataset_name;