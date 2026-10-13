
#!/bin/bash

FILE="uptime_data.tsv"

# Create the TSV file with a header if it does not exist
if [ ! -f "$FILE" ]; then
    printf "Timestamp\tUptime\n" > "$FILE"
fi

while true
do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    UPTIME=$(uptime -p)

    # Create a temporary file with the newest entry first
    TEMP=$(mktemp)
    printf "%s\t%s\n" "$TIMESTAMP" "$UPTIME" > "$TEMP"
    tail -n +2 "$FILE" >> "$TEMP"
    mv "$TEMP" "$FILE"

    echo "Uptime recorded at $TIMESTAMP"
    sleep 300
done
