#!/bin/bash
nums=(10 3 5 7 9 3 5 4 1 2 3 4 5 6 7 8 9 55)
cant=0
for n in ${nums[*]}
do 
    if [ $((n % 2)) -eq 0 ]
    then
        echo $n
    else
        let cant++
    fi
done
echo "Hay $cant numeros impares en el array"
