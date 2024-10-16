#!/bin/bash
if [ $# -ne 3 ]
then
    echo "ERROR: El script debe recibir como parametro una ruta, una opcion y una CADENA"
    exit 1
fi

pushd $1 > /dev/null
for file in *
do
    if [ -f $file ]
    then
        if [ $2 = "-a" ]
        then
            mv $file "${file}${3}"
        elif [ $2 = "-b" ]
        then
            mv $file "${3}${file}"
        else
            echo "ERROR: Opcion invalida: ($2)"
            exit 1
        fi
    fi
done
popd > /dev/null
