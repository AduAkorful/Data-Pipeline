# Data Pipeline Project

This repository contains a scalable and robust data pipeline architecture using Docker Compose to orchestrate multiple services including Apache Kafka, Zookeeper, MySQL, PostgreSQL, Kafka Connect, and Filebeat. The pipeline is designed for real-time data ingestion, streaming, and log monitoring across relational databases.

## Architecture Overview

**Key Components:**
- **Apache Kafka**: Distributed streaming platform for real-time data pipelines.
- **Zookeeper**: Maintains configuration and synchronization for Kafka.
- **MySQL & PostgreSQL**: Source relational databases.
- **Kafka Connect**: Ingests data changes from MySQL and PostgreSQL into Kafka using Debezium connectors.
- **Filebeat**: Ships logs from containers and databases to Kafka for further processing or analysis.
- **Docker Compose**: Manages and runs the multi-container pipeline.

### Architecture Diagram

```
+-----------+     +-----------+      +-------------+     +------------+
|   MySQL   | --> |           |      |             |     |            |
|  (Source) |     |           |      |             |     |            |
+-----------+     |           |      |             |     |            |
                  |           |      |             |     |            |
+-----------+     |           |      |   Kafka     | --> |  Filebeat  |
| PostgreSQL| --> |  Kafka    | <--> |   Connect   |     |  (Logs to  |
|  (Source) |     |           |      |  (Debezium) |     |   Kafka)   |
+-----------+     |           |      |             |     |            |
                  |           |      |             |     |            |
                  +-----------+      +-------------+     +------------+
                        |                  ^
                        v                  |
                  +-----------+     +-------------+
                  | Zookeeper |     |   Docker    |
                  +-----------+     +-------------+
```

---

## Getting Started

### Prerequisites

- **Docker** and **Docker Compose** installed on your system.

### Setup Instructions

1. **Clone the repository:**
   ```sh
   git clone https://github.com/AduAkorful/Data-Pipeline.git
   cd Data-Pipeline
   ```

2. **Configure Environment:**
   - Edit `filebeat.yml`, `mysql-source-connector.json`, and `postgres-source-connector.json` as needed for your setup.

3. **Start the Pipeline:**
   ```sh
   docker-compose up -d
   ```

4. **Check Service Status:**
   ```sh
   docker-compose ps
   ```

---

## Service Details

### Zookeeper

- Manages and coordinates Kafka brokers.
- Exposes port `32181`.

### Kafka

- Central messaging hub.
- Exposes port `9092`.

### Kafka Connect

- Uses Debezium connectors to stream data changes from MySQL and PostgreSQL into Kafka.
- REST API available on port `8083`.
- Connectors are configured via the `create-connectors.sh` script and JSON files for MySQL and PostgreSQL.

### MySQL & PostgreSQL

- Sample relational databases for data ingestion.
- MySQL: Port `3306`
- PostgreSQL: Port `5432`

### Filebeat

- Collects logs from containers and databases.
- Forwards logs to Kafka (`your-log-topic` by default).
- Configurable via `filebeat.yml`.

---

## Configuration Files

- **`docker-compose.yml`**: Orchestrates all services.
- **`filebeat.yml`**: Configures Filebeat for log collection and forwarding.
- **`mysql-source-connector.json` & `postgres-source-connector.json`**: Define Kafka Connect source connectors for MySQL and PostgreSQL.
- **`create-connectors.sh`**: Shell script to register source connectors on startup.

---

## Customization

- Update database credentials and topics as needed in the environment variables and JSON config files.
- Change log collection paths or Kafka topics in `filebeat.yml` to match your production environment.

---

## Monitoring & Validation

- Use Kafka command-line tools or REST API to check topics and connector status.
- Inspect logs via Filebeat and ensure data is flowing from databases to Kafka.


