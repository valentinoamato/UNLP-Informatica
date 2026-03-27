# Practica 1

## 1
| n |iterativo  | recursivo |
| -- | -- | -- |
| 1 | 0ns|95ns |
| 5 | 0ns|119ns |
| 10 | 0ns|190ns |
| 25 | 0ns|240us |
| 50 | 0ns|> 5m |

El algoritmo iterativo es mas rapido ya que tiene un orden de tiempo de ejecucion lineal, mientras que el recursivo tiene tiempo de ejecucion de orden cuadratico.

## 2
Ejecutando varias veces, el programa toma tiempos similares siempre:
```
Funcion calculada...
 Tiempo total en segundos 0.2694830894
 Tiempo promedio en segundos 0.0000000027
Funcion calculada cada vez...
 Tiempo total en segundos 0.2633130550
 Tiempo promedio en segundos 0.0000000026
```
En teoria el primer metodo es mas rapido ya que ejecuta menos instrucciones.

## 3
Documentacion:

Depending on the target and how GCC was configured, a slightly different set of optimizations may be enabled at each -O level than those listed here. You can invoke GCC
with -Q --help=optimizers to find out the exact set of optimizations that are enabled at
each level.

- `-O1` Optimize. Optimizing compilation takes somewhat more time, and a lot more
memory for a large function.
With -O, the compiler tries to reduce code size and execution time, without
performing any optimizations that take a great deal of compilation time.
-O is the recommended optimization level for large machine-generated code
as a sensible balance between time taken to compile and memory use: higher
optimization levels perform optimizations with greater algorithmic complexity
than at -O.

- `-O2` Optimize even more. GCC performs nearly all supported optimizations that
do not involve a space-speed tradeoff. As compared to -O, this option increases
both compilation time and the performance of the generated code.
- `-O3` Optimize yet more.
- `-O0` Reduce compilation time and make debugging produce the expected results.
This is the default.
At -O0, GCC completely disables most optimization passes; they are not run
even if you explicitly enable them on the command line, or are listed by -Q
--help=optimizers as being enabled by default. Many optimizations per-
formed by GCC depend on code analysis or canonicalization passes that are
enabled by -O, and it would not be useful to run individual optimization passes
in isolation.
- `-Os` Optimize for size. -Os enables all -O2 optimizations except those that often
increase code size.
It also enables -finline-functions, causes the compiler to tune for code size
rather than execution speed, and performs further optimizations designed to
reduce code size.
- `-Ofast` Disregard strict standards compliance. -Ofast enables all -O3 optimizations.
It also enables optimizations that are not valid for all standard-compliant
programs.
- `-Og` Optimize debugging experience. -Og should be the optimization level of choice
for the standard edit-compile-debug cycle, offering a reasonable level of optimization
while maintaining fast compilation and a good debugging experience.
It is a better choice than -O0 for producing debuggable code because some
compiler passes that collect debug information are disabled at -O0.
Like -O0, -Og completely disables a number of optimization passes so that
individual options controlling them have no effect. Otherwise -Og enables all
-O1 optimization flags except for those that may interfere with debugging,
- `-Oz` Optimize aggressively for size rather than speed. This may increase the number
of instructions executed if those instructions require fewer bytes to encode. -Oz
behaves similarly to -Os including enabling most -O2 optimizations.

Por defecto el compilador usa -O0, desabilitando la mayoria de pasadas de optimizacion, para reducir el tiempo de compilacion y producir los resultados esperados a la hora de hacer debugging.
Comparare la ejecucion del codigo compilado con ajustes por defecto, y compilado con el flag -O2:
| n |local  | cluster | local (-O2) | cluster (-O2) |
| -- | -- | -- | -- | -- |
| 250 | 0,14s|0.55s | 0,010s | 0,025s |
| 500 | 1,2s|5.7s | 0,081s | 0,75s |
| 1000 | 9,2s|48.5s | 0,067s |  4.58s|

## 4
El tipo de dato influye directamente en el rendimiento porque determina cuánta memoria se usa, cómo se accede a la caché y qué tan rápido puede procesar los datos el hardware. Tipos más pequeños (como float32 frente a float64) permiten almacenar más valores en memoria y en caché, reduciendo accesos lentos a RAM y mejorando la localidad. Además, afectan la velocidad de las operaciones y el nivel de paralelismo que puede aprovechar la CPU o GPU (por ejemplo, mediante SIMD), ya que se pueden procesar más elementos en paralelo. Sin embargo, existe un compromiso entre rendimiento y precisión, ya que tipos más pequeños suelen ser más rápidos pero menos precisos, lo que obliga a elegir según las necesidades del problema.

