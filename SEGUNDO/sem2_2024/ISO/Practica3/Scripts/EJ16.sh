#!/bin/bash
if [ $# -ne 1 ]
then 
    echo "ERROR: El script debe recibir como parametro una extension"
    exit 1
fi
TMPFILE=$(mktemp)
pushd /home > /dev/null
for folder in *
do
    output="$folder $(find "$folder" -name "*.$1" | wc -l)"
    echo $output
    echo $output >> $TMPFILE
done
popd > /dev/null
mv $TMPFILE ./reportes.txt
