#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Error: el script debe recibir un parametro"
    exit 1
fi

if [ ! -d $1 ]
then
    echo "Error: el directorio $1 no existe"
    exit 4
fi

wcount=0
rcount=0
pushd $1 > /dev/null
for f in *
do
    if [ -w $f ]
    then
        ((wcount++))
    fi

    if [ -r $f ]
    then
        ((rcount++))
    fi
done
popd > /dev/null
echo "Se encontraron $wcount archivos con permiso de escritura"
echo "Se encontraron $rcount archivos con permiso de lectura"
