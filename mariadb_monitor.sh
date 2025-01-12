#!/bin/bash

# Script to monitor MariaDB and restart it if it's down

# Log file for monitoring
LOG_FILE="/var/log/mariadb_monitor.log"

# Function to check MariaDB status
check_mariadb() {
    systemctl is-active --quiet mariadb
    return $?  # Returns 0 if active, non-zero otherwise
}

# Function to restart MariaDB
restart_mariadb() {
    echo "[$(date)] MariaDB is not running. Attempting to restart..." | tee -a "$LOG_FILE"
    systemctl restart mariadb

    # Check if restart was successful
    if systemctl is-active --quiet mariadb; then
        echo "[$(date)] MariaDB successfully restarted." | tee -a "$LOG_FILE"
    else
        echo "[$(date)] Failed to restart MariaDB!" | tee -a "$LOG_FILE"
    fi
}

# Infinite loop to monitor MariaDB
while true; do
    if ! check_mariadb; then
        restart_mariadb
    fi
    sleep 30  # Check every 30 seconds (adjust as needed)
done
