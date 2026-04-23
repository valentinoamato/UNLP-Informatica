# Practica 2
## Ejercicio 1
En este caso el paralelismo de datos es mas adecuado.

N = 100.000.000

Opt = O2

Pc local

La mejora es inconsistente por que N es muy chico.

| threads | tiempo |
| -- | -- |
| secuencial | 0.292534s|
| 2 | 0.168506s |
| 4 | 0.108934s|
| 8 | 0.122452s|

## Ejercicio 2
Particionado de datos.

Opt = O2

PC Local

Se observa un speedup practicamente lineal.

| - | secuencial | T=2 | T=4 | T=8 | promedio c |
| -- | -- | -- | -- | -- | -- |
| N=512 | 0.087350s | 0.045908s | 0.023891s | 0.013094s | 33423488 |
| N=1024 | 0.686385s | 0.361933s | 0.177660s| 0.093056s | 267911424 |
| N=2048 | 5.743635s | 2.959718s | 1.449470s | 0.722967s | 2145387008 |
| N=4096 | 46.493257s | 23.580162s | 11.932825s | 6.164706s | 17171481600 |


## Ejercicio 3
Particionado de datos.

Opt = O2

BS = 64

PC Local

Se observa un speedup practicamente lineal.

| - | T=1 | T=2 | T=4 | T=8 | promedio c |
| -- | -- | -- | -- | -- | -- |
| N=1024 | 0.470440s | 0.241344s | 0.121082s| 0.081644s | 267911424 |
| N=2048 | 4.001364s | 2.031321s | 1.039785s | 0.732112s | 2145387008 |
| N=4096 | 30.708252s | 14.894687s | 7.983445s | 5.657392s | 17171481600 |


## Ejercicio 4
Particionado de datos.

Opt = O2

N = 1.000.000.000

PC Local


| - | N=1G |
| -- | -- |
| secuencial | 0.132611s |
| T=1 | 0.456977s |
| T=2 | 0.230075s |
| T=4 | 0.118174s |
| T=8 | 0.109574s |


## Ejercicio 5
Particionado de datos.

Opt = O2

N = 100.000.000

PC Local


| - | N=100M |
| -- | -- |
| T=1 | 0.132243s |
| T=2 | 0.069946s |
| T=4 | 0.035413s |
| T=8 | 0.022080s |


## Ejercicio 6
En este caso el paralelismo de datos es mas adecuado.

La division de carga es dinamica. Se agrega una constante G que determina la granularidad de la division. Por ejemplo, si G es 20, el vector se divide en 20 partes. A medida que los threads estan listos comienzan a procesar una parte, cuando terminan solicitan otra. Si no hay mas partes termina el programa.

Es como master worker pero no hay master.

N = 100.000.000

Opt = O2

Pc local


| threads | tiempo |
| -- | -- |
| 1 | 0.279314s |
| 2 | 0.304481s |
| 4 | 0.222924s|
| 8 | 0.128107s|
