
PROJECT_GIT_DIR=$(pwd)
BASE_DIR=$(dirname $PROJECT_GIT_DIR)

cd $BASE_DIR

# getting spark from git repo
SPARK_GIT_DIR=$BASE_DIR/spark.git
git clone git://github.com/apache/spark.git $SPARK_GIT_DIR

#getting mongodb-hadoop from
HADOOP_GIT_DIR=$BASE_DIR/mongodb-hadoop.git
git clone git@github.com:mongodb/mongo-hadoop.git $HADOOP_GIT_DIR
cd $HADOOP_GIT_DIR
./gradlew jar

# getting the project
cd $BASE_DIR
PROJECT_GIT_DIR=$BASE_DIR/mongodb-analytics-examples
git clone git@github.com:danielsan/mongodb-analytics-examples.git $PROJECT_GIT_DIR

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