
#!/bin/bash

SOURCE="/home/ubuntu/data"
BACKUP_DIR="/home/ubuntu/backups"
LOG="/home/userlog"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
ARCHIVE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
TEMP=$(mktemp)

cleanup() {
    rm -f "$TEMP"
}
trap cleanup EXIT

if [ ! -d "$SOURCE" ]; then
    echo "$(date) ERROR: Source directory missing" >> "$LOG"
    exit 1
fi

if ! find "$SOURCE" -type f -mmin -1440 -print0 > "$TEMP"; then
    echo "$(date) ERROR: Could not find files" >> "$LOG"
    exit 1
fi

if [ ! -s "$TEMP" ]; then
    echo "$(date) INFO: No files modified in last 24 hours" >> "$LOG"
    exit 0
fi

if tar --null -czf "$ARCHIVE" -T "$TEMP"; then
    echo "$(date) SUCCESS: Backup created at $ARCHIVE" >> "$LOG"
else
    echo "$(date) ERROR: Backup failed" >> "$LOG"
    rm -f "$ARCHIVE"
    exit 1
fi
