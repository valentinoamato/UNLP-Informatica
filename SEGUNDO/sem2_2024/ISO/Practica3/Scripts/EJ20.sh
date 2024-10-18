#!/bin/bash
STACK=()

function push() {
    if [ $# -ne 1 ]
    then
        echo "ERROR: The function needs the item to push as a parameter"
        return 1
    fi
    STACK+=("$1")
}

function length() {
    echo ${#STACK[*]}
}

function pop() {
    len="$(length)"
    if [ "$len" -eq 0 ]
    then
        echo "ERROR: The stack is empty"
        return 1
    fi
    unset STACK[$((len - 1))]
}

function print() {
    for item in ${STACK[@]}
    do
        echo $item
    done
}
