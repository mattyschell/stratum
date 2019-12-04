# Stratum

Data management and integration of layers under a DoITT GIS
[stratus](https://github.com/planetlabs/stratus) deployment.  This is our 
database, our rules, make it go viral friends.

# Dependencies

1. PostgreSQL with PostGIS extension (tested at PostgreSQL 10.6, PostGIS 2.5)
2. Privileges to create users, schemas in a pre-existing database
3. Terminal with psql access to that database 

# Provision Stratum User and Schemas

In a pre-existing database we will create a new 'stratum' user with the input 
STRATUMPASSWORD. If your superuser connects via non-standard hosts, passwords, 
or users be sure to externalize them.

    $ export PGDATABASE=bse
    $ export PGUSER=rdsadmin
    $ export PGPORT=5433
    $ export PGPASSWORD=PostGisIsMyDatabae!
    $ export PGHOST=aws.dollar.dollar.bill

Then run users.sql.  Replace the new stratum user password below, make a note.

Uncomment line 2 if you are re-running and wish to start from scratch.

    $ export STRATUMPASSWORD=BeMyDataBae!
    $ #psql -t -f ./src/main/sql/definition/postgresql/teardown-users.sql 
    $ psql -t -v v1=$STRATUMPASSWORD -v v2=$PGDATABASE -f ./src/main/sql/definition/postgresql/users.sql

# Provision Database Tables and Support Objects

We will connect as the newly created 'stratum' user and create empty database
objects under each schema. Export the stratum user password as the standard 
PGPASSWORD.

Uncomment line 3 if you want to drop all objects and then re-create.

    $ export PGDATABASE=bse
    $ export PGPASSWORD=PostGisIsMyDatabae!
    $ #psql -t -f ./src/main/sql/definition/postgresql/teardown-schema.sql 
    $ psql -t -f ./src/main/sql/definition/postgresql/schema.sql


# Integration Tests

Tests that everything was created as expected.  Should succeed for any user with
public role access on the database.  The stratum user is fine too. Externalize 
connection details.

Requires python 3+ in addition to psql.

    $ export PGDATABASE=bse
    $ export PGPASSWORD=BeMyDataBae!
    $ ./src/test/run_all_tests.sh
