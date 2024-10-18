#!/bin/bash
members=($(cat /etc/group | grep "users" | cut -d":" -f4 | tr "," " "))
if [ $1 ] 
then
    case $1 in
        "-b")
            if [ $2 ]
            then
                if [[ $2 -ge "${#members[*]}" || $2 -lt 0 ]]
                then
                    echo "ERROR: No existe un elemento en el indice $2"
                else
                    echo ${members[$2]}
                fi
            else
                echo "ERROR: Falta el parametro correspondiente a la posicion del array"
            fi
        ;;
        "-l")
            echo "La longitud del arreglo es ${#members[*]}"
        ;;
        "-i")
            echo "Los elementos del arreglo son ${members[*]}"
        ;;
        *)
            echo "ERROR: Argumento invalido"
        ;;
    esac
fi
