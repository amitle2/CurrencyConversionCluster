# Currency Conversion Cluster

A fast and scalable internal microservice for real-time currency exchange rates, optimized to reduce external API calls, network latency, and operational costs.

---

## 📚 Project Overview

In traditional systems, every transaction involving foreign currencies made an external API call to retrieve live exchange rates, causing:

- High network latency
- Authentication and cryptography overhead
- Increased CPU and bandwidth consumption
- Higher operational costs

**Our solution**:  
A lightweight Kubernetes (K3S) cluster running an internal service that pulls all exchange rates once per minute and caches them in Redis for instant access by internal applications.

---

## 🏗️ Architecture

- **Redis Database**  
  Stores all currency rates as `Key: Currency Code → Value: Exchange Rate`.  
  Updated every minute.

- **Node.js Timer Service**  
  - Pulls all rates from an external API once per minute.
  - Pushes updated rates into Redis.

- **Node.js API Service**  
  - Exposes a simple HTTP API (`/convert?currency=XXX`) to retrieve a specific currency rate.
  - Fetches data from Redis instantly.

- **Docker Internal Registry**  
  - Images are built and pushed internally for faster deployment.

---

## 📂 Project Structure

```plaintext
CurrencyConversion/
├── app.js                       # API server
├── code/
│   ├── config.js                 # Timer logic: updates rates every minute
│   ├── fetchRates.js             # Fetches rates from external API
│   └── redisClient.js            # Redis connection setup
├── deployment/
│   ├── api-deployment.yaml       # Deployment for the API service
│   ├── redis-deployment.yaml     # Deployment for the Redis server
│   ├── redis-service.yaml        # Service for Redis
│   ├── timer-deployment.yaml     # Deployment for the Timer service
├── CurrencyDict.postman_collection.json # Postman collection for testing
├── Dockerfile                    # Docker image build configuration
├── node_modules/                 # npm dependencies
├── package.json                  # npm dependencies and scripts
├── package-lock.json             # Exact version locking for npm
└── start-cluster.sh              # Bash script to deploy the whole cluster
