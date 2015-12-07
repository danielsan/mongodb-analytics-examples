JARS_DIR=jarz

MONGO_DRIVER_JAR=$(ls $JARS_DIR/mongodb-driver*jar)
HADOOP_JAR=$(ls $JARS_DIR/mongo-hadoop-core*.jar)
SPARK_JAR=$(ls $JARS_DIR/mongo-hadoop-spark*jar)

JARS=$MONGO_DRIVER_JAR,$HADOOP_JAR,$SPARK_JAR

PYFILE=$(echo $0 | sed 's/submit.sh/py/')

../spark.git/bin/spark-submit \
  --driver-class-path $SPARK_JAR \
  --jars $JARS \
  $PYFILE 1
