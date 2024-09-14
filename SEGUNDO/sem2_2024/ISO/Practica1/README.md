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
Para asegurar que todo el software de una computadora le de los anteriores permisos al usuario, Stallman decide desarrollar un sistema operativo (GNU) que luego usaria el kernel desarrollado por Linus Torvalds.

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
 - En 1992 se combina su desarrollo con GNU.
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

#### 7)
A) Una particion es una division logica de un disco de almacenamiento secundario.

Al usar el esquema de particionado MBR nos encontramos con los siguientes tipos de particiones:
1. Particion primaria: Pueden haber 4 y cada una tiene su FS.
2. Particion extendida: Solo puede haber 1 y ademas puede dividirse en unidades logicas.
3. Particion logica: Ocupa una parte o la totalidad de la particion extendida y tien un FS.

B) En GNU/Linux, las particiones se identifican a traves de archivos especiales en el directorio /dev. La nomenclatura varía segun el tipo de disco:
1. Discos IDE (PATA):

    Los discos IDE se identifican como hdX, donde
    X es una letra asignada al disco (por ejemplo, hda, hdb).
    Las particiones se numeran como hdX1, hdX2, etc.
    Ejemplo: el primer disco IDE puede ser hda, y la primera partición en ese disco sería hda1.

2. Discos SCSI, SATA, y USB:

    Los discos SCSI, SATA y dispositivos de almacenamiento USB usan el identificador sdX.
    X es una letra asignada al disco (por ejemplo, sda, sdb).
    Las particiones se numeran como sdX1, sdX2, etc.
    Ejemplo: el primer disco SATA o SCSI sería sda, y la primera partición sería sda1.

C) Para instalar GNU/Linux basta con una sola particion para el directorio raiz. Pero normalmente se utilizan 2 o 3 particiones:
- Particion raiz: Normalmente usa ext4 y se monta en /
- Particion de intercambio
- Particion del sistema EFI (UEFI): Normalmente usa FATxx y se monta en /boot o /efi

D) Algunos ejemplos en los que resulta conveniente particionar son dividir los archivos del usuario y los del sistema en distintas particiones o instalar distintos SOs.

E) Podemos clasificar los particionadores segun su comportamiento en:
1. Destructivos (ej: fdisk): Reorganizan o crean particiones eliminando o sobrescribiendo datos existentes.
2. No destructivos (ej: gparted): Permite redimensionar particiones existentes sin perder datos, siempre y cuendo haya espacio disponible.

#### 8)
A) El BIOS (Basic Input/Output System) es un firmware que tiene el proposito de iniciar y probar el hardware del sistema y cargar un gestor de arranque o sistema operativo desde un dispositivo de almacenamiento de datos.

B) La UEFI (Unified Extensible Firmware Interface) es una especificacion que define una interfaz entre el sistema operativo y el firmware. UEFI remplaza la interfaz BIOS, agregando multiples caracteristicas como menus graficos y soporte para GTP.

C) El MBR (Master Boot Record) es el primer sector de de un dispositivo de almacenamiento de datos. Generamente se usa para el arranque de un sistema operativo, o almacenar una tabla de particiones o identificar un disco.
El MBC (Master Boot Code) es el codigo de maquina que se encuentra en los primeros 446 Bytes del MBR y es utilizado en el arranque del sistema.

D) La GPT (GUID Partition Table) es un estandar para la colocacion de la tabla de particiones en un disco duro fisico. Es parte del estandar EFI y sustituye al MBR usado con el BIOS.

GPT usa LBA (Logical Block Addressing) en vez de CHS (Cylinder Head Sector). La informacion del MBR heredado se encuentra en el LBA0, la cabecera GPT esta en el LBA1 y la tabla de particiones en los bloques sucesivos. La cabecera GPT y la tabla de particiones estan escritas tanto al principio como al final del disco.

E) Un cargador de arranque o bootloader es un programa que se llama al final del proceso de arranque para cargar en memoria el kernel de un SO y cederle el control de la maquina.

Para sistemas BIOS es practicamente obligatorio debido al reducido espacio disponible en la MBR para lanzar directamente el kernel. Con firmware UEFI se podria lanzar directamente el kernel pero se usan debido a la versatilidad de opciones que ofrece la carga indirecta a traves del bootloader.

Un gestor de arranque o boot manager es un software que brinda un menu para que el usuario elija el siguiente codigo a ejecutar (normalmente un bootloader) en el proceso de arranque, habitualmente el gestor de arranque forma parte del cargador de arranque como por ejemplo en GRUB, GRUB2, LILO o SYSLINUX.

Dentro de un disco duro el bootloader puede instalarse en el MBC, si se usa firmware BIOS, o en la EFI System Partition (ESP), si se usa firmware UEFI.