## 5
### a)
El resultado computado usando `double` es mas cercano al resultado real.
```
Soluciones Float: 2.00000	2.00000
Soluciones Double: 2.00032	1.99968
```

### b)
| TIMES | double | float |
| -- | -- | --|
| 100 | 20.00s | 24.04s |
| 200 | 42.36s | 47.79s |
| 500 | 105.86s | 120.71s |

Podemos notar que la ejecucion de la solucion que usa `double` toma menos tiempo. Esto podria deberse a que ahorran conversiones `float->double` al usar las funciones `pow()` y `sqrt()`.

### c)
| TIMES | double | float |
| -- | -- | --|
| 100 | 20.97s | 13.79s |
| 200 | 42.22 | 27.80s |
| 500 | 105.81s | 69.31s |

Ahora podemos notar que la alternativa que usa `float` tarda menos tiempo. Esto se debe a que se evitan conversiones:
- De `double` a `float`: a la hora de inicializar los vectores.
- De `float` a `double`: ya que ahora se usa  `powf()` y `sqrtf()`.

## 6
Tiempos iniciales con optimizacion -O2:

| n | t  |
| -- | -- |
| 128 | 0.0025s |
| 256 | 0.023s |
| 512 | 0.31s |
| 1024 | 3.35s |

##### Matriz B ordenada por columnas:

Por como se realiza la multiplicacion de matrices es conveniente que la matriz b este ordenada por columnas en vez de filas. Realizar esta modificacion aroja los siguientes tiempos:

| n | t  |
| -- | -- |
| 128 | 0.0012s |
| 256 | 0.0109s |
| 512 | 0.0832s |
| 1024 | 0.681s |

##### Remplazo de macros por funciones:
El llamado a una funcion requiere un gasto de tiempo adicional para apilar los argumentos de la funcion, saltar a otra direccion y luego volver, al remplazar los llamados a funciones por macros, el performance deberia mejorar:

| n | t  |
| -- | -- |
| 128 | 0.0012s |
| 256 | 0.01s |
| 512 | 0.0834s |
| 1024 | 0.681s |

En este caso el performance no mejora, esto se debe a que en realidad el compilador ya estaba transformando los llamados a funciones en codigo inline. Si en cambio volvemos a hacer la comparacion, desactivando las optimizaciones del compilador, la mejora se vuelve obvia:

| n | funciones (-O0)  | macros (-O0) |
| -- | -- | -- |
| 512 | 1.2s | 0.38s |
| 1024 | 9.6s | 3.12s |

##### Operaciones repetidas
En vez de usar dos for loops para inicializar las matrices, se puede usar uno solo:

| n | t  |
| -- | -- |
| 128 | 0.0012s |
| 256 | 0.01s |
| 512 | 0.0834s |
| 1024 | 0.681s |

La diferencia es inperceptible.

##### Uso de acumuladores
En vez de acumular directamente sobre la posicion c[i,j] de la matriz resultado se usa una variable local como acumulador, reduciendo notablemente la cantidad de llamadas a `setValor()` y `getValor()`:


| n | t  |
| -- | -- |
| 128 | 0.0011s |
| 256 | 0.01s |
| 512 | 0.0833s |
| 1024 | 0.678s |

## 7
El algoritmo divide las matrices en bloques de tamaño 
BS×BS
BS×BS y realiza la multiplicación bloque a bloque. Para cada bloque de la matriz resultado, acumula productos de bloques correspondientes de las matrices de entrada. Esta técnica mejora la localidad espacial y temporal de los datos, optimizando el uso de caché y aumentando el rendimiento respecto al método tradicional.

| 1024-16 | 1024-32 |1024-64 | 2048-16 |2048-32 | 2048-64 |
|--|--|--|--|--|--|
|0.37s|0.4s|0.47s|3.0s|3.3s|3.8s|

El tamaño de bloque optimo esta relacionado al tamaño de cache del procesador. El valor optimo es aquel que permite que se carguen en la cache los tres bloques (uno de cada matriz) al mismo tiempo.

## 8
La diferencia con este algoritmo es que almacena el tamaño de bloque en una constante en vez de una variable, a penas disminuyendo el TE y empeorando la usabilidad del codigo.

| 1024-16 | 1024-32 |1024-64 | 2048-16 |2048-32 | 2048-64 |
|--|--|--|--|--|--|
|0.37s|0.4s|0.47s|2.99s|3.2s|3.7s|

## 9
Al correr el codigo de matrices.c con todas las modificaciones realizadas, y compilado usando el flag `-O2` en el cluster obtengo los siguientes resultados:

| n | t  |
| -- | -- |
| 128 | 0.003s |
| 256 | 0.03s |
| 512 | 0.23s |
| 1024 | 2.6s |
