#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "=========================================="
echo "         DEVOPS SERVER HEALTH CHECK       "
echo "=========================================="

# 1. Docker Engine Check
if systemctl is-active --quiet docker; then
    echo -e "Docker Engine:        ${GREEN}RUNNING${NC}"
else
    echo -e "Docker Engine:        ${RED}STOPPED${NC}"
fi

# 2. Key Containers Check
containers=("nginx-proxy" "devops-web-app" "devops-prometheus" "devops-grafana" "devops-node-exporter" "devops-alertmanager")
for c in "${containers[@]}"; do
    if docker ps --format '{{.Names}}' | grep -q "^${c}$"; then
        echo -e "Container ($c): ${GREEN}UP${NC}"
    else
        echo -e "Container ($c): ${RED}DOWN / NOT FOUND${NC}"
    fi
done

# 3. System Resource Check
echo "------------------------------------------"
echo "CPU Load:     $(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)"
echo "Memory Usage: $(free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }')"
echo "Disk Usage:   $(df -h / | awk 'NR==2 { print $5 }')"
echo "------------------------------------------"

# 4. Web Application Health Endpoint Check
HEALTH_STATUS=$(curl -s http://127.0.0.1/health | grep -o "healthy")
if [ "$HEALTH_STATUS" == "healthy" ]; then
    echo -e "Web App Health (via Nginx): ${GREEN}HEALTHY${NC}"
else
    echo -e "Web App Health (via Nginx): ${RED}UNHEALTHY / DOWN${NC}"
fi
echo "=========================================="

