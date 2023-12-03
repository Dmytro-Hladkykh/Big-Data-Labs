# Kafka Bitcoin Transactions Processing

This project demonstrates a data storing and processing pipeline using Apache Kafka to process live Bitcoin transactions from Bitstamp WebSocket.

## Environment Description

- **Operating System:** Windows
- **Programming Language:** Python
- **Additional Libraries:** kafka-python, websocket-client
- **Docker and Docker-compose for Kafka setup**

## Kafka Setup

1. Install Docker and Docker-compose.
2. Run the following command to start Kafka and Zookeeper containers:
   docker-compose up -d
3. Verify that Kafka is running on localhost:9092.

## Project Structure

**producer.py:** Connects to Bitstamp WebSocket, listens for Bitcoin transactions, and publishes them to Kafka.
**consumer.py:** Consumes Bitcoin transactions from Kafka, maintains the top 10 transactions by price, and prints them to stdout.

## Running the Project

1. Install required Python libraries:
    pip install kafka-python websocket-client
2. Run the create_topic.sh:
    bash /.create_topic.sh
3. Open two separate terminal windows.
4. In the first terminal, run the Kafka producer:
    python producer.py
5. In the second terminal, run the Kafka consumer:
    python consumer.py

## Additional Notes

-The consumer script prints the top 10 Bitcoin transactions by price after each update. The console is cleared before each update for better visibility.

-Ensure that the Bitstamp WebSocket is accessible for the producer to fetch live Bitcoin transactions.

-This project implements at least once delivery semantics for Kafka messages.

