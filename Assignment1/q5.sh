
#!/bin/bash

read -p "Enter number of iterations: " N
LOG="cpu_usage.log"

for ((i=1; i<=N; i++))
do
    IDLE=$(top -bn1 | awk '/Cpu\(s\)/ {print $8; exit}')

    if [ -z "$IDLE" ]; then
        echo "Unable to read CPU usage."
        exit 1
    fi

    CPU=$(awk -v idle="$IDLE" 'BEGIN {printf "%.2f", 100-idle}')

    echo "Iteration $i: CPU Usage = $CPU%"

    if awk -v cpu="$CPU" 'BEGIN {exit !(cpu > 90)}'; then
        echo "CPU usage exceeded 90%. Stopping."
        break
    fi

    if awk -v cpu="$CPU" 'BEGIN {exit !(cpu < 10)}'; then
        echo "CPU below 10%. Skipping log."
        continue
    fi

    echo "$(date) - CPU Usage: $CPU%" >> "$LOG"
    sleep 1
done

echo "Monitoring completed."
