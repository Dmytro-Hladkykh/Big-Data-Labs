#!/bin/bash

docker exec -it project_kafka-kafka-1 kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic bitcoin_transactions
