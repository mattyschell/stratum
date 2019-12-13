-- psql -f ./src/main/sql/definition/postgresql/teardown-users.sql
select 'calling stratum teardown-users.sql with user ' || current_user || ' on database ' || current_catalog || ' at ' || version(); 
drop schema if exists cscl_read cascade;
drop schema if exists cscl_blue cascade;
drop schema if exists cscl_green cascade;
drop schema if exists bldg_read cascade;
drop schema if exists bldg_blue cascade;
drop schema if exists bldg_green cascade;
drop schema if exists taxmap_read cascade;
drop schema if exists taxmap_blue cascade;
drop schema if exists taxmap_green cascade;
drop schema if exists basemap_read cascade;
drop schema if exists basemap_blue cascade;
drop schema if exists basemap_green cascade;
drop schema if exists stratum_catalog cascade;
-- confusing, owned is privs
reassign owned by stratum to postgres;
drop owned by stratum;  
drop user if exists stratum;