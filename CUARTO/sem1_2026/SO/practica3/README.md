## Practica 1
### Conceptos Generales
#### 1. ¿Cuál es la diferencia fundamental entre un proceso y un thread?

Un proceso es una instancia de un programa con su propio espacio de direcciones y recursos.

Un thread (hilo) es una unidad de ejecución dentro de un proceso.

Cada proceso tiene su propia memoria.Los threads de un mismo proceso comparten la memoria y recursos del proceso.

#### 2. ¿Qué son los ULT y cómo se diferencian de los KLT?
User-Level Threads (ULT): Son administrados completamente por una biblioteca en espacio de usuario.

El kernel no conoce su existencia.

Ejemplo:

Kernel-Level Threads (KLT): Son administrados por el kernel. Cada hilo es conocido por el scheduler del sistema operativo.

#### 3. ¿Quién planifica los ULT y los KLT? ¿Cómo afecta esto al rendimiento?
ULT: Son planificados por la biblioteca de threads. El kernel ve un único hilo de ejecución. No pueden ejecutarse simultáneamente en varios núcleos.

KLT: Son planificados por el scheduler del kernel. El kernel ve cada hilo individualmente. Pueden ejecutarse en paralelo en distintos núcleos.

#### 4. ¿Cómo maneja el sistema operativo los KLT y en qué se diferencian de los procesos?

Linux maneja los KLT de forma muy similar a los procesos.

Internamente ambos utilizan `task_struct`.

La diferencia es que los hilos comparten recursos:
- memoria
- archivos abiertos
- señales
- directorio actual


#### 5. ¿Qué ventajas tienen los KLT sobre los ULT? ¿Cuáles son sus desventajas?
Ventajas
- Paralelismo real.
- Aprovechan múltiples núcleos.
- Una syscall bloqueante no detiene a los demás hilos.
Desventajas
- Mayor overhead.
- Creación más costosa.
- Cambios de contexto más costosos.
#### 6. ¿Qué retornan las siguientes funciones?
1. getpid(): Retorna el PID del proceso.

2. getppid(): Retorna el PID del proceso padre.

3. gettid(): Retorna el Thread ID (TID) del hilo actual.

4. pthread_self(): Retorna el identificador POSIX del hilo actual:

5. pth_self(): Retorna el identificador del ULT actual en GNU Pth.

#### 7. ¿Qué mecanismos de sincronización se pueden usar?
- Mutex
- Semáforos
- Variables de condición
- Read/Write Locks
- Barreras
- Spinlocks
- Operaciones atómicas

Es necesario usar sincronización con ULT.

Aunque no haya paralelismo real, varios ULT pueden acceder a datos compartidos y generar inconsistencias.

#### 8. Procesos
##### a. ¿Qué utilidad tiene ejecutar fork() sin exec()?

Permite crear un proceso hijo que continúa ejecutando el mismo código.

Se utiliza para:
- procesamiento paralelo
- servidores
- workers

##### b. ¿Qué utilidad tiene fork() + exec()?

Es el mecanismo típico para ejecutar otro programa.

Ejemplo:
```
bash → fork() → exec(ls)
```
##### c. ¿Cuál asigna un nuevo PID?
fork() asigna un nuevo PID.

exec() mantiene el mismo PID.

##### d. ¿Qué implica Copy-On-Write?

Después de fork(), padre e hijo comparten páginas de memoria.
Las páginas se duplican únicamente cuando alguno escribe. Reduce uso de memoria y mejora rendimiento.

##### e. ¿Qué consecuencias tiene no hacer wait()?

El hijo terminado queda en estado Zombie, ocupando una entrada en la tabla de procesos.

##### f. ¿Quién hace wait() si el padre termina?

El proceso con PID 1, generalmente `systemd`.

#### 9. Kernel Level Threads
##### a. ¿Qué elementos comparten los threads creados con pthread_create()?
- Heap
- Variables globales
- Segmento de datos
- Archivos abiertos
- Código ejecutable

Cada hilo posee:
- Stack propio
- Registros propios
- TID propio

##### b. ¿Qué relación hay entre getpid() y gettid()?

Todos los hilos del proceso tienen getpid() igual, pero gettid() distinto.

##### c. ¿Por qué pthread_join() es importante?
Permite:
- esperar la finalización del hilo
- recuperar su valor de retorno
- liberar recursos

Sin pthread_join(), un hilo terminado puede quedar como zombie.


##### d. ¿Qué pasa si un hilo bloquea en read()?

Solo se bloquea ese hilo. Los demás pueden continuar ejecutándose.

##### e. ¿Qué ocurre cuando se invoca pthread_create()?

Internamente la biblioteca POSIX termina invocando la syscall `clone()` (o variantes modernas basadas en clone).

El kernel crea un nuevo hilo que comparte recursos con el proceso original.

#### 10. User Level Threads
##### a. ¿Por qué no pueden ejecutarse en paralelo en múltiples núcleos?

Porque el kernel ve un único hilo/proceso. Solo puede planificar una entidad ejecutable.

##### b. ¿Qué ventajas tienen respecto de los KLT?
- Menor overhead.
- Creación rápida.
- Cambio de contexto rápido.
- Scheduler personalizable.
##### c. ¿Qué relación hay entre getpid(), gettid() y pth_self()?

En GNU Pth, `getpid()` retorna el mismo PID para todos. `gettid()` normalmente revuelve el mismo TID para todos los ULT porque el kernel ve un único hilo.

`pth_self()` identifica al ULT actual.

##### d. ¿Qué pasa si un ULT realiza una syscall bloqueante?

Se bloquea todo el proceso. Todos los ULT quedan detenidos.

##### e. ¿Qué tipos de scheduling pueden tener?
Cooperativo o preventivo. El más común históricamente en ULT es el primero, donde el hilo cede voluntariamente la CPU.

#### 11. Global Interpreter Lock
##### a. ¿Qué es el GIL?

El Global Interpreter Lock es un mecanismo que permite que solo un hilo ejecute bytecode del intérprete a la vez.

Aunque existan varios threads, no ejecutan código CPU-bound en paralelo.
##### b. ¿Por qué se recomienda usar procesos para tareas intensivas en CPU?

Porque cada proceso tiene su propio intérprete y su propio GIL por lo tanto pueden ejecutarse realmente en paralelo en distintos núcleos.

Los threads siguen siendo útiles para tareas de:
- I/O
- red
- archivos
- bases de datos

pero no para maximizar rendimiento en cálculos intensivos de CPU bajo CPython o MRI Ruby.
