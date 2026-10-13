
#!/bin/bash

HOST="google.com"
OUTPUT_FILE="ping_results.log"

if ping -c 1 -W 2 "$HOST" > /dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $HOST is reachable" >> "$OUTPUT_FILE"
    echo "$HOST is reachable"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $HOST is not reachable" >> "$OUTPUT_FILE"
    echo "$HOST is not reachable"
fi
