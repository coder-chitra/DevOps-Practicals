
#!/bin/bash

read -p "Enter hostname or IP address: " HOST
read -p "Enter output filename: " FILENAME

USERNAME=$(whoami)
OUTPUT="/home/$USERNAME/$FILENAME"

mkdir -p "$(dirname "$OUTPUT")"

if ping -c 1 -W 2 "$HOST" > /dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - SUCCESS: $HOST is reachable" >> "$OUTPUT"
    echo "Host is reachable."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - FAILURE: $HOST is unreachable" >> "$OUTPUT"
    echo "Host is unreachable."
fi
