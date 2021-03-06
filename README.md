# Stratum

[![Build Status](https://travis-ci.org/mattyschell/stratum.svg?branch=master)](https://travis-ci.org/mattyschell/stratum)

Proof of concept data management and integration of layers under a DoITT GIS
[stratus](https://github.com/planetlabs/stratus) deployment.  This is our 
database, our rules, make it go viral friends.  

# Dependencies

1. PostgreSQL with PostGIS extension (Travis CI tests at PostgreSQL 10.7, PostGIS 2.5)
2. Privileges to create users, schemas in a pre-existing database
3. Terminal with psql access to that database 

# Provision Stratum User and Schemas

In a pre-existing database we will create a new 'stratum' user with the input 
STRATUMPASSWORD. The stratum user will in turn create schemas for other 
stratum_xx dataset repos. We'll also create a stratum_read user with read-only
privileges for most uses in the [stratus](https://github.com/planetlabs/stratus) deployment.

Externalize all connection details using standard PostgreSQL default connection 
parameter environmentals.

```shell
$ export PGDATABASE=gis
$ export PGUSER=postgres
$ export PGPORT=5433
$ export PGPASSWORD=PostGisIsMyDatabae!
$ export PGHOST=aws.dollar.dollar.bill
```

And set one input variable to use as the new stratum user password.

```shell
$ export STRATUMPASSWORD=BeMyDataBaePostGis!
```

Our pattern for loading data into a cloud database or Minikube is to execute a 
series of scripts from an init-data directory that sits next to all database 
loading repos.

    postgis-init-data\
        script\
            load-stratum-user-schema.sh
            load-stratum_bldg.sh
        stratum\
        stratum_bldg\

Alternatively run sample_users.sh from this repo to create users and schemas 
only. Be sure to replace the new stratum user password below, make a note.

Uncomment line 4 of sample_users.sh if you wish drop everything and start from 
scratch.

```shell
$ export STRATUMPASSWORD=BeMyDataBaePostGis!
$ ./sample_users.sh 
```

# Provision Database Tables and Support Objects Under Each Schema

We will connect as the 'stratum' user and create objects under each schema. 
Export your new stratum user password as the PGPASSWORD.

Uncomment line 3 of sample_schema.sh if you want to drop all objects and 
then re-create empty.

```shell
$ export PGPASSWORD=BeMyDataBaePostGis!
$ ./sample_schema.sh
```

# Integration Tests

Tests that the steps above created the users, schemas, and other expected 
database objects

Requires python 3+ in addition to psql.

Should succeed for a public user on the database but stratum user is fine too. 
Externalize connection details.

```shell
$ export PGDATABASE=gis
$ export PGPASSWORD=BeMyDataBaePostGis!
$ ../stratum/src/test/run_all_tests.sh
```