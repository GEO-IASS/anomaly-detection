
#!/bin/sh

# prerequisites
# jdk  1.7 or higher 
# curl
# wget

export DEMO_HOME=`pwd`

# start all
cd $DEMO_HOME

#start cassandra (-f foreground)
CASSANDRA_VERSION=2.2.4
export CASSANDRA_HOME=$DEMO_HOME/apache-cassandra-$CASSANDRA_VERSION
$CASSANDRA_HOME/bin/cassandra &

# load the datasets and set up the cassandra tables
(cd $DEMO_HOME/datasets/cassandra-cql; ./init.sh)

#start spark

SPARK_VERSION=1.5.1
export SPARK_HOME=$DEMO_HOME/spark-$SPARK_VERSION-bin-hadoop2.6
export SPARK_LOCAL_IP=localhost
export SPARK_MASTER_IP=localhost

$SPARK_HOME/sbin/start-all.sh 

# at this point check http://localhost:8080
# you should see your standalone spark cluster up and running

# start the spark-notebook
sed 's#dir = ./notebooks#dir = ../notebooks/spark-notebook#' $DEMO_HOME/spark-notebook/conf/application.conf > $DEMO_HOME/spark-notebook/conf/application.demo.conf
echo -Dconfig.file=./conf/application.demo.conf > $DEMO_HOME/spark-notebook/conf/application.ini
(cd $DEMO_HOME/spark-notebook; ./bin/spark-notebook)


# how to start the spark shell with cassandra support
# this works with spark v1.5.1 (github tag)

# $SPARK_HOME/bin/spark-shell --master spark://localhost:7077                  \
#        --packages com.datastax.spark:spark-cassandra-connector_2.10:1.5.0-M2 \
#        --conf spark.cassandra.connection.host=localhost




