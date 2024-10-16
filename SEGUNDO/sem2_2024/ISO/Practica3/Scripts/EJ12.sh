#!/bin/bash
if [ $# -ne 3 ]
then
    echo "ERROR: El script debe recibir la operacion y los dos operandos como parametros."
    exit 1
fi
resultado=$(expr "$2" "$1" "$3")
echo "$2 $1 $3 = $resultado"
