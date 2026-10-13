
#!/bin/bash

for i in {1..5}
do
    for j in {1..10}
    do
        echo "$i x $j = $((i * j))" >> tables.txt
    done
    echo "" >> tables.txt
done

cat tables.txt
