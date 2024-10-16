#!/bin/bash
select opcion in Listar DondeEstoy QuienEsta
do
    case $opcion in
        Listar)
            ls -l
        ;;
        DondeEstoy)
            pwd
        ;;
        QuienEsta)
            who
        ;;
    esac
done
