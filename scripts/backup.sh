#!/usr/bin/env bash

BACKUP_DIR="/var/backups/devops-project"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE="$BACKUP_DIR/backup.log"

mkdir -p "$BACKUP_DIR"

echo "[$DATE] Starting backup process..." >> "$LOG_FILE"

# 1. Backup Application Code
tar -czf "$BACKUP_DIR/app-$DATE.tar.gz" -C /home/$USER/devops-lab app 2>> "$LOG_FILE"

# 2. Backup Nginx Configuration
tar -czf "$BACKUP_DIR/nginx-$DATE.tar.gz" -C /home/$USER/devops-lab nginx 2>> "$LOG_FILE"

# 3. Backup Monitoring Configurations
tar -czf "$BACKUP_DIR/monitoring-$DATE.tar.gz" -C /home/$USER/devops-lab monitoring 2>> "$LOG_FILE"

# 4. Remove backups older than 7 days
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -exec rm {} \; 2>> "$LOG_FILE"

echo "[$DATE] Backup completed successfully." >> "$LOG_FILE"
echo "Backup saved in $BACKUP_DIR"

