create user stratum with password :'v1';
grant all privileges on database :v2 to stratum;
create extension if not exists postgis;
-- done with superuser
set role stratum;
-- cscl
create schema cscl_blue authorization stratum;
grant all on schema cscl_blue to stratum;
create schema cscl_green authorization stratum;
grant all on schema cscl_green to stratum;
create schema cscl_read authorization stratum;
grant all on schema cscl_read to stratum;
grant usage on schema cscl_read to public;
-- bldg 
create schema bldg_blue authorization stratum;
grant all on schema bldg_blue to stratum;
create schema bldg_green authorization stratum;
grant all on schema bldg_green to stratum;
create schema bldg_read authorization stratum;
grant all on schema bldg_read to stratum;
grant usage on schema bldg_read to public;
-- taxmap
create schema taxmap_blue authorization stratum;
grant all on schema taxmap_blue to stratum;
create schema taxmap_green authorization stratum;
grant all on schema taxmap_green to stratum;
create schema taxmap_read authorization stratum;
grant all on schema taxmap_read to stratum;
grant usage on schema taxmap_read to public;
-- basemap
create schema basemap_blue authorization stratum;
grant all on schema basemap_blue to stratum;
create schema basemap_green authorization stratum;
grant all on schema basemap_green to stratum;
create schema basemap_read authorization stratum;
grant all on schema basemap_read to stratum;
grant usage on schema basemap_read to public;
select 'toot the horn for the schemas and owners on ' || current_catalog;
\dn
