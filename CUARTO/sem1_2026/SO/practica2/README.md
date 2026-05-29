## Practica 2
### System Calls
#### 1. ¿Qué es una System Call? ¿Para qué se utiliza?

Una System Call (syscall) es el mecanismo mediante el cual un programa en espacio de usuario solicita servicios al kernel del sistema operativo.

Las syscalls permiten que los programas interactúen con recursos protegidos del sistema.


Se usan para acceder a funcionalidades del kernel, por ejemplo:
- manejo de archivos
- creación de procesos
- comunicación entre procesos
- acceso a dispositivos
- manejo de memoria
- operaciones de red

Ejemplos de syscalls: open(), read(), write(), fork(), etc.

#### 2. ¿Para qué sirve la macro syscall?

La macro/función syscall() permite invocar directamente una syscall del kernel desde un programa en C.

Está definida en:
```c
#include <unistd.h>
#include <sys/syscall.h>
```

Sintaxis general:
```c
long syscall(long number, ...);
```
Parámetros:
1. `number`: Es el número identificador de la syscall.
2. `...`: Son los argumentos que recibe la syscall. Dependen de cada syscall específica.

Permite: acceder directamente a syscalls, usar syscalls nuevas no soportadas aún por libc y experimentar o desarrollar funcionalidades de bajo nivel.

#### 3. Ejecute el siguiente comando e identifique el propósito de cada uno de los archivos que encuentra
```bash
ls -lh /boot | grep vmlinuz
```
```
-rw-r--r-- 1 root root 7.9M Jan  2  2025 vmlinuz-6.1.0-29-amd64
-rw-r--r-- 1 root root 7.9M Feb  7  2025 vmlinuz-6.1.0-31-amd64
-rw-r--r-- 1 root root 7.9M Mar  9 03:45 vmlinuz-6.1.0-44-amd64
-rw-r--r-- 1 root root 8.3M May 26 11:01 vmlinuz-6.13.7
```

`vmlinuz` es la imagen comprimida del kernel Linux utilizada durante el arranque.
El bootloader carga este archivo en memoria para iniciar el sistema.

Cada archivo corresponde a una versión distinta del kernel instalada en el sistema.

#### 5. ¿Para qué sirve el archivo arch/x86/entry/syscalls/syscall_64.tbl?

Ese archivo define la tabla de syscalls para arquitectura x86_64. Asocia: número de syscall, nombre y función interna del kernel.

Ejemplo simplificado:
```
0   common   read     sys_read
1   common   write    sys_write
```

El kernel utiliza esta tabla para mapear el número de syscall recibido y ejecutar la función correspondiente
#### 6. ¿Para qué sirve strace? ¿Cómo se usa?

`strace` es una herramienta que permite observar las syscalls realizadas por un proceso.

Se utiliza para debugging, análisis de programas, detectar errores, etc.


Mostrar todas las syscalls ejecutadas por ls.
```bash
strace ls
```

Seguir un proceso existente
```
strace -p PID
```

#### 7. ¿Para qué sirve ausyscall? ¿Cómo se usa?

`ausyscall` es una herramienta que traduce números de syscalls a nombres y viceversa.

Permite:
- identificar syscalls
- consultar números de syscalls
- analizar logs de auditoría

Mostrar todas las syscalls
```
ausyscall --dump
```

Obtener nombre desde número
```
ausyscall 1
```

Obtener número desde nombre
```
ausyscall write
```

### Modulos y Drivers
#### 1. ¿Cómo se denomina en GNU/Linux a la porción de código que se agrega al kernel en tiempo de ejecución?

Se denomina módulo del kernel (Kernel Module o Loadable Kernel Module - LKM). Un módulo permite extender funcionalidades del kernel dinámicamente.

No es necesario reiniciar el sistema para cargarlos. Los módulos pueden cargarse y descargarse dinamicamente mediante herramientas como:
- insmod
- modprobe
- rmmod
¿Qué pasaría si no existieran módulos?

Si el kernel no soportara módulos todas las funcionalidades deberían compilarse directamente dentro del kernel
sería necesario recompilar e reiniciar el sistema para agregar soporte nuevo.

#### 2. ¿Qué es un driver? ¿Para qué se utiliza?

Un driver (controlador) es software que permite al kernel comunicarse con un dispositivo de hardware o dispositivo virtual.

Permite:
- controlar hardware
- enviar comandos
- leer/escribir datos
- abstraer detalles específicos del dispositivo
Ejemplos

#### 3. ¿Por qué es necesario escribir drivers?

Porque cada dispositivo posee:
- protocolos distintos
- registros distintos
- formas distintas de comunicación

El kernel necesita software específico para interactuar correctamente con cada hardware.

También permiten
- soporte para hardware nuevo
- optimizaciones
- compatibilidad
- funcionalidades específicas
#### 4. ¿Cuál es la relación entre módulo y driver en GNU/Linux?

Un driver puede implementarse como módulo cargable o integrado directamente al kernel. Muchos drivers en Linux son módulos del kernel.


#### 5. ¿Qué implicancias puede tener un bug en un driver o módulo?

Un bug en espacio kernel es muy peligroso porque el kernel tiene privilegios totales.

Puede provocar:
- kernel panic
- cuelgues
- corrupción de memoria
- pérdida de datos
- fallos de seguridad
- reinicios
- vulnerabilidades escalables


Si falla una aplicación de usuario normalmente solo se cierra el proceso, mientras que si falla un módulo/kernel puede caer todo el sistema.
#### 6. ¿Qué tipos de drivers existen en GNU/Linux?

Principales tipos:

1. Character drivers: Trabajan con flujo secuencial de bytes.

Ejemplos:
- teclado
- mouse
- puerto serie
2. Block drivers: Acceso por bloques aleatorios.

Ejemplos:
- discos
- SSD
- particiones
3. Network drivers: Manejan interfaces de red.
- Ethernet
- WiFi

4. Drivers virtuales: No controlan hardware físico.

Ejemplos:
- /dev/null
- loop devices

#### 7. ¿Qué hay en el directorio /dev?

El directorio:
```
/dev
```
contiene archivos especiales que representan dispositivos del sistema.

#### 8. ¿Para qué sirve /lib/modules/<version>/modules.dep?

Ese archivo contiene dependencias entre módulos del kernel.

Es utilizado por `modprobe`.

#### 9. ¿En qué momento se genera o actualiza un initramfs?

El initramfs suele generarse o actualizarse:
- al instalar un nuevo kernel
- al instalar drivers importantes
- al modificar hooks/configuración
- al actualizar módulos críticos


En Arch Linux:
```
mkinitcpio
```
#### 10. ¿Qué módulos y drivers debe tener mínimamente un initramfs?

Debe contener lo necesario para montar el filesystem raíz.

Mínimamente
1. Driver del controlador de almacenamiento (ej. SATA, NVMe, SCSI)
2. Driver del filesystem raíz (ej. ext4, xfs, btrfs)
3. Soporte para particiones/LVM/RAID si el sistema lo utiliza.
4. Drivers de cifrado si el root filesystem está cifrado.

Objetivo.

Permitir que el kernel:

- detecte el disco
- acceda al filesystem raíz
- monte /
- continúe el arranque normal del sistema.
