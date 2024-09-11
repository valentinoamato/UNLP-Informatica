## Práctica 1
**Objetivo**

El objetivo de esta práctica es que el alumno se familiarice con los conceptos básicos del sistema
operativo GNU/Linux, así como con su entorno y comandos principales.

#### 1. Características de GNU/Linux:

A) Mencione y explique las características más relevantes de GNU/Linux.

B) Mencione otros sistemas operativos y compárelos con GNU/Linux en cuanto a los puntos mencionados en el inciso a.

C) ¿Qué es GNU?

D) Indique una breve historia sobre la evolución del proyecto GNU

E) Explique qué es la multitarea, e indique si GNU/Linux hace uso de ella.

F) ¿Qué es POSIX?

#### 2. Distribuciones de GNU/Linux:

A) ¿Qué es una distribución de GNU/Linux? Nombre al menos 4 distribuciones de GNU/-
Linux y cite diferencias básicas entre ellas.

B) ¿En qué se diferencia una distribución de otra?

C) ¿Qué es Debian? Acceda al sitio 1 e indique cuáles son los objetivos del proyecto y
una breve cronología del mismo

#### 3. Estructura de GNU/Linux:

A) Nombre cuales son los 3 componentes fundamentales de GNU/Linux.

B) Mencione y explique la estructura básica del Sistema Operativo GNU/Linux.

#### 4. Kernel:

A) ¿Qué es? Indique una breve reseña histórica acerca de la evolución del Kernel de
GNU/Linux.

B) ¿Cuáles son sus funciones principales?

C) ¿Cuál es la versión actual? ¿Cómo se definía el esquema de versionado del Kernel en
versiones anteriores a la 2.4? ¿Qué cambió en el versionado se impuso a partir de la
versión 2.6?

D) ¿Es posible tener más de un Kernel de GNU/Linux instalado en la misma máquina?

E) ¿Dónde se encuentra ubicado dentro del File System?

F) ¿El Kernel de GNU/Linux es monolítico? Justifique.

#### 5. Intérprete de comandos (Shell):

A) ¿Qué es?

B) ¿Cuáles son sus funciones?

C) Mencione al menos 3 intérpretes de comandos que posee GNU/Linux y compárelos
entre ellos.

D) ¿Dónde se ubican (path) los comandos propios y externos al Shell?

E) ¿Por qué considera que el Shell no es parte del Kernel de GNU/Linux?

F) ¿Es posible definir un intérprete de comandos distinto para cada usuario? ¿Desde dónde
se define? ¿Cualquier usuario puede realizar dicha tarea?

#### 6. Sistema de Archivos (File System):
A) ¿Qué es?

B) Mencione sistemas de archivos soportados por GNU/Linux.

C) ¿Es posible visualizar particiones del tipo FAT y NTFS en GNU/Linux?

D) ¿Cuál es la estructura básica de los File System en GNU/Linux? Mencione los directo-
rios más importantes e indique qué tipo de información se encuentra en ellos. ¿A qué
hace referencia la sigla FHS?

#### 7. Particiones:
A) Definición. Tipos de particiones. Ventajas y Desventajas.

B) ¿Cómo se identifican las particiones en GNU/Linux? (Considere discos IDE, SCSI y SATA).

C) ¿Cuántas particiones son necesarias como mínimo para instalar GNU/Linux? Nómbre-
las indicando tipo de partición, identificación, tipo de File System y punto de montaje.

D) Ejemplifique diversos casos de particionamiento dependiendo del tipo de tarea que se
deba realizar en su sistema operativo.

E) ¿Qué tipo de software para particionar existe? Menciónelos y compare.

#### 8. Arranque (bootstrap) de un Sistema Operativo:
A) ¿Qué es el BIOS? ¿Qué tarea realiza?

B) ¿Qué es UEFI? ¿Cuál es su función?

C) ¿Qué es el MBR? ¿Que es el MBC?

D) ¿A qué hacen referencia las siglas GPT? ¿Qué sustituye? Indique cuál es su formato.

E) ¿Cuál es la funcionalidad de un “Gestor de Arranque”? ¿Qué tipos existen? ¿Dónde se
instalan? Cite gestores de arranque conocidos.

F) ¿Cuáles son los pasos que se suceden desde que se prende una computadora hasta que
el Sistema Operativo es cargado (proceso de bootstrap)?

G) Analice el proceso de arranque en GNU/Linux y describa sus principales pasos.

