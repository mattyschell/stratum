set role stratum;
select 'calling stratum teardown-schema.sql with user ' || current_user || ' on database ' || current_catalog || ' at ' || version(); 
set SEARCH_PATH=bldg_read,public;
\i ../stratum/src/main/sql/definition/postgresql/teardown-bldg_read.sql
set SEARCH_PATH=bldg_blue,public;
\i ../stratum/src/main/sql/definition/postgresql/teardown-bldg.sql
set SEARCH_PATH=bldg_green,public;
\i ../stratum/src/main/sql/definition/postgresql/teardown-bldg.sql
set SEARCH_PATH=stratum_catalog,public;
\i ../stratum/src/main/sql/definition/postgresql/teardown-stratum_catalog.sql