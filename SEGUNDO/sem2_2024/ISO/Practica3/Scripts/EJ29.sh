#!/bin/bash
ARRAY=($(find /home -name "*.doc"))

function ver_archivo() {
    if [ $# -ne 1 ] 
    then 
        echo "Error: la funcion recibe un parametro"
        return 1
    fi

    for f in ${ARRAY[@]}
    do
        if [ $1 = $f ]
        then
            cat $f
            break
        elif [ $f = ${ARRAY[-1]} ]
        then
            echo "Archivo no encontrado"
            return 5
        fi
    done
}

function cantidad_archivos() {
    echo ${#ARRAY[*]}
}

function borrarArchivo() {
    if [ $# -ne 1 ] 
    then 
        echo "Error: la funcion recibe un parametro"
        return 1
    fi

    i=0
    for f in ${ARRAY[@]}
    do
        if [ $1 = $f ]
        then
            echo "Desea borrar el archivo logicamente?"
            select opcion in Si No Cancelar
            do
                case $opcion in
                    Si)
                        unset ARRAY[$i]
                    ;;
                    No)
                        unset ARRAY[$i]
                        rm $f
                    ;;
                    Cancelar)
                    ;;
                esac
                break
            done
            break
        elif [ $f = ${ARRAY[-1]} ]
        then
            echo "Archivo no encontrado"
            return 5
        fi
        ((i++))
    done
}
