#!/bin/bash

# Get the current working directory
PROJECT_FOLDER="$(pwd)"

# Debugging: Print the current working directory
echo "Current working directory: $PROJECT_FOLDER"

# Execute the Hive table creation script
docker exec -t hive-server /bin/bash -c 'hive -f $PROJECT_FOLDER/data/flights_table.hql'

# Extract and select specific columns from the CSV file
docker exec -t hive-server /bin/bash -c 'awk -F "," '\''{print $5 "," $12}'\'' $PROJECT_FOLDER/data/flights.csv > $PROJECT_FOLDER/data/flights_selected_columns.csv'

# Upload the selected columns CSV file to HDFS
docker exec -t hive-server /bin/bash -c 'hadoop fs -put $PROJECT_FOLDER/data/flights_selected_columns.csv hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/flights'

# Upload the airlines CSV file to HDFS
docker exec -t hive-server /bin/bash -c 'hadoop fs -put $PROJECT_FOLDER/data/airlines.csv hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/airlines'

# Execute the Hive query script
docker exec -t hive-server /bin/bash -c 'hive -f $PROJECT_FOLDER/data/query.hql'
