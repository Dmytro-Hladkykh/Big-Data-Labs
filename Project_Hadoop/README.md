# MapReduce Analysis of Flight Departure Delays

This project focuses on performing a MapReduce analysis of flight departure delays using the Apache Hadoop framework, with a specific emphasis on the MapReduce paradigm. The dataset used for this analysis is the flight delay dataset from Lab #1.

## Setup and Installation

### Prerequisites
- Docker installed on your machine
- Access to the flight delay dataset (flights.csv)
- Hadoop installed on your machine

### Steps to Run the MapReduce Job

1. **Clone the Repository:**
   ```bash
   git clone <repository_url>
   cd <repository_directory>

2. **Build and Run Docker Containers:**
    ```bash
   docker-compose up -d

3. **Check Python 3 Installation, Install Required Python Packages, Copy Dataset to HDFS and Run MapReduce Job:**
    ```bash
    ./submit_job.sh

### Why Use mrjob for MapReduce?

The choice to use 'mrjob' for implementing the MapReduce job provides several advantages:

1. **Python-Based MapReduce:**

'mrjob' allows writing MapReduce jobs in Python, providing a familiar and concise syntax for developers. This makes it accessible for those already proficient in Python.

2. **Abstraction of Hadoop Complexity:**

'mrjob' abstracts the complexity of Hadoop, allowing users to focus on the logic of the MapReduce job rather than dealing with intricate Hadoop configurations. It simplifies the development process and reduces the learning curve.

