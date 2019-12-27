-- should call as stratum but in case of superuser or something change role
set role stratum;
select 'calling stratum schema.sql with user ' || current_user || ' on database ' || current_catalog || ' at ' || version(); 
set SEARCH_PATH=stratum_catalog,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-stratum_catalog.sql
-- bldg
set SEARCH_PATH=bldg_blue,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-bldg.sql
set SEARCH_PATH=bldg_green,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-bldg.sql
set SEARCH_PATH=bldg_read,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-bldg_read.sql
-- taxmap
set SEARCH_PATH=taxmap_blue,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-taxmap.sql
set SEARCH_PATH=taxmap_green,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-taxmap.sql
set SEARCH_PATH=taxmap_read,public;
\i ../stratum/src/main/sql/definition/postgresql/schema-taxmap_read.sql
-- cscl
-- basemap