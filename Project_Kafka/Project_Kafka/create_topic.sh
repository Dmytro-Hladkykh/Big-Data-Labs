#!/bin/bash

docker exec -it kafka-server kafka-topics.sh --create --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 --topic bitcoin_transactions
