
#!/bin/sh

# prerequisites
# jdk  1.7 or higher 
# git
# maven 

export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"
DEMO_HOME=`pwd`

### CASSANDRA #################################################
CASSANDRA_DOWNLOAD_VERSION='2.2.4'

CASSANDRA_DOWNLOAD_PATH=cassandra/${CASSANDRA_DOWNLOAD_VERSION}/apache-cassandra-${CASSANDRA_DOWNLOAD_VERSION}-bin.tar.gz
CASSANDRA_DOWNLOAD_MIRROR=`curl -s "http://www.apache.org/dyn/closer.cgi?path=/${CASSANDRA_DOWNLOAD_PATH}&as_json=1" | \
                             python -c 'import json,sys;obj=json.load(sys.stdin);print obj["http"][1]' `

wget $CASSANDRA_DOWNLOAD_MIRROR$CASSANDRA_DOWNLOAD_PATH
tar -zxf apache-cassandra-${CASSANDRA_DOWNLOAD_VERSION}-bin.tar.gz

CASSANDRA_HOME=$DEMO_HOME/apache-cassandra-${CASSANDRA_DOWNLOAD_VERSION}

### SPARK #################################################
SPARK_DOWNLOAD_VERSION='1.5.1'

SPARK_DOWNLOAD_PATH=spark/spark-${SPARK_DOWNLOAD_VERSION}/spark-${SPARK_DOWNLOAD_VERSION}-bin-hadoop2.6.tgz
SPARK_DOWNLOAD_MIRROR=`curl -s "http://www.apache.org/dyn/closer.cgi?path=/${SPARK_DOWNLOAD_PATH}&as_json=1" | \
                             python -c 'import json,sys;obj=json.load(sys.stdin);print obj["http"][1]' `

wget $SPARK_DOWNLOAD_MIRROR$SPARK_DOWNLOAD_PATH
tar -zxf spark-${SPARK_DOWNLOAD_VERSION}-bin-hadoop2.6.tgz

SPARK_HOME=$DEMO_HOME/spark-${SPARK_DOWNLOAD_VERSION}-bin-hadoop2.6

cp $SPARK_HOME/conf/spark-defaults.conf.template $SPARK_HOME/conf/spark-defaults.conf

cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
echo >> $SPARK_HOME/conf/spark-env.sh
echo "export SPARK_LOCAL_IP=localhost" >> $SPARK_HOME/conf/spark-env.sh
echo "export SPARK_MASTER_IP=localhost" >> $SPARK_HOME/conf/spark-env.sh

sed 's/log4j.rootCategory=INFO, console/log4j.rootCategory=WARN, console/' \
    $SPARK_HOME/conf/log4j.properties.template > $SPARK_HOME/conf/log4j.properties

### SPARK-NOTEBOOK #################################################

# Download from  http://spark-notebook.io

# With the following parameters

#   notebook version : master
#   scala version : 2.10.4
#   spark version : 1.5.1
#   hadoop version : 2.6.0
#   with hive : false
#   with parquet : false
#   package type : tgz

# you shoud receive a file named:
# spark-notebook-master-scala-2.10.4-spark-1.5.1-hadoop-2.6.0.tar

#######################################################################

# if you are having trouble with the spark notebook missing some packages / jars
# try to install them directly using maven as show below, or restart the notebook: 
# sometimes network connection could be the issue.

#mvn dependency:get -Dartifact=asm:asm:3.2
#mvn dependency:get -Dartifact=net.sourceforge.f2j:arpack_combined_all:0.1

## NAK ################################################################
# Example on how to publish locally libraries and use them in spark

# build and publish locally
git clone https://github.com/scalanlp/nak.git
cd $DEMO_HOME/nak/
sbt clean publishM2

cd $DEMO_HOME
#######################################################################
# Congratulations, you can move to the start_all.sh script now and run the system
