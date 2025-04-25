#!/bin/bash

set -e

IMAGE_NAME="currency-api"
LOCAL_REGISTRY="localhost:5000"
TAG="latest"
FULL_IMAGE="$LOCAL_REGISTRY/$IMAGE_NAME:$TAG"

echo "🚀 starting deploy project"

# Docker registry

echo "🔍 registry existing check"
if ! sudo docker ps | grep -q registry; then
  echo "🧱 registry isn't runnig, deploying registry"
  sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
else
  echo "✅ registry is running"
fi

# Docker image build

echo "🔧 [1/6] building image"
sudo docker build -t $IMAGE_NAME .

# Docker image push

echo "🏷️ [2/6] tagging image to the registry"
sudo docker tag $IMAGE_NAME $FULL_IMAGE

echo "📤 [3/6] pushing image to the registry"
sudo docker push $FULL_IMAGE

# K3S cluster deployment

echo "📁 [4/6] deploying Redis..."
sudo k3s kubectl apply -f deployment/redis-deployment.yaml
sudo k3s kubectl apply -f deployment/redis-service.yaml

echo "🌐 [5/6] deploying Currency API..."
sudo k3s kubectl apply -f deployment/api-deployment.yaml

echo "⏱️ [6/6] deploying Currency Timer..."
sudo k3s kubectl apply -f deployment/timer-deployment.yaml

echo "✅ The clusr is ready"
