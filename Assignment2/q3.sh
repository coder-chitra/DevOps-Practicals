
#!/bin/bash

SERVICE="jenkins.service"

if systemctl is-active --quiet "$SERVICE"; then
    echo "$SERVICE is already running."
else
    echo "$SERVICE is not running. Starting service..."

    if sudo systemctl start "$SERVICE"; then
        echo "$SERVICE started successfully."
    else
        echo "Failed to start $SERVICE."
        exit 1
    fi
fi
