#!/bin/bash

# Set your project folder
PROJECT_FOLDER=/mnt/d/Univer/Laba/Big-Data-Labs/Project_Hive

docker exec -t hive-server /bin/bash -c '
hive -f /data/flights_table.hql &&
awk -F "," '\''{print $5 "," $12}'\'' /data/flights.csv > /data/flights_selected_columns.csv &&
hadoop fs -put /data/flights_selected_columns.csv hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/flights &&
hadoop fs -put /data/airlines.csv hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/airlines &&
hive -f /data/query.hql
'

