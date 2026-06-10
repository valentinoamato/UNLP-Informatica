## Practica 4 A
### Conceptos teoricos
#### 1. Defina virtualización.

La virtualización es una técnica que permite ejecutar múltiples sistemas operativos aislados sobre una misma máquina física, compartiendo sus recursos.

#### 2. ¿Qué diferencia existe entre virtualización y emulación?
En la virtualización el sistema invitado utiliza la misma arquitectura de CPU que el host.
- El código se ejecuta directamente sobre el procesador.
- Alto rendimiento.

En la emulación se simula completamente otra arquitectura.
- Cada instrucción debe traducirse.
- Mucho más lenta.

#### 3. Hypervisor
##### a) ¿Qué es un hypervisor?

Es una capa de software que permite crear y administrar máquinas virtuales.

Controla:
- CPU
- memoria
- dispositivos
- acceso al hardware
##### b) Beneficios y clasificación
Beneficios:
- Consolidación de servidores.
- Aislamiento.
- Portabilidad.
- Mejor aprovechamiento del hardware.
- Facilidad para backups y snapshots.

Tipos:
- Tipo 1 (Bare Metal): Corre directamente sobre el hardware. Ej. VMware ESXi, Xen, etc.

- Tipo 2 (Hosted): Corre sobre un sistema operativo anfitrión. Ej. VirtualBox.

#### 4. ¿Qué es Full Virtualization? ¿Y virtualización asistida por hardware?
Full Virtualization permite ejecutar un sistema operativo sin modificarlo.
El SO invitado cree que corre sobre hardware real.

La virtualización asistida por hardware utiliza extensiones del procesador para acelerar la virtualización y reducir el overhead.

#### 5. ¿Qué implica Binary Translation? ¿Y Trap-and-Emulate?
En Binary Translation el hypervisor analiza y reemplaza instrucciones privilegiadas por otras seguras.


En Trap-and-Emulate, cuando el SO invitado ejecuta una instrucción privilegiada:
- Se genera una excepción (trap).
- El hypervisor la intercepta.
- Emula el resultado esperado.

#### 6. Paravirtualización
##### a) ¿Qué es?

Es una técnica donde el sistema operativo invitado es modificado para cooperar con el hypervisor.
Utiliza hypercalls en lugar de instrucciones privilegiadas.

##### c) Beneficios y desventajas
Beneficios:
- Menor overhead.
- Mejor rendimiento.
- Menor cantidad de traps.

Desventaja:
- Requiere modificar el sistema operativo invitado.
#### 7. Containers
##### a) ¿Qué son?

Son entornos aislados que comparten el mismo kernel del host.

##### b) ¿Dependen del hardware?

No directamente.

Todos comparten el kernel y la arquitectura del host.

##### c) Diferencia respecto de otras tecnologías

No virtualizan hardware. Comparten el kernel.

Por ello:
- consumen menos memoria
- arrancan más rápido
- tienen menos overhead
##### d) Funcionalidades necesarias
Principalmente:

- Namespaces
- Cgroups
- Capabilities
- Overlay Filesystems
- chroot/pivot_root
