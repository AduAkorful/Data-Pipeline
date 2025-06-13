#!/bin/bash

# Set up MySQL connector
curl -X POST -H "Content-Type: application/json" --data @/path/to/mysql-source-connector.json http://localhost:8083/connectors

# Set up Postgres connector
curl -X POST -H "Content-Type: application/json" --data @/path/to/postgres-source-connector.json http://localhost:8083/connectors

