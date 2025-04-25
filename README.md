# CurrencyConversionCluster
Overview
This project is a currency conversion service running on a Kubernetes cluster. The cluster consists of 4 pods:

1. Redis: A database used to store currency exchange rates.

2. Timer: A service that fetches all currency exchange rates every minute using an API request and updates the Redis database.

3&4.API Service: Provides an endpoint for fetching currency conversion rates. This service runs with replicas for load balancing.

The system is designed to provide real-time currency conversion by querying the API and storing the rates in Redis. The API service is accessible from outside the Kubernetes cluster, and the data in Redis is continuously updated by the timer.

Technologies Used
Docker: For containerizing the application and services.

Kubernetes (K8S/K3S): For orchestration of the cluster and management of pods and services.
Node.js: Used for the internal API server and auxiliary services.
Redis: Used as the database for storing currency rates.
Bash: For managing the deployment process and automating cluster setup.

Project Structure

Currency-Conversion/
│
├── deployment/                # Kubernetes deployment files
│   ├── api-deployment.yaml    # Deployment config for the API service
│   ├── redis-deployment.yaml  # Deployment config for the Redis service
│   ├── timer-deployment.yaml  # Deployment config for the Timer service
│   └── redis-service.yaml     # Service config for Redis
│
├── code/                      # Auxiliary files, configs, and logic
│   ├── redisClient.js         # Redis client logic for interacting with Redis
│   ├── fetchRates.js          # Logic for fetching currency rates from the API
│   └── config.js              # Configuration file for the project
│
├── app.js                     # Internal API server
├── Dockerfile                 # Dockerfile for building the application image
├── package.json               # npm dependencies and scripts
├── package-lock.json          # npm lock file for reproducible builds
├── node_modules/              # Node.js libraries
├── CurrencyDict.postman_collection.json # Postman collection for API request
├── start-cluster.sh           # Script for starting the Kubernetes cluster
└── README.md                  # Project documentation (this file)
Setup Instructions
Prerequisites
Docker: Make sure Docker is installed and running on your machine.

Kubernetes: A Kubernetes (K3S) cluster running locally or in your environment.

kubectl: Command-line tool for interacting with Kubernetes clusters.

Steps to Deploy
Run the Cluster Setup Script The environment can be easily set up by running the start-cluster.sh script located in the root directory:

chmod +x start-cluster.sh
./start-cluster.sh

Check Deployment To confirm that all services are running properly, you can check the status of your pods and services:

kubectl get pods
kubectl get svc

Access the API Once the services are up and running, you can access the API by using the external IP or the node IP depending on the service type.

API Endpoints
GET /currency: Fetches the latest currency conversion rates stored in Redis.
