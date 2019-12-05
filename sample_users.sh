#!/bin/bash
# create stratum user with STRATUMPASSWORD and schemas owned by stratum
cd "$(dirname "$0")"
psql -t -f ../stratum/src/main/sql/definition/postgresql/teardown-users.sql 
#psql -t -v v1=$STRATUMPASSWORD -v v2=$PGDATABASE -f ../stratum/src/main/sql/definition/postgresql/users.sql