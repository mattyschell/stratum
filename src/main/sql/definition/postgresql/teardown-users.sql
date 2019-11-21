-- psql -f ./src/main/sql/definition/postgresql/teardown-users.sql
select 'calling stratum teardown-users.sql with user ' || current_user || ' on database ' || current_catalog || ' at ' || version(); 
drop schema if exists cscl_blue;
drop schema if exists cscl_green;
drop schema if exists cscl_read;
drop schema if exists bldg_blue;
drop schema if exists bldg_green;
drop schema if exists bldg_read;
drop schema if exists taxmap_blue;
drop schema if exists taxmap_green;
drop schema if exists taxmap_read;
drop schema if exists basemap_blue;
drop schema if exists basemap_green;
drop schema if exists basemap_read;
-- confusing, owned is privs
reassign owned by stratum to postgres;
drop owned by stratum;  
drop user if exists stratum;