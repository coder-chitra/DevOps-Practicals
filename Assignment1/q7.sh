
#!/bin/bash

is_prime() {
    NUM=$1

    if [ "$NUM" -lt 2 ]; then
        return 1
    fi

    for ((i=2; i*i<=NUM; i++))
    do
        if (( NUM % i == 0 )); then
            return 1
        fi
    done

    return 0
}

read -p "Enter a number: " N

if is_prime "$N"; then
    echo "$N is a prime number."
else
    echo "$N is not a prime number."
fi
