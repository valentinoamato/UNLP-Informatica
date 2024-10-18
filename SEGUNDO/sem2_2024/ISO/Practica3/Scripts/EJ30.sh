#!/bin/bash
mkdir -p $HOME/bin
cant=0
for f in *
do
    if [ -x $f ]
    then
        mv $f $HOME/bin
        echo $f
        ((cant ++))
    fi
done
if [ $cant -eq 0 ]
then
    echo "No se movio ningun archivo"
else
    echo "Se movieron $cant archivos"
fi
