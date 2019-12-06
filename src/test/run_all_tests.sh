export PGUSER='stratum'
python3 ../stratum/src/test/run_test.py "../stratum/src/test/information_schema_schemata.sql" "../stratum/src/test/schemata_expected"
python3 ../stratum/src/test/run_test.py "../stratum/src/test/stratum_catalog.sql" "../stratum/src/test/catalog_expected"
python3 ../stratum/src/test/run_test.py "../stratum/src/test/information_schema_tables.sql" "../stratum/src/test/catalog_expected"
python3 ../stratum/src/test/run_test.py "../stratum/src/test/pg_roles_rolname.sql" "../stratum/src/test/users_expected"