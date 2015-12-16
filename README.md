# Anomaly-detection
A repository on how to build data-driven application using Spark, Cassandra and Akka. 
It uses a publicly available check-ins dataset to experiment with event processing, machine learning and analytics and api's.

## Getting started

First off, run the install script `install.sh` it will pull cassandra and spark in the demo root directory.
If you have spark and cassandra running elsewhere on the same machine, make sure you stop those processes first. Or you can run the entire demo in a fresh virtual machine (check vagrant for that). 

## Spark Notebook

Download it from  http://spark-notebook.io

As of writing, I have used the following parameters:

  - notebook version : master
  - scala version : 2.10.4
  - spark version : 1.5.1
  - hadoop version : 2.6.0
  - with hive : false
  - with parquet : false
  - package type : tgz

you shoud be able to download a file named:
spark-notebook-master-scala-2.10.4-spark-1.5.1-hadoop-2.6.0.tar

untar it, rename it as `spark-notebook`


## Start it all

Run the `start-all.sh` script to start cassandra and spark. Note that spark is started in standalone cluster mode and requires ssh connection to be established between master and worker processes. This script will also create and load the cassandra tables.


