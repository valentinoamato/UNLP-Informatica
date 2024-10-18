#!/bin/bash
if [ $# -ne 1 ]
then
    echo "ERROR: El script debe recibir como unico parametro el nombre del usuario"
    exit 1
fi

while true
do
    who | grep "$1"
    if [ $? -eq 0 ]
    then
        echo "Usuario $1 logueado en el sistema"
        break
    fi
    sleep 10
done
