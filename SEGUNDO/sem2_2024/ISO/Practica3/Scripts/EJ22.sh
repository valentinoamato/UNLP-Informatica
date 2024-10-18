#!/bin/bash
num=(10 3 5 7 9 3 5 4)
function productoria {
    acumulador=1
    for n in ${num[*]}
    do
        acumulador=$((n * acumulador))
    done
    echo "El resultado es: $acumulador"
}

productoria