F) Los pasos que suceden en un proceso de bootstrap son:
1. Se alimenta el hardware del sistema.
2. El BIOS o la UEFI realizan el POST (Power-On Self Test).
3. El BIOS/UEFI busca un dispositivo de arranque y carga el MBR o el GPT respectivamente a memoria.
4. Se carga y ejecuta el bootloader.
5. El bootloader carga el kernel en la memoria.
6. Comienza a ejecutarse el kernel y realiza tareas iniciales como detectar y configurar, dispositivos y controladores de hardware, ademas de subsistemas necesarios para el funcionamiento del sistema.
7. Una vez que el kernel ha finalizado su configuracion inicial, ejecuta el proceso principal de inicializacion del sistema.
8. Cuando todos los servicios del sistema estan activos, el sistema operativo carga el entorno de usuario, que puede ser grafico o un interfaz de linea de comandos.

G) El proceso de arranque de un sistema GNU/Linux se compone de los siguientes pasos:
1. Se comienza a ejecutar el codigo de el BIOS o la UEFI.
2. El firmware interface usado ejecuta el POST.
3. El BIOS/UEFI selecciona un dispositivo de arranque dependiendo de la configuracion del sistema.
4. Se ejecuta el codigo del bootloader. Este codigo se encuentra en el MBR o en un archivo .efi en la ESP respectivamente.
5. El bootloader carga el kernel en memoria y le cede el control.
6. El kernel realiza chequeos de dispositivos y controladores, ademas de preparar el sistema.
7. El kernel ejecuta el proceso del sistema de inicio (Init, Systemd, etc).
8. Entre muchas cosas, el sistema de inicio realiza pruebas, monta sistemas de archivos, y inicia los procesos adecuados segun el Run Level actual.

H) Los pasos que suceden en el proceso de parada de GNU/Linux son:
1. Se ejecuta un comando de apagado como shutdown, poweroff, o halt.
2. Se envia a los procesos la señal SIGTERM, para notificarles que deben cerrarse de forma ordenada.
3. Se da un tiempo de gracia para que los procesos puedan terminar sus tareas.
4. Despues del tiempo de espera, se envia la señal SIGKILL, para forzar la finalizacion inmediata del proceso.
5. Los datos de escrituras pendientes, almacenados en buffers o memoria cache se escriben en los discos.
6. Los sistemas de archivos montados se desmontan de forma segura.
7. Se desactivan las interfaces y hardware, como interfaces de red, perisfericos, pantallas, etc.
8. El kernel envia la señal para detener la CPU y cortar la alimentacion del sistema.
9. El hardware se apaga fisicamente, cortando la energia a los componentes del sistema.

I) Si, es posible tener GNU/Linux y otro sistema operativo instalados en la misma PC. Esto se logra particionando el disco duro (o usando varios discos) para que cada sistema opetarivo tenga su propio espacio y utilizando un gestor de arranque que permita seleccionar cual sistema operativo iniciar.

#### 9)
A) En GNU/Linux los archivos se pueden identificar con los siguientes parametros:
1. Nombre del archivo.
2. Ubicacion del archivo.
3. Numero de Inodo.
4. Permisos del archivo.
5. Propietario y grupo del archivo.

B)
1. vi: Editor de texto creado para sistemas operativos Unix-like.
2. mcedit: Es el editor de texto usado en administrador de archivos GNU Midnight Commander.
3. cat: Lee archivos y los escribe en la salida estandar.
4. more: Permite ver los contenidos de un archivo y verlo por paginas.

C) 👍

D) file es un comando que permite reconocer el tipo de datos contenidos en un archivo de computadora.

#### 10)
A) mkdir: Crea uno o varios directorios.

B) cd: Cambia el directorio de trabajo.

C) touch: Cambia la marca de tiempo de un archivo, si no existe lo crea.

D) ls: Lista los contenidos de un directorio.

E) pwd: Imprime el nombre completo del directorio actual de trabajo.

F) find: Busca archivos en una jerarquia de directorios.

G) df: Genera un reporte del espacio usado en los sistemas de archivos.

H) who: Muestra que usarios estan logueados.

I) vi: Editor de texto.

J) tail: Imprime las ultimas 10 lineas de un archivo. head imprime las primeras 10.

#### 11)
A) shutdown: Apaga el sistema.

B) reboot: Reinicia el sistema.

C) halt: Detiene el sistema.

D) locate: Busca archivos por nombre, generalmente mas rapido que find.

E) uname: Imprime cierta informacion del sistema.

F) dmesg: Muestra el buffer de mensajes del kernel.

G) lspci: Lista todos los dispositivos PCI.

H) at: Permite ejecutar comandos en un tiempo particular.

I) netstat: Informa estadisticas de red.

J) mount: Monta un sistema de archivos.

K) umount: Desmonta un sistema de archivos.

L) head: Imprime las primeras 10 lineas de un archivo.

M) losetup: Permite configurar y controlar loop devices.

N) write: Permite enviar un mensaje a otro usuario.

Ñ) mkfs: Permite crear un sistema de archivos linux.

O) fdisk: Muestra o manipula la tabla de particiones de un disco.

#### 12)
Todos los programas se encuentran en /usr/bin.
