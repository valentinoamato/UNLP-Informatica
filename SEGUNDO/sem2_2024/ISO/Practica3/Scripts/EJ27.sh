#!/bin/bash
function inicializar() {
    ARRAY=()
}

function agregar_elem() {
    if [ $# -ne 1 ] 
    then
        echo "Error: la function debe recibir solo un parametro"
        return 1
    fi
    ARRAY+=($1)
}

function eliminar_elem() {
    if [ $# -ne 1 ]
    then
        echo "Error: la funcion debe recibir un parametro"
        return 1
    fi

    if [ $1 -ge ${#ARRAY[*]} ]
    then
        echo "Error: el indice $1 no corresponde a un elemento del array"
        exit 1
    fi

    unset ARRAY[$1]
}

function longitud() {
    echo ${#ARRAY[*]}
}

function imprimir() {
    echo ${ARRAY[*]}
}

function inicializar_con_valores() {
    if [ $# -ne 2 ]
    then
        echo "Error: la funcion debe recibir dos parametros"
        return 1
    fi

    for (( i=1;i<=$1;i++ ))
    do
        ARRAY+=($2)
    done
}
