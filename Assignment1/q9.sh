
#!/bin/bash

FILE="employees.csv"

echo "Average Salary by Department:"

awk -F',' '
NR > 1 {
    sum[$2] += $3
    count[$2]++
}
END {
    for (dept in sum)
        printf "%s: %.2f\n", dept, sum[dept]/count[dept]
}' "$FILE"

echo ""
echo "Employees with more than 5 years of service:"

TODAY=$(date +%s)

awk -F',' -v today="$TODAY" '
NR > 1 {
    command = "date -d \"" $4 "\" +%s"
    command | getline join_time
    close(command)

    if (join_time != "" &&
        today - join_time > 5*365*24*60*60)
        print $1
}' "$FILE"
