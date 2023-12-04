# Start Hive Server
docker exec -t hive-server /bin/bash -c '$HIVE_HOME/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false &'

# Copy Hive script to the Hive container
docker cp /data/flights_table.hql hive-server:/data/flights_table.hql

# Run Hive table creation script
docker exec -t hive-server /bin/bash -c 'hive -f /data/flights_table.hql'

# Extract selected columns from CSV using AWK
docker exec -t hive-server /bin/bash -c 'awk -F, '\''{print $5 "," $12}'\'' /data/flights.csv > /data/flights_selected_columns.csv'
docker exec -t hive-server /bin/bash -c 'awk -F, '\''{print $1 "," $2}'\'' /data/airlines.csv > /data/airlines_selected_columns.csv'
docker exec -t hive-server /bin/bash -c 'awk -F, '\''{print $1 "," $3}'\'' /data/airports.csv > /data/airports_selected_columns.csv'

# Function to check and put file in HDFS
check_and_put() {
  local local_file="$1"
  local hdfs_path="$2"

  # Check if the file exists in HDFS
  docker exec -t namenode /bin/bash -c "hadoop fs -test -e $hdfs_path"

  # $? will be 0 if the file exists, 1 otherwise
  if [ $? -ne 0 ]; then
    # File does not exist, perform the put operation
    docker exec -t namenode /bin/bash -c "hadoop fs -put $local_file $hdfs_path"
  else
    echo "File $local_file already exists in HDFS. Skipping put operation."
  fi
}

# Check and put selected columns files in HDFS
check_and_put "/data/flights_selected_columns.csv" "/user/hive/warehouse/flightsdb.db/flights/flights_selected_columns.csv"
check_and_put "/data/airlines_selected_columns.csv" "/user/hive/warehouse/flightsdb.db/airlines/airlines_selected_columns.csv"
check_and_put "/data/airports_selected_columns.csv" "/user/hive/warehouse/flightsdb.db/airports/airports_selected_columns.csv"

# Run Hive query script
docker exec -t hive-server /bin/bash -c 'hive -f /data/query.hql'
