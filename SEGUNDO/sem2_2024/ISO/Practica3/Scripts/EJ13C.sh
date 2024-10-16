#!/bin/bash
if [ $# -ne 1 ]
then
    echo "ERROR: El script debe recibir como parametro el nombre de un archivo"
    exit 1
fi

if [ -f $1 ]
then
    echo "El archivo existe y es un archivo regular"
elif [ -d $1 ]
then
    echo "El archivo existe y es un directorio"
else
    mkdir -p $1
    echo "Se creo el directorio $1"
fi
