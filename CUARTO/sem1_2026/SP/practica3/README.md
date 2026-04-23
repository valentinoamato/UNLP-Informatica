# Practica 3
## Ejercicio 1

La clausula private(i) hace que cada thread tenga su propia variable i, esta se vuelve a inicializar en 0 en cada iteracion y por eso no produce el resultado esperado.

## Ejercicio 2
El problema es que el calculo que se realiza en cada iteracion deel loop (`x += sqrt(i*scale) + 2*x`) requiere de el valor de x de la anterior. Por lo que cada iteracion depende de la anterior, dificultando la paralelizacion.

Para intentar paralelizar separo el calculo en `sqrt(i*scale)` y `2*x`, y hago ambas operaciones en paralelo.

## Ejercicio 3
Ambas soluciones separan a C en una dimension, para aumentar la granularidad se podria separar a C en bloques.

| N=2048 | T=1 | T=2 | T=4 | T=8 |
| -- | -- | -- | -- | -- |
| A | 5.759502s | 2.852876s | 1.439481s | 0.753792s |
| B | 5.724571s | 2.925683s | 1.467167s | 0.793606s |

La solucion A es ligeramente mas rapida ya reparte tareas menos veces.

## Ejercicio 4
Tiempos originales:

N=32768

O2

Al ejecutar con un solo thread obtenemos el tiempo:
- 4.860907s

Sin embargo al usar 4 threads se observa que los threads con id mas chico toman mas tiempo:
- thread 3: 0.357433
- thread 2: 1.077866
- thread 1: 2.020838
- thread 0: 2.824748

Esto es porque al ser la matriz triangular, las primeras filas tienen mas elementos que procesar (elementos no 0) entonces como dividimos el trabajo en filas y asignamos las filas mas dificiles a los threads con id mas bajo, estos tienen mas trabajo y por ende tardan mas.

Para solucionar esto dividiremos el trabajo de forma dinamica, usando la claussula `schedule(dynamic, cs)`. Esta clausula permite distribuir el trabajo bajo demanda. Usando un chunck size de 32, logramos balancear la carga y reducir el tiempo de ejecucion:
- thread 3: 2.339247
- thread 0: 2.339249
- thread 2: 2.339248
- thread 1: 2.339258


## Ejercicio 5
N=2048

O2

| T | t |
| -- | -- |
|original| 11.381252s |
|juntando los fors| 5.746194s |
|sections, T=2|5.692072s |
|sections, T=4|5.681341s |

Se puede observar que aumentar los threads de 2 a 4 no mejora el rendimiento. Esto se debe a que la en nuestro codigo introducimos dos secciones, por lo que mientras dos threads ejecutan estas secciones, los otros dos se quedan ociosos.
