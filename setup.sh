#!/bin/bash
PROJECT_GIT_DIR=$(pwd)
BASE_DIR=$(dirname $PROJECT_GIT_DIR)

cd $BASE_DIR

# getting spark from git repo
SPARK_GIT_DIR=$BASE_DIR/spark.git
time git clone git://github.com/apache/spark.git $SPARK_GIT_DIR
echo

echo "##### Building SPARK instance"
cd $SPARK_GIT_DIR
time build/mvn -DskipTests clean package
echo

#getting mongodb-hadoop from
HADOOP_GIT_DIR=$BASE_DIR/mongodb-hadoop.git
git clone git@github.com:mongodb/mongo-hadoop.git $HADOOP_GIT_DIR
cd $HADOOP_GIT_DIR
./gradlew jar

echo "##### Cloning MongoDB Hadoop Connector Project"
patch $HADOOP_GIT_DIR/core/src/main/java/com/mongodb/hadoop/util/MongoConfigUtil.java $PROJECT_GIT_DIR/com_mongodb_hadoop_util_MongoConfigUtil.java.patch
echo

echo "##### Building MongoDB Hadoop Connector JARS"
cd $HADOOP_GIT_DIR
time ./gradlew jar
echo

# Dependency jars
cd $PROJECT_GIT_DIR
mkdir jars
cp -a $(find $HADOOP_GIT_DIR -name mongo-hadoop-core\*.jar) ./jars/
cp -a $(find $HADOOP_GIT_DIR -name mongo-hadoop-spark\*.jar) ./jars/
curl https://oss.sonatype.org/content/repositories/releases/org/mongodb/mongodb-driver/3.1.1/mongodb-driver-3.1.1.jar > jars/mongodb-driver-3.1.1.jar

TEMP_DIR=./tmp
TEMP_FILE=mstf.csv
mkdir $TEMP_DIR

curl http://www.barchartmarketdata.com/data-samples/$TEMP_FILE > $TEMP_DIR/$TEMP_FILE

DB_NAME=marketdata
COLL_NAME=minibars

mongo $DB_NAME --eval "db.${COLL_NAME}.drop()"
mongoimport $TEMP_DIR/$TEMP_FILE --type csv --headerline -d $DB_NAME -c $COLL_NAME

sudo easy_install pytz