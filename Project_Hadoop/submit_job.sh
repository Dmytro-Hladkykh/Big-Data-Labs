containers=("project_hadoop-namenode-1" "project_hadoop-datanode-1" "project_hadoop-resourcemanager-1" "project_hadoop-nodemanager-1")
script_path="/my_volume/mapreduce.py"
dataset_path="/my_volume/dataset/flights.csv"
hdfs_path="/flights.csv"

# Function for centralized error handling
handle_error() {
    echo "Error: $1"
    exit 1
}

# Function to print informational messages
info_message() {
    echo "INFO: $1"
}

# Check for Python 3 and install if needed
for container in "${containers[@]}"; do
    info_message "Checking for Python 3 on $container..."
    if docker exec -t "$container" command -v python3 & /dev/null; then
        info_message "Python 3 already installed on $container."
    else
        info_message "Installing Python 3 on $container..."
        docker exec -t "$container" sudo yum -y install python3 || handle_error "Failed to install Python 3 on $container."
        info_message "Python 3 installed on $container."
    fi
done

# Install necessary packages
info_message "Installing necessary packages on ${containers[0]}..."
docker exec -t "${containers[0]}" sudo pip3 install mrjob || handle_error "Failed to install mrjob on ${containers[0]}."
info_message "Packages installed on ${containers[0]}."

# Copy file to HDFS
info_message "Copying file to HDFS on ${containers[0]}..."
docker exec -t "${containers[0]}" hdfs dfs -put /my_volume/dataset/flights.csv /

# Environment initialization
info_message "Environment initialization..."
docker exec -t "${containers[0]}" chmod u+x /my_volume/mapreduce.py
info_message "Completed"

# Run MapReduce task
info_message "Running MapReduce task..."
docker exec -t "${containers[0]}" python3 /my_volume/mapreduce.py -r hadoop hdfs:///flights.csv
info_message "MapReduce task completed successfully."
