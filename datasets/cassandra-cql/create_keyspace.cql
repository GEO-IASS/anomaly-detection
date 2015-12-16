/*
  If you prefer to have the date in UTC format as default, set the TZ env variable to UTC
  TZ=UTC ../../apache-cassandra-2.1.7/bin/cqlsh
*/

DROP KEYSPACE IF EXISTS lbsn;

CREATE KEYSPACE IF NOT EXISTS lbsn 
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE lbsn;

CREATE TABLE lbsn.checkins (
  year  int, 
  month int, 
  day   int,
  time  int,
  ts    timestamp,
  uid   bigint,
  lat   double,
  lon   double,
  vid   bigint,
  PRIMARY KEY ((year, month), day, time, uid)
) WITH CLUSTERING ORDER BY (day ASC, time ASC, uid ASC);

/* demo 1: geo location anomaly detection with dbscan */

CREATE TABLE lbsn.checkins_clusters (
  uid     bigint,
  ts      timestamp,
  cid     int,
  count   int, 
  latmin  double,
  lonmin  double,
  latmax  double,
  lonmax  double,
  PRIMARY KEY (uid, ts, cid)
) WITH CLUSTERING ORDER BY (ts DESC, cid ASC);

/* demo 2: hotspots venues recommender */

CREATE TABLE lbsn.venues (
  vid   bigint, 
  name  text,
  lat   double,
  lon   double,
  PRIMARY KEY (vid)
);

CREATE TABLE lbsn.venues_geoclusters (
  year  int,
  ts    timestamp,
  cid   int,
  lat   double,
  lon   double,
  PRIMARY KEY (year, ts, cid)
) WITH CLUSTERING ORDER BY (ts DESC, cid ASC);

CREATE TABLE lbsn.venues_hotspots (
  year  int,
  ts    timestamp,
  cid   int,
  vid   bigint,
  lat   double,
  lon   double,
  name  text,
  PRIMARY KEY (year, ts, cid)
) WITH CLUSTERING ORDER BY (ts DESC, cid ASC);
