#!/bin/bash
select ejercicio in "03. Ejercicio 3" "12. Evaluar Expresiones" "13. Probar estructuras de control" "Salir"
do
    case $ejercicio in
        "03. Ejercicio 3")
            ./EJ3.sh
        ;;
        "12. Evaluar Expresiones")
            echo -n "Ingrese la expresion:"
            read expresion
            ./EJ12.sh $expresion
        ;;
        "13. Probar estructuras de control")
            ./EJ13A.sh
        ;;
        "Salir")
            break
        ;;
    esac
done
