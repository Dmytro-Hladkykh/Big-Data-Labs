# Hive Big Data Project

This project demonstrates the use of Apache Hive for big data processing. It involves setting up a Hadoop cluster using Docker containers, creating external Hive tables, and executing queries to analyze flight data.

## Prerequisites

- Docker installed on your machine
- Docker Compose installed on your machine

## Getting Started

1. Clone this repository:

   ```bash
   git clone https://github.com/your-username/hive-big-data-project.git
   cd hive-big-data-project
   ```

2. Create the necessary directories for HDFS data:

   ```bash
   mkdir -p ./hdfs/namenode
   mkdir -p ./hdfs/datanode
   ```

3. Build and start the Docker containers:

   ```bash
   docker-compose up -d
   ```

   This will start Hadoop services, Hive Server, and the PostgreSQL-backed Hive Metastore.

4. Execute the submit.sh script to set up HDFS and run Hive queries:

   ```bash
   ./submit.sh
   ```

5. Explore the results by connecting to the Hive Server or viewing HDFS data.

## Hive Queries

The project includes Hive queries for creating external tables and performing data analysis. You can find the queries in the data directory:
- flights_table.hql: Creates external tables for flights, airlines, and the top airlines.
- query.hql: Performs analysis on flight data and populates the top_airlines table.

## Directory Structure

- data/: Contains Hive queries and data files.
- hdfs/: Mount points for Hadoop Distributed File System.
- metastore-postgresql/: PostgreSQL data directory for the Hive Metastore.