H) ¿Cuáles son los pasos que se suceden en el proceso de parada (shutdown) de GNU/Li-
nux?

I) ¿Es posible tener en una PC GNU/Linux y otro Sistema Operativo instalado? Justifi-
que.

#### 9. Archivos:
A) ¿Cómo se identifican los archivos en GNU/Linux?

B) Investigue el funcionamiento de los editores vi y mcedit, y los comandos cat y more.

C) Cree un archivo llamado “prueba.exe” en su directorio personal usando el vi. El mismo
debe contener su número de alumno y su nombre.

D) Investigue el funcionamiento del comando file. Pruébelo con diferentes archivos. ¿Qué
diferencia nota?

#### 10. Indique qué comando es necesario utilizar para realizar cada una de las siguientes acciones.
#### Investigue su funcionamiento y parámetros más importantes:
A) Cree la carpeta ISO2017

B) Acceda a la carpeta (cd)

C) Cree dos archivos con los nombres iso2017-1 e iso2017-2 (touch)

D) Liste el contenido del directorio actual (ls)

E) Visualizar la ruta donde estoy situado (pwd)

F) Busque todos los archivos en los que su nombre contiene la cadena “iso*” (find)

G) Informar la cantidad de espacio libre en disco (df)

H) Verifique los usuarios conectado al sistema (who)

I) Acceder a el archivo iso2017-1 e ingresar Nombre y Apellido

J) Mostrar en pantalla las últimas líneas de un archivo (tail).

#### 11. Investigue su funcionamiento y parámetros más importantes:

A) shutdown

B) reboot

C) halt

D) locate

E) uname

F) dmesg

G) lspci

H) at

I) netstat

J) mount

K) umount

L) head

M) losetup

N) write

Ñ) mkfs

O) fdisk (con cuidado)

#### 12. Investigue su funcionamiento y parámetros más importantes:
A) Indique en qué directorios se almacenan los comandos mencionados en el ejercicio
anterior.

## Resolucion:

#### 1)
A) GNU/Linux es una familia de sistemas operativos de codigo abierto tipo Unix. Utilizan el kernel de Linux, ademas de librerias y aplicaciones provistas por el proyecto GNU.

B)

Microsoft Windows: Es una familia de sistemas operativos graficos, de codigo cerrado, desarrollados y vendidos por Microsoft.

MacOS: Sistema opetarivo propietario Unix-like desarrollado y vendido por Apple.

C) GNU es una coleccion de software libre que puede usarse como sistema operativo o como parte de uno.

D) El proyecto GNU es un proyecto de software libre y colaboracion masiva, anunciado por Richard Stallman el 27/9/1983 con el objetivo de darle a los usuarios de computadoras libertad y control sobre sus computadoras y dispositivos de computo, mediante el desarrollo colaborativo de software que permita a todos ejecutarlo, copiarlo, distribuirlo, estudiarlo y modificarlo.
Para asegurar que todo el software de una computadora le de los anteriores permisos al usuario Stallman decide desarrollar un sistema operativo (GNU) que luego usaria el kernel desarrollado por Linus Torvalds.

E) La multitarea es una caracteristica de algunos SOs que permite que varios precesos o aplicaciones se ejecuten aparentemente al mismo tiempo, compartiendo uno o mas procesadores. 

GNU/Linux cuenta con esta caracteristica.

F) POSIX (**P**ortable **O**perating **S**istem **I**nterface Uni**X**) es una norma escrita por la IEEE, que define una interfaz estandar del sistema operativo y el entorno, incluyendo un interprete de comandos.

#### 2)
A) Una distribucion de GNU/Linux es un sistema operativo compuesto por una coleccion de software que incluye el kernel de linux, herramientas y librerias GNU, un administrador de paquetes, y muchas otros tipos de software.

Algunos ejemplos de distibuciones son:
- Arch Linux: Usa un modelo de actualizaciones rolling-release. Apunta a ser simple.
- Debian: Se enfoca en la seguridad, estabilidad y soporte.
- Gentoo: Se centra en proveer configurabilidad extrema. El codigo fuente de las applicaciones se compila localmente acorde a las preferencias del usuario.
- Slackware: Busca ser la distibucion mas UNIX-like.

B) Normalmente las distibuciones se diferencian por los paquetes, librerias, paquetes y aplicaciones que usan, por ejemplo:
- Administradores de paquetes.
- Sistemas de inicio.
- Display server.
- Entorno de escritorio.
- Administrador de ventanas.

