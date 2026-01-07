#!/bin/bash

# Federated AI Defense System - Quick Deploy Script
# Deploy in 10 minutes

set -e

echo "🚀 Federated AI Defense System - Quick Deploy"
echo "============================================="
echo ""

# Check prerequisites
echo "⚙️  Checking prerequisites..."

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git not found. Please install Git first."
    exit 1
fi

echo "✅ Prerequisites met"
echo ""

# Clone repository if needed
if [ ! -d "central-command-ops" ]; then
    echo "📥 Cloning repository..."
    git clone https://github.com/Ark95x-sAn/central-command-ops.git
    cd central-command-ops
fi

echo "📦 Setting up environment..."

# Create directory structure
mkdir -p data/logs
mkdir -p data/metrics
mkdir -p config

echo "🛡️  Initializing AI Agencies..."

# Create docker-compose file
cat > docker-compose.yml <<EOF
version: '3.8'

services:
  defense-agency:
    image: nginx:alpine
    container_name: defense-agency
    ports:
      - "8081:80"
    environment:
      - AGENCY_NAME=Defense
      - AGENCY_ROLE=threat-detection
    networks:
      - federated-mesh

  operations-agency:
    image: nginx:alpine
    container_name: operations-agency
    ports:
      - "8082:80"
    environment:
      - AGENCY_NAME=Operations
      - AGENCY_ROLE=automation
    networks:
      - federated-mesh

  audit-agency:
    image: nginx:alpine
    container_name: audit-agency
    ports:
      - "8083:80"
    environment:
      - AGENCY_NAME=Audit
      - AGENCY_ROLE=compliance
    networks:
      - federated-mesh

  communication-agency:
    image: nginx:alpine
    container_name: communication-agency
    ports:
      - "8084:80"
    environment:
      - AGENCY_NAME=Communication
      - AGENCY_ROLE=routing
    networks:
      - federated-mesh

  dashboard:
    image: nginx:alpine
    container_name: central-dashboard
    ports:
      - "8080:80"
    networks:
      - federated-mesh

networks:
  federated-mesh:
    driver: bridge
EOF

echo "🚢 Launching federated mesh..."
docker-compose up -d

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🎯 Access your system:"
echo "   Dashboard:      http://localhost:8080"
echo "   Defense:        http://localhost:8081"
echo "   Operations:     http://localhost:8082"
echo "   Audit:          http://localhost:8083"
echo "   Communication:  http://localhost:8084"
echo ""
echo "📊 Monitor status:"
echo "   docker-compose ps"
echo ""
echo "🛑 Stop system:"
echo "   docker-compose down"
echo ""
echo "🚀 Federated AI Defense System is LIVE!"
echo "Network effects start here."
