# Linux Server Monitoring, Automation and Web Application Deployment Platform

An end-to-end DevOps lab built on Ubuntu 26.04 LTS (VMware Workstation) featuring containerized application deployment, reverse proxy architecture, real-time observability, automated alerts, system health scripting, daily backups, and Ansible configuration management.

## Architecture Overview
- **Web Layer**: Nginx Reverse Proxy (Port 80) routing incoming requests to a containerized Python/Flask app (Port 5000).
- **Monitoring Stack**: Node Exporter (Port 9100), Prometheus (Port 9090), and Grafana (Port 3000).
- **Alerting**: Alertmanager (Port 9093) integrated with Prometheus alert rules.
- **Automation**: Bash scripts for health checks and automated daily cron backups; Ansible playbooks for server bootstrapping.

## Repository Structure

