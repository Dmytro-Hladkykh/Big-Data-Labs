#!/bin/bash

# Set up HDFS directories
docker exec -t namenode /bin/bash -c 'hadoop fs -mkdir /tmp'
docker exec -t namenode /bin/bash -c 'hadoop fs -mkdir -p /user/hive/warehouse'
docker exec -t namenode /bin/bash -c 'hadoop fs -chmod g+w /tmp'
docker exec -t namenode /bin/bash -c 'hadoop fs -chmod g+w /user/hive/warehouse'
docker exec -t hive-server /bin/bash -c 'mkdir -p /data'

# Start Hive Server
docker exec -t hive-server /bin/bash -c '$HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false &'

# Create /data directory in HDFS
docker exec -t namenode /bin/bash -c 'hadoop fs -mkdir /data'

# Copy data files to HDFS
docker exec -t namenode /bin/bash -c 'hadoop fs -copyFromLocal /data/flights.csv hdfs://namenode:8020/data/flights.csv'
docker exec -t namenode /bin/bash -c 'hadoop fs -copyFromLocal /data/airlines.csv hdfs://namenode:8020/data/airlines.csv'
docker exec -t namenode /bin/bash -c 'hadoop fs -copyFromLocal /data/airports.csv hdfs://namenode:8020/data/airports.csv'

# Copy Hive script to the Hive container
docker cp /mnt/d/Univer/Big\ Data/Project_Hive/data/flights_table.hql hive-server:/data/flights_table.hql
docker cp /mnt/d/Univer/Big\ Data/Project_Hive/data/query.hql hive-server:/data/query.hql

# Run Hive table creation script
docker exec -t hive-server /bin/bash -c '
  hive -f /data/flights_table.hql &&
  awk -F, '\''{print $5 "," $12}'\'' /data/flights.csv > /data/flights_selected_columns.csv &&
  hadoop fs -put /data/flights_selected_columns.csv hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/flights &&
  hadoop fs -put /data/airlines.csv hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/airlines &&
  hive -f /data/query.hql
'

# Allow the server to process queries before shutting down
sleep 10

# Stop the Hive Server
pkill -f hiveserver2
