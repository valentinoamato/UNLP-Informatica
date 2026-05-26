# Practica 1
## A - Introducion
#### 1)
GCC (GNU Compiler Collection) es una coleccion de compiladores de el proyecto GNU que soporta varios lenguajes de programacion, arquitecturas de hardware y sistemas operativos.

En el lanzamiento de la version 1.0 era llamado GNU C Compiler ya que solo soportaba al lenguaje C. Luego se extendio para compilar C++, Fortran, Ada y otros.

#### 2)
Make es una herramienta de gestion de dependencias, tipicamente, las que existen entre los archivos que componen el codigo fuente de un programa, para dirigir su recompilacion o generacion automaticamente.
Make determina automaticamente que partes de un programa requieren ser recompiladas y ejecuta los comandos necesarios para hacerlo.

#### 3)
##### A
Los archivos no se vuelven a compilar ya que no es necesario (porque no fueron modificados).

##### B
Solo el archivo modificado se vuelve a compilar, ya que no es necesario recompilar los que no se modificaron.

##### C
En el Makefile, run se declara como phony porque no representa a un archivo real, sino a una accion.

Un target normal en make representa un archivo, y se decide si ejecutarlo o no comparando timestamps.

Si existiera un archivo llamado run en directorio, al usar make run, el comando no se ejecutaria si el archivo run no fue modificado.

Al usar .PHONY, le decimos a make que para run ignore el sistema de timestamps y ejecute siempre la receta.

##### D
El programa se compila correctamente porque `make` tiene un conjunto de reglas implicitas incorporadas.

La regla:
```
dlinkedlist.o: dlinkedlist.h
```
solo indica que el primero depende del segundo, pero no especifica como construir el primero.

Sin embargo, `make` detecta automaticamente que existe un archivo fuente `dlinkedlist.c` y quiere generar `dlinkedlist.o`, entonces aplica una regla implicita equivalente a:
```bash
gcc -c dlinkedlist.c -o dlinkedlist.o -Wall --std=c11
```

La dependencia con `dlinkedlist.h` sirve para que, si el header cambia, make vuelva a recompilar `dlinkedlist.o`.

#### 4)

El kernel es el núcleo del sistema operativo GNU/Linux. Es el componente que actúa como intermediario entre el hardware y los programas de usuario.

Sus funciones principales son:

1. Administración de procesos: creación, planificación y finalización de procesos
2. Administración de memoria: memoria virtual, paginación, protección
3. Manejo de dispositivos: mediante drivers/controladores
4. Administración del sistema de archivos: Manejo de interrupciones
5. Comunicación entre procesos (IPC): Seguridad y control de permisos
6. Gestión de recursos del sistema: CPU, RAM, I/O, red, etc.

#### 5)

Linux utiliza un kernel monolítico modular.

Esto significa que:

los servicios principales del SO se ejecutan en espacio kernel
pero muchas funcionalidades pueden cargarse dinámicamente como módulos

Los módulos permiten agregar funcionalidades sin recompilar todo el kernel.

Ejemplos:
- drivers
- sistemas de archivos
- soporte de red

Ventajas:
- flexibilidad
- menor uso de memoria
- carga dinámica
- Portabilidad

Linux es altamente portable:
- x86
- x86_64
- ARM
- RISC-V
- PowerPC
- etc.

Esto se logra mediante capas de abstracción y código específico por arquitectura.

#### 6)

Actualmente el formato es:

MAJOR.MINOR.PATCH

Ejemplo:

6.8.12

donde:

MAJOR → cambios importantes
MINOR → nuevas funcionalidades
PATCH → correcciones y bugs

#### 7)

Un usuario puede recompilar el kernel para:
- agregar soporte de hardware
- eliminar componentes innecesarios
- mejorar rendimiento
- reducir tamaño del kernel
- habilitar funcionalidades experimentales
- aplicar parches
- mejorar seguridad
- usar versiones más nuevas
- fines educativos

#### 8)
a) make config

Configuración línea por línea en terminal.

Pros:
- simple
- no requiere librerías gráficas
Contras:
- extremadamente incómodo
- lento

