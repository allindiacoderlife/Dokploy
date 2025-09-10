#!/bin/bash

# Uninstall Dokploy and related resources only (does not affect Coolify)

set -e

# Remove Dokploy Docker services (if running in Swarm mode)
docker service rm dokploy dokploy-postgres dokploy-redis 2>/dev/null || true

# Remove Dokploy Traefik container (if running as a container)
docker stop dokploy-traefik 2>/dev/null || true
docker rm dokploy-traefik 2>/dev/null || true

# Remove Dokploy Docker network
docker network rm dokploy-network 2>/dev/null || true

# Remove Dokploy Docker volumes
docker volume rm dokploy-postgres-database dokploy-docker-config redis-data-volume 2>/dev/null || true

# Remove Dokploy config directory
rm -rf /etc/dokploy

# Optional: Remove Dokploy images (uncomment if you want to delete images too)
# docker rmi dokploy/dokploy:latest postgres:16 redis:7 traefik:v3.5.0 2>/dev/null || true

echo "Dokploy and its resources have been uninstalled. Coolify and other services are untouched."
