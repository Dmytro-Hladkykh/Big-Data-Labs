#!/bin/bash

docker exec -it kafka-server kafka-topics.sh --create --topic bitcoin_transactions --bootstrap-server localhost:9092 --partitions 1 --replication-factor 3

docker exec -it kafka-server kafka-topics.sh --list --bootstrap-server localhost:9092
