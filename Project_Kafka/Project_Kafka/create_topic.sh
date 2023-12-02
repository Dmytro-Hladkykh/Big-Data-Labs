#!/bin/bash

winpty docker exec -it <your_kafka_container_name> kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic bitcoin_transactions
