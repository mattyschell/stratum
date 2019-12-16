create table if not exists st_catalog (
	id                      serial primary key
   ,dataset_name            varchar(64) not null
   ,dataset_schema          varchar(64) not null
   ,storage_name            varchar(64)
   ,storage_schema          varchar(64)
   ,dataset_updated         timestamp
   ,source_agency           varchar(128)    
   ,spatial_reference       integer
   ,table_created           timestamp
   ,unique (dataset_name, dataset_schema)
);
create or replace view stratum_catalog as
select
   	st_catalog.id
   ,st_catalog.dataset_name
   ,st_catalog.dataset_schema
   ,current_catalog as dataset_database 
   ,st_catalog.storage_name
   ,st_catalog.storage_schema
   ,st_catalog.dataset_updated
   ,st_catalog.source_agency
   ,st_catalog.spatial_reference
   ,st_catalog.table_created       
from st_catalog;
grant select on stratum_catalog to public;