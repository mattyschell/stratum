create table st_catalog (
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
create or replace view stratum_catalog (
	id
   ,dataset_name
   ,dataset_schema
   ,dataset_database
   ,storage_name
   ,storage_schema
   ,dataset_updated
   ,source_agency    
   ,spatial_reference
   ,table_created
) as select
   	id
   ,dataset_name
   ,dataset_schema
   ,current_catalog 
   ,storage_name
   ,storage_schema
   ,dataset_updated
   ,source_agency
   ,spatial_reference
   ,table_created       
from st_catalog;
grant select on stratum_catalog to public;