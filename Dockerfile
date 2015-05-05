# Apache Spark
FROM sequenceiq/hadoop-docker:2.6.0
MAINTAINER SequenceIQ

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/spark/access.log
RUN ln -sf /dev/stderr /var/log/spark/error.log

# Support for Hadoop 2.4.0+
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.3.0-bin-hadoop2.4.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.3.0-bin-hadoop2.4 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-1.3.0-bin-hadoop2.4/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV SPARK_JAR hdfs:///spark/spark-assembly-1.3.0-hadoop2.4.0.jar
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

# Update boot script
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

ENTRYPOINT ["/etc/bootstrap.sh"]

# Pipe the following command to the Spark Shell.
# Output should return 10000.
RUN echo "sc.parallelize(1 to 10000).count()" | \
spark-shell --master yarn-client --driver-memory 1g --executor-memory 1g --executor-cores 1