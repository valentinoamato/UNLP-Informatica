#!/bin/bash
for i in {1..100}
do
    potencia=$(expr "$i" "*" "$i")
    echo "$i^2=$potencia"
done