C) Debian es un sistema operativo libre que usa componentes de GNU y puede usar distintos kernels.
Fue anunciado por Ian Murdock el 16 de agosto de 1993 y la version 0.0.1 se lanzo el 15 de septiembre del mismo año. El objetivo principal de la creacion de Debian fue finalmente crear una distribucion que este a la altura del nombre de Linux.

#### 3)
A)
1. Kernel.
2. Shell.
3. FileSystem.

B)
Los estructura de los sistemas operativos GNU/Linux se componen de tres componentes principales:
1. Kernel: Se encarga de administrar el uso de recursos y dispositivos de E/S.
2. Shell: Programa que expone los servicios del SO al usuario o a otros programas.
3. FileSystem: Gobierna la organizacion, administracion y acceso de los archivos en el SO.

#### 4)
A) El kernel es un programa de un sistema operativo que se encuentra siempre en memoria principal y se encarga de administrar recursos (Memoria, CPU, E/S).

Evolucion del kernel de GNU/Linux: 
 - Linus Torvalds inicia su desarrollo en 1991.
 - El 5 de octubre de 1991 se anuncia la primera version.
 - En 1992 se combira su desarrollo con GNU.
 - La version 1.0 se lanza en 1994.

B) Las funciones principales del kernel son:
- Administrar el uso de la memoria principal (RAM).
- Proveer metodos para el uso de dispositivos E/S.
- Administrar el uso de la CPU, mediante el uso de procesos.
- Administrar la memoria del sistema.
- Administrar dispositivos.
- System Calls.

C) La ultima version estable al 11/09/2024 es la 6.10. Antes de la version 2.6, los numeros impares en el segundo digito de la version implicaban desarrollo y los pares produccion.

D) Si.

E) En Arch Linux, los paquetes del kernel se encuentran en /usr/lib/modules

Estos paquetes se usan para generar la imagen que ejecutable vmlinuz, que es un archivo ejecutable enlazado estaticamente que contiene el kernel de linux. Por convencion de el FHS esta imagen se encuentra en /boot o /

F) El kernel linux es monolitico ya que la totalidad del sistema operativo se ejecuta en espacio del kernel. Ademas, es modular (o hibrido) porque se puede ensamblar con modulos que se cargan y descargan en tiempo de ejecucion.

#### 5)
A) El shell es un programa que expone los servicios del SO al usuario o a otros programas.

B) Su funcion es actuar como interfaz entre el sistema operativo y los usuarios y programas.

C)
 - sh: Esta disponible en todas las versiones de UNIX.
 - bash: Desarrollado por el proyecto GNU como alternativa libre a sh.
 - zsh: Combina funcionalidades de varios shells. Permite agregar temas.

D) El shell busca los comandos en el siguiente orden:
1. Comandos internos.
2. Alias.
3. PATH.

E) El shell no es parte del kernel, sino que provee una abstraccion para interactuar con este.

F) Es posible definir shells distintos para cada usuario. La informacion de que shell usa cada usuario se guarda en /etc/passwd. Cada usuario puede cambiar su shell mediante el commando chsh.

#### 6)
A) El sistema de archivos es la forma en la que se organizan, administran y acceden a los archivos.

B) Algunos de los FS soportados por GNU/Linux son:
1. ext: La mas usada en sistemas GNU/Linux.
2. Btrfs: Busca remplazar ext.
3. NTFS: FS propietario desarrollado por Microsoft.

C) Si.

D) El estandar de jerarquia del sistema de archivos, o Filesystem Hierarchy Standard (FHS) en ingles, es una norma que define los directorios principales y sus contenidos en el sistema operativo GNU/Linux.
Especificaciones de directorios mas importantes:

 - / : Contiene todo el sistema de jerarquia.
 - /bin : Ejecutables escenciales para el sistema.
 - /dev : Archivos asociados a dispositivos de hardware.
 - /etc : Archivos de configuracion del sistema.
 - /sbin : Ejecutables exclusivos del superusuario.
 - /home : Directorios de trabajo de los usuarios.
 - /lib : Librerias que son escenciales para otros ejecutables.
 - /proc : Archivos de texto que documentan el estado del sistema.
 - /root : Directorio de trabajo del superusuario.
 - /tmp : Archivos temporales.
 - /usr : Utilidades y aplicaciones accesibles para todos los usuarios.
 - /var : Archivos variables y registros del sistema.
 - /sys : FS de archivos virtuales que documentan el kernel.
 - /mnt : FSs montados temporalmente.
