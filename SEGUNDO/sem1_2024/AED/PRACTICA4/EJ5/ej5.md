## A - Analizar si todos los algoritmos terminan o alguno puede quedar en loop infinito. 
Todos los algoritmos terminan.

## B - Describa con palabras la cantidad de operaciones que realizan.
> randomUno: 

* Crea un array de enteros de longitud n
* Por cada posicion del array
* Genera un numero aleatorio
* Busca el numero en el array
* Si lo encuentra vuelve a generar otro numero
* Si no lo encuentra lo asigna a la posicion actual del vector 

> randomDos:
* Crea un array "used" de booleanos de longitud n
* Llena "used" de false, recorriendolo por completo
* Crea un array "a" de enteros de longitud n
* Por cada posicion de "a"
* Genera un numero aleatorio "x"
* Se fija en el indice "x" de "used"
* Si encuentra true genera otro numero
* Sino asigna "x" a la posicion actual de "a" y actualiza "used"

> randomTres:
 * Crea un array de enteros con longitud n
 * Asigna a cada elemento el valor de su indice
 * Por cada elemento del array
 * Intercambia dentro del array el elemento actual por otro aleatorio