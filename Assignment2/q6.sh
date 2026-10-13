
#!/bin/bash

LOG_FILE="system_uptime.log"

echo "Timestamp: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
echo "System Uptime: $(uptime -p)" >> "$LOG_FILE"
echo "-----------------------------" >> "$LOG_FILE"

echo "System uptime saved to $LOG_FILE"
