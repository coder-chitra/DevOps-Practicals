
#!/bin/bash

read -p "Enter directory path: " DIR
REPORT="error_report.txt"

if [ ! -d "$DIR" ]; then
    echo "Directory does not exist!"
    exit 1
fi

> "$REPORT"

find "$DIR" -type f -name "*.txt" | while read -r FILE
do
    COUNT=$(grep -ic "error" "$FILE")
    echo "$FILE : $COUNT" >> "$REPORT"
done

echo "Report generated successfully."
cat "$REPORT"
