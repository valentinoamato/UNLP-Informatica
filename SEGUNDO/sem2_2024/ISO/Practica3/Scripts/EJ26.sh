#!/bin/bash
if [ $# -eq 0 ]
then
    echo "ERROR: El script debe recibir al menos un parametro"
    exit 1
fi

cant=0
args=$#
for (( i=1; i<=args;i++ ))
do
    ruta=${!i}
    if [ ! -e $ruta ]
    then
        let cant++
        continue
    fi

    if [ $((i % 2)) -ne 0 ]
    then
        if [ -f $ruta ]
        then
            echo "$i: $ruta es un archivo regular"
        elif [ -d $ruta ]
        then
            echo "$i: $ruta es un directorio"
        fi
    fi
done
echo "De los parametros recibidos, $cant corresponden a archivos o directorios inexistentes"
