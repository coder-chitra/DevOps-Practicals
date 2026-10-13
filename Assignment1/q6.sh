
#!/bin/bash

read -p "Enter log filename: " FILE

if [ ! -f "$FILE" ]; then
    echo "File does not exist!"
    exit 1
fi

echo "IP Addresses:"
grep -Eo '(^|[^0-9.])([0-9]{1,3}\.){3}[0-9]{1,3}([^0-9.]|$)' "$FILE" |
while read -r MATCH
do
    IP=$(echo "$MATCH" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')
    if [ -n "$IP" ] && awk -v ip="$IP" 'BEGIN {
        n=split(ip,a,".");
        for(i=1;i<=n;i++)
            if(a[i]<0 || a[i]>255) exit 1;
        exit 0
    }'
    then
        echo "$IP"
    fi
done

echo "Date-Time Stamps:"
grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}[ T][0-9]{2}:[0-9]{2}:[0-9]{2}' "$FILE"

echo "Error Messages:"
grep -i 'error' "$FILE"
