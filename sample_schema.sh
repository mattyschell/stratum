#!/bin/bash
# create database tables and support objects under stratum-owned schemas
cd "$(dirname "$0")"
#psql -t -U stratum -f ../stratum/src/main/sql/definition/postgresql/teardown-schema.sql 
psql -t -U stratum -f ../stratum/src/main/sql/definition/postgresql/schema.sql