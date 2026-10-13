
#!/bin/bash

SOURCE="/home/user/data"
DESTINATION="/backup"
DATE=$(date '+%Y%m%d_%H%M%S')

if [ ! -d "$SOURCE" ]; then
    echo "Source directory does not exist!"
    exit 1
fi

mkdir -p "$DESTINATION/$DATE"

if cp -r "$SOURCE" "$DESTINATION/$DATE/"; then
    echo "Backup completed successfully on $DATE"
else
    echo "Backup failed!"
    exit 1
fi
