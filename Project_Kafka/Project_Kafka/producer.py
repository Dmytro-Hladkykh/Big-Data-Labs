import json
import time
import websocket
import threading
from kafka import KafkaProducer

# Kafka Bootstrap Servers
bootstrap_servers = 'localhost:9092'
# Kafka Topic
topic = 'bitcoin_transactions'

# Create Kafka Producer
producer = KafkaProducer(bootstrap_servers=bootstrap_servers)

def on_message(ws, message):
    # Parse the received JSON message
    data = json.loads(message)
    
    # Publish the message to Kafka topic
    producer.send(topic, json.dumps(data).encode('utf-8'))
    print(f"Published message to Kafka: {data}")

# WebSocket URL
websocket_url = 'wss://ws.bitstamp.net'

# Connect to Bitstamp WebSocket
ws = websocket.WebSocketApp(websocket_url, on_message=on_message)

# Run WebSocket in a separate thread
ws_thread = threading.Thread(target=ws.run_forever)
ws_thread.start()

# Sleep for a while to allow WebSocket connection to establish
time.sleep(5)

# Send a subscription request to Bitstamp WebSocket
subscription_request = {
    "event": "bts:subscribe",
    "data": {
        "channel": "live_orders_btcusd"
    }
}
ws.send(json.dumps(subscription_request))

# Keep the script running
while True:
    time.sleep(1)
