create table st_catalog (
	id                  serial primary key
   ,relation_name       varchar(64) not null
   ,relation_schema     varchar(64) not null
   ,storage_name        varchar(64)
   ,storage_schema      varchar(64)
   ,created             timestamp
   ,last_updated        timestamp
   ,unique (relation_name, relation_schema)
);
create or replace view stratum_catalog (
    id
   ,relation_name
   ,relation_schema
   ,relation_database
   ,storage_name
   ,storage_schema
   ,created
   ,last_updated
) as select
   	id
   ,relation_name
   ,relation_schema
   ,current_catalog 
   ,storage_name
   ,storage_schema
   ,created             
   ,last_updated        
from st_catalog;
grant select on stratum_catalog to public;