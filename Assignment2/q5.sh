
#!/bin/bash

DB_NAME="school"
BACKUP_DIR="/backups"
DATE=$(date '+%Y%m%d_%H%M%S')
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

if ! mkdir -p "$BACKUP_DIR"; then
    echo "Unable to create backup directory."
    exit 1
fi

read -s -p "Enter MySQL root password: " DB_PASSWORD
echo ""

if mysqldump -u root -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"; then
    echo "Database backup completed: $BACKUP_FILE"
else
    echo "Database backup failed!"
    rm -f "$BACKUP_FILE"
    exit 1
fi

unset DB_PASSWORD
