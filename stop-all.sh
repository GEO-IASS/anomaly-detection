
#!/bin/sh

# prerequisites
# jdk  1.7 or higher 
# curl
# wget

export DEMO_HOME=`pwd`

# start all
cd $DEMO_HOME

############################
CASSANDRA_VERSION=2.2.4
export CASSANDRA_HOME=$DEMO_HOME/apache-cassandra-$CASSANDRA_VERSION
ps auwx | grep cassandra
kill pid

############################
SPARK_VERSION=1.5.1
export SPARK_HOME=$DEMO_HOME/spark-$SPARK_VERSION-bin-hadoop2.6
export SPARK_LOCAL_IP=localhost
export SPARK_MASTER_IP=localhost

$SPARK_HOME/sbin/stop-all.sh 

