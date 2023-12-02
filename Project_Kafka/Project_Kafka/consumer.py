from kafka import KafkaConsumer
import json
import os

# Kafka Bootstrap Servers
bootstrap_servers = 'localhost:9092'
# Kafka Topic
topic = 'bitcoin_transactions'

# Create Kafka Consumer
consumer = KafkaConsumer(topic, bootstrap_servers=bootstrap_servers, group_id='bitcoin-group')

# Top 10 transactions list
top_transactions = []

def process_message(message):
    global top_transactions  # Оголошуємо змінну як глобальну

    # Parse the received JSON message
    data = json.loads(message.value.decode('utf-8'))
    
    # Check if the 'data' key and 'price' key exist in the message
    if 'data' in data and 'price' in data['data']:
        transaction = {
            'id': data['data']['id'],
            'price': float(data['data']['price'])
        }

        # Maintain the top 10 transactions
        top_transactions.append(transaction)
        top_transactions = sorted(top_transactions, key=lambda x: x['price'], reverse=True)[:10]

        print(f"Processed message from Kafka: {transaction}")
    else:
        print(f"Message from Kafka does not contain expected data structure: {data}")

# Consume messages from Kafka
for message in consumer:
    process_message(message)

    # Перед виведенням топ-10 транзакцій очистіть консоль
    os.system('cls' if os.name == 'nt' else 'clear')

    # Виведення топ-10 транзакцій
    print("Top 10 Transactions:")
    for transaction in top_transactions:
        print(f"ID: {transaction['id']}, Price: {transaction['price']}")
