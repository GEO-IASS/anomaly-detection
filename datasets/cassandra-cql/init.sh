#!/bin/sh

TZ=UTC ../../apache-cassandra-2.2.4/bin/cqlsh --debug -f create_keyspace.cql
TZ=UTC ../../apache-cassandra-2.2.4/bin/cqlsh --debug -f load_tables.cql

