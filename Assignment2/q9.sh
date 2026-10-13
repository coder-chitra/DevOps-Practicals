
#!/bin/bash

URLS=(
    "https://example.com"
    "https://google.com"
)

for URL in "${URLS[@]}"
do
    RESPONSE_TIME=$(curl -o /dev/null -s -w '%{time_total}' \
        --connect-timeout 10 "$URL")
    STATUS=$?

    if [ "$STATUS" -eq 0 ]; then
        echo "Response time for $URL: $RESPONSE_TIME seconds"
    else
        echo "Failed to connect to $URL"
    fi
done