b) make menuconfig

Interfaz ncurses en terminal.

Pros
- amigable
- muy utilizada
- funciona en terminal
Contras
- menos cómoda que GUI

c) make nconfig

Versión mejorada de menuconfig.

Pros
- mejor navegación
- búsqueda más cómoda
Contras
- menos universal

d) make xconfig

Interfaz gráfica Qt.

Pros
- interfaz moderna
Contras
- depende de GUI

e) make gconfig

Interfaz GTK.

Pros
- gráfica
Contras
- poco usada actualmente

#### 9)
##### a. make menuconfig

Abre el menú interactivo de configuración del kernel.

##### b. make clean

Elimina archivos temporales y objetos compilados.

No elimina configuraciones importantes como .config.

##### c. make

Compila el kernel.

Parámetro -j: Permite compilación paralela.

Ejemplo:

make -j8

usa 8 tareas simultáneas.

Frecuentemente se usa:

make -j$(nproc)

para usar todos los núcleos disponibles.

##### d. make modules

Compila módulos externos/dinámicos.

En kernels modernos:

ya se ejecuta automáticamente con make
##### e. make modules_install

Instala módulos en:

/lib/modules/<version>
f. make install

Instala:
- kernel
- System.map
- configuración

y normalmente actualiza /boot.

#### 10)

La imagen suele quedar en:

arch/x86/boot/bzImage

Debe copiarse normalmente a:

/boot


El comando:

`make install`

puede realizar la copia automáticamente.

#### 11)

El initramfs es un sistema de archivos temporal cargado en RAM durante el arranque.

Contiene:

- drivers esenciales
- scripts de inicio
- herramientas para montar el sistema raíz

Su función es permitir que el kernel pueda acceder al filesystem raíz real.

¿Cuándo puede no ser necesario?

Puede no ser necesario si:

todos los drivers necesarios están compilados dentro del kernel
el root filesystem es accesible directamente

#### 12)

Porque el gestor de arranque debe conocer:

- la nueva imagen del kernel
- el nuevo initramfs
- parámetros de arranque

Si no se actualiza:

el sistema seguirá arrancando el kernel viejo
o puede fallar el arranque

#### 13)

Un módulo es código que puede cargarse o descargarse dinámicamente del kernel.

Ejemplos:
- drivers
- sistemas de archivos
- protocolos de red


#### Comandos principales
- lsmod: Lista módulos cargados.
- insmod: Carga un módulo.
- rmmod: Elimina un módulo.
- modprobe: Carga módulos resolviendo dependencias automáticamente.
- modinfo: Muestra información de un módulo.

#### 14)

Un parche es una modificación del código fuente del kernel.

Razones para aplicar parches:
- corregir bugs
- solucionar vulnerabilidades
- agregar funcionalidades
- mejorar rendimiento
- soporte de hardware nuevo

Para la aplicación de parches se usa `patch`:
```bash
patch -p1 < parche.patch
```
#### 15)
##### a. Característica principal de ARM big.LITTLE
Posee dos tipos de núcleos:
1. núcleos grandes (big):
- más rápidos
- mayor consumo
2. núcleos pequeños (LITTLE)
- menos potencia
- menor consumo energético

##### b. ¿Dónde asigna procesos el scheduler?

El scheduler intenta:
- usar núcleos LITTLE para tareas livianas
- usar núcleos big para tareas exigentes

Busca balancear:
- rendimiento
- consumo energético

##### c. ¿Qué dispositivos se benefician más?
- smartphones
- tablets
- notebooks ARM
- dispositivos embebidos

Porque priorizan autonomía de batería.

#### 16)
##### a. Propósito

Permite crear regiones de memoria “secretas” protegidas del acceso de otros componentes del sistema.

##### b. ¿Para qué puede utilizarse?
Para almacenar:
- claves criptográficas
- credenciales
- datos sensibles
- tokens
##### c. ¿El kernel puede acceder a esa memoria?

El kernel administra la memoria, pero estas regiones están diseñadas para:
- evitar accesos accidentales
- impedir acceso desde otros procesos
- minimizar exposición incluso frente a mecanismos del kernel
