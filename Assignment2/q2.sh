
#!/bin/bash

THRESHOLD=80

df -P | awk 'NR>1 {print $5, $6}' |
while read -r USAGE MOUNT
do
    USAGE=${USAGE%\%}

    if [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "WARNING: Disk usage on $MOUNT is ${USAGE}%"
    else
        echo "OK: Disk usage on $MOUNT is ${USAGE}%"
    fi
done
