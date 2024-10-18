#!/bin/bash
vector1=( 1 80 65 35 2 )
vector2=( 5 98 3 41 8 )
len=${#vector1[*]}
for (( i=0; i<len; i++ ))
do
    e1=${vector1[$i]}
    e2=${vector2[$i]}
    echo "La suma de los elementos ded la posicion $i de los vectores es $((e1 + e2))"
done
