
#!/bin/bash

read -p "Enter directory path: " DIR
read -p "Enter log filename: " FILENAME

USERNAME=$(whoami)
LOG="/home/$USERNAME/$FILENAME"
THRESHOLD=500

if [ ! -d "$DIR" ]; then
    echo "Directory does not exist!"
    exit 1
fi

SIZE=$(du -sm "$DIR" | awk '{print $1}')

if [ "$SIZE" -gt "$THRESHOLD" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') WARNING: $DIR size is ${SIZE}MB" >> "$LOG"
    echo "Warning logged: Directory exceeds 500 MB."
else
    echo "Directory size is ${SIZE}MB. Limit not exceeded."
fi
