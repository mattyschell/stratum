# STRATUM

Data management and integration of layers under a DoITT GIS
[stratus](https://github.com/planetlabs/stratus) deployment.  This is our 
database, our rules, the trick is to never be afraid.

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

Then run this.  Replace the new user password below with yours, make a note.

Uncomment line 2 if you are re-running and wish to start from scratch.

    $ export STRATUMPASSWORD=BeMyDataBae!
    $ #psql -f ./src/main/sql/definition/postgresql/teardown-users.sql 
    $ psql -t -v v1=$STRATUMPASSWORD -v v2=$PGDATABASE -f ./src/main/sql/definition/postgresql/users.sql

# Provision Database Tables and Support Objects

    Coming right up
    
# Integration Tests

    Coming soon

# Teardown Testing Environment

    Probably

