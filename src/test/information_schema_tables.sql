select 
    table_catalog || '.' || table_schema || '.' || table_name
from 
    information_schema.tables
where 
    table_catalog = current_catalog
and table_schema IN ('bldg_read'
                    ,'bldg_blue'
                    ,'bldg_green')
order by table_catalog
        ,table_schema
        ,table_name;