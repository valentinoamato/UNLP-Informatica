# Práctica 2
### Objetivo
El objetivo de esta práctica es que el alumno comprenda los aspectos principales acerca de la es
tructura del sistema Operativo GNU/Linux en lo que respecta a procesos, usuarios, filesystems,
permisos, etc.

#### 1. Editor de textos:
##### A) Nombre al menos 3 editores de texto que puede utilizar desde la línea de comandos.
1. vi
2. vim
3. neovim

##### B) ¿En qué se diferencia un editor de texto de los comandos cat, more o less? Enumere los modos de operación que posee el editor de textos vi.
Las principales diferencias son que un editor de texto permite modificar el archivo objetivo y suelen tener una interfaz visual.

El editor vi tiene tres modos:
 - Insert Mode: El texto escrito se inserta en el documento.
 - Command Mode: El texto ingresado se interpreta como comandos.
 - Normal Mode: Usado principalmente para navegar.

##### C) Nombre los comandos más comunes que se le pueden enviar al editor de textos vi.

Algunos de los comandos mas comunes en vi son:
- q : Sale del editor.
- w : Guarda los cambios.
- dd : Elimina la linea actual.
- u : Deshacer.
- x : Eliminar el caracter actual.
- / : Buscar.

#### 2. Proceso de Arranque SystemV (https://github.com/systeminit/si):
##### A) Enumere los pasos del proceso de inicio de un sistema GNU/Linux, desde que se prende la PC hasta que se logra obtener el login en el sistema.
1. Se comienza a ejecutar el codigo de el BIOS.
2. El BIOS ejecuta el POST.
3. El BIOS lee el sector de arranque (MBR).
4. Se carga el gestor de arranque (MBC)
5. El bootloader carga el kernel y el initrd.
6. Se monta el initrd como sistema de archivos raız y se inicializan componentes esenciales (ej: scheduler).
7. El Kernel ejecuta el proceso init y se desmonta el initrd.
8. Se lee el /etc/inittab.
9. Se ejecutan los scripts apuntados por el runlevel 1.
10. El final del runlevel 1 le indica que vaya al runlevel por defecto.
11. Se ejecutan los scripts apuntados por el runlevel por defecto.
12. El sistema esta listo para usarse.

##### B) Proceso INIT. ¿Quién lo ejecuta? ¿Cuál es su objetivo?
El proceso INIT es ejecutado por el kernel con el objetivo de cargar todos los subprocesos necesarios para el correcto funcionamiento del SO.
##### C) RunLevels. ¿Qué son? ¿Cuál es su objetivo?
Los runlevels son modos de operacion en los sistemas operativos que implementan el estilo de sistema de arranque de iniciacion tipo UNIX System V. Su objetivo es permitir al sistema operar en diferentes configuraciones segun las necesidadeds del usuario o del administrador.
##### D) ¿A qué hace referencia cada nivel de ejecución según el estándar? ¿Dónde se define qué Runlevel ejecutar al iniciar el sistema operativo? ¿Todas las distribuciones respetan estos estándares?
La mayoria de las distribuciones definen los siguientes runlevels:
- 0: Apaga el sistema.
- 1: Modo de usuario unico, para tareas administrativas.
- 2: Modo de multiples usarios, sin soporte de red.
- 3: Modo de multiples usuarios, con soporte de red y sin GUI.
- 4: Reservado para uso personalizado.
- 5: Similar al modo 3 pero con un servidor grafico.
- 6: Reinicio del sistema.
Algunas distribuciones usan systemd, y remplazan el concepto de runlevels por targets.

El runlevel a ejecutar al iniciar el SO se define en el archivo /etc/inittab. En los sistemas que usan systemd el target de inicio se define normalmente mediante un symlink que apunta a un archivo .target en /etc/systemd/system/default.target.
##### E) Archivo /etc/inittab. ¿Cuál es su finalidad? ¿Qué tipo de información se almacena en el? ¿Cuál es la estructura de la información que en él se almacena?
El archivo /etc/inittab tiene la finalidad de definir como se gestionan los diferentes runlevels y que procesos deben iniciarse o detenerse en cada uno de ellos. 

El archivo almacena la siguiente informacion:
- Runlevel por defecto.
- Comandos que deben ejecutarse en cada runlevel.
- Configuracion de consolas virtuales.
- Manejo de eventos especiales, como apagar o reiniciar el sistema.

El archivo tiene una estructura en la que cada linea contiene 4 campos separados por dos puntos:

    id:runlevel:accion:proceso

- id: Identifica la entrada.
- runlevel: Los runlevels para los cuales la entrada es valida.
- acccion: Define la accion a realizar.
- proceso: El comando o proceso que se ejecutara.

##### F) Suponga que se encuentra en el runlevel <X\>. Indique qué comando(s) ejecutaría para cambiar al runlevel <Y\>. ¿Este cambio es permanente? ¿Por qué?
Para cambiar de runlevel usaria el comando init <Y\>. El cambio no seria permanente ya que al reiniciar el sistema se volvera a iniciar en el runlevel por defecto.
##### G) Scripts RC. ¿Cuál es su finalidad? ¿Dónde se almacenan? Cuando un sistema GNU/Linux arranca o se detiene se ejecutan scripts, indique cómo determina qué script ejecutar ante cada acción. ¿Existe un orden para llamarlos? Justifique.
Los Scripts RC tienen la finalidad de iniciar y detener servicios al cambiar de runlevel. Se almacenan /etc/init.d/ con enlaces simbolicos en /etc/rc<X\>.d.

Dentro de un archivo rc<X/>.d se encuentran los nombres de los scripts con un prefijo que indica si el script se debe iniciar o terminar, y un numero que determina el orden en el que deben ejecutarse. Para determinar que scripts deben ejecutarse en determinado momento se usan los anteriores prefijos y el runlevel.
#### 3. SystemD(https://github.com/systemd/systemd):
##### A) ¿Qué es sytemd?
Sistemd es un conjunto de demonios de administracios del sistema, librerias y herramientas que permiten administrar y configurar el kernel de Linux. Sistemd se puede usar como sistema de inicio de Linux.
##### B) ¿A qué hace referencia el concepto de Unit en SystemD?
El concepto Unit se refiere a una unidad de trabajo, puede ser de muchos tipos.
##### C) ¿Para que sirve el comando systemctl en SystemD?
El comando systemctl se usa para controlar systemd. Algunos de sus usos incluyen examinar el estado del sistema y gestionar el sistema y servicios.
##### D) ¿A qué hace referencia el concepto de target en SystemD?
El concepto de target hace referencia a un grupo de unidades. Tienen un proposito similar al de los runlevels, pero con diferencias; algunas de ellas son:
1. Los targets tienen nombre en vez de numero.
2. Varios targets pueden estar activos a la vez.
3. Algunos targets pueden implementarse heredando todos los servicios de otro target.

##### E) Ejecute el comando pstree. ¿Qué es lo que se puede observar a partir de la ejecución de este comando?
El comando pstree muestra un arbol con los procesos del sistema.

#### 4. Usuarios:
##### A) ¿Qué archivos son utilizados en un sistema GNU/Linux para guardar la información de los usuarios?
Los archivos principales donde se guarda la informacion de los usuarios son:

1. /etc/passwd: Guarda los usuarios registrados en el sistema.
2. /etc/shadow: Guarda las contraseñas de los usuarios de manera encriptada.
3. /etc/group: Guarda la informacion de los grupos en el sistema y que usuarios los integran.

##### B) ¿A qué hacen referencia las siglas UID y GID? ¿Pueden coexistir UIDs iguales en un sistema GNU/Linux? Justifique.
UID (User ID) es un numero unico que identifica a un usuario en un sistema. El UID permite al sistema asociar permisos y recursos con un usuario especifico. En teoria pueden coexistir usuarios con el mismo UID, pero no es una practica recomendada.

GID (Group ID): Es un numero que identifica a un grupo. Se usa para asociar a un usuario con uno o mas grupos y permite determinar los permisos que un grupo tiene sobre archivos y recursos del sistema.
##### C) ¿Qué es el usuario root? ¿Puede existir más de un usuario con este perfil en GNU/Linux? ¿Cuál es la UID del root?.
El usuario root es el superusuario o administrador en sistemas GNU/Linux. Es el usuario con los maximos privilegios, lo que le permite realizar cualquier operacion en el sistema sin restricciones. El usuario root tiene UID 0. Pueden existir varios usuarios con los mismos privilegios de root.
##### D) Agregue un nuevo usuario llamado iso2017 a su instalación de GNU/Linux, especifique que su home sea creada en /home/iso_2017, y hágalo miembro del grupo catedra (si no existe, deberá crearlo). Luego, sin iniciar sesión como este usuario cree un archivo en su home personal que le pertenezca. Luego de todo esto, borre el usuario y verifique que no queden registros de él en los archivos de información de los usuarios y grupos.
:thumbsup:
##### E) Investigue la funcionalidad y parámetros de los siguientes comandos:
A) useradd: Crea un nuevo usuario.

B) usermod: Modifica un usuario.

C) userdel: Elimina un usuario.

D) su: Permite ejecutar comandos como otro usuario y grupo.

E) groupadd: Crea un grupo.

F) who: Muestra los usuarios logueados.

G) groupdel: Elimina un grupo.

H) passwd: Cambia la clave de un usuario.
#### 5. FileSystem:
##### A) ¿Cómo son definidos los permisos sobre archivos en un sistema GNU/Linux?
En un sistema GNU/Linux, los permisos sobre archivos y directorios estan definidos por tres atributos principales: lectura (r\), escritura (w) y ejecucion (x). Estos permisos se asignan a tres categorias de usuarios: propietario (user), grupo (group) y otros (others). Cada archivo o directorio tiene un conjunto de permisos para cada una de estas categorias.

##### B) Investigue la funcionalidad y parámetros de los siguientes comandos relacionados con los permisos en GNU/Linux:
A) chmod: Cambia el modo de archivos.

B) chown: Cambia el propietario y/o grupo de archivos.

C) chgrp: Cambia el grupo de archivos.
##### C) Al utilizar el comando chmod generalmente se utiliza una notación octal asociada para definir permisos. ¿Qué significa esto? ¿A qué hace referencia cada valor?
La notacion octal emplea tres digitos del 0 al 7 para representar los permisos del propietario, el grupo y otros, en ese orden. Cada permiso tiene un numero, 4 para lectura, 2 para escritura y 1 para ejecucion. El digito se compone de la suma de los permisos. De este modo el numero 754 significa que el propietario tiene todos los permisos, el grupo tiene permisos de lectura y ejecucion, y los demas tienen permiso de lectura.

##### D) ¿Existe la posibilidad de que algún usuario del sistema pueda acceder a determinado archivo para el cual no posee permisos? Nombrelo, y realice las pruebas correspondientes.
Si, por ejemplo el superusuario puede acceder a archivos para los cuales no tiene permiso.
##### E) Explique los conceptos de “full path name” y “relative path name”. De ejemplos claros de cada uno de ellos.
Una ruta absoluta es una ruta completa que comienza desde el directorio raiz del sistema y especifica la ubicacion exacta de un directorio, por ejemplo, /etc/shadow. Una ruta relativa se refiere a la ubicacion de un archivo o directorio en relacion con el directorio actual de trabajo, por ejemplo, fotos/pajaritos/chingolo.png.
##### F) ¿Con qué comando puede determinar en qué directorio se encuentra actualmente? ¿Existe alguna forma de ingresar a su directorio personal sin necesidad de escribir todo el path completo? ¿Podría utilizar la misma idea para acceder a otros directorios? ¿Cómo? Explique con un ejemplo.
Con el comando pwd se puede determinar en que directorio se encuentra actualmente.

Para acceder a mi directorio personal sin necesidad de escribir todo el path puedo usar una de las siguientes opciones:
```bash
$ cd $HOME
$ cd ~
```
Para lograr lo mismo con otro directorio podria crear una variable de entorno, para hacerlo de manera permanente dicha variable deberia definirse en el archivo de configuracion adecuado (~/.bashrc, ~/.zshrc, etc):
```bash
$ export DOCUMENTS="$HOME/Documents"
$ cd $DOCUMENTS
```

##### G) Investigue la funcionalidad y parámetros de los siguientes comandos relacionados con el uso del FileSystem:
A) cd: Cambia el directorio de trabajo.

B) umount: Desmonta un sistema de archivos.

C) mkdir: Crea uno o varios directorios.

D) du: Analiza y reporta el uso del disco dentro de directorios y archivos.

E) rmdir: Elimina directorios vacios.

F) df: Genera un reporte del espacio usado en los sistemas de archivos.

G) mount: Monta un sistema de archivos.

H) ln: Crea enlaces entre archivos.

I) ls: Lista los contenidos de un directorio.

J) pwd: Imprime el nombre completo del directorio actual de trabajo.

K) cp: Copia archivos y directorios.

L) mv: Mueve archivos.
#### 6. Procesos:
##### A) ¿Qué es un proceso? ¿A que hacen referencia las siglas PID y PPID? ¿Todos los procesos tienen estos atributos en GNU/Linux? Justifique. Indique qué otros atributos tiene un proceso.
Un proceso es una instancia de un programa en ejecucion en un sistema operativo. La sigla PID (Process ID) es un numero unico que identifica a cada proceso en ejecucion. La sigla PPID (Parent Process ID) es el numero de identificacion del proceso padre de un proceso dado. Todos los procesos tienen PID y PPID, la unica excepcion es el proceso inicial que no tiene PPID. Ademas un proceso tiene otros atributos como prioridad, uso de memoria y CPU, tiempo de inicio y ejecucion, etc.

##### B) Indique qué comandos se podrían utilizar para ver qué procesos están en ejecución en un sistema GNU/Linux.
Algunas opciones de comandos son:
1. ps aux
2. pstree
3. top
##### C) ¿Qué significa que un proceso se está ejecutando en Background? ¿Y en Foreground?
Un proceso que se ejecuta en segundo plano o background no requiere la intervencion directa del usuario y no bloquea el uso del terminal, mientras que un proceso que se ejecuta en primer plano o foreground requiere la antencion del usuario y no se puede ejecutar otro comando en la misma terminal hasta que este proceso termine.
##### D) ¿Cómo puedo hacer para ejecutar un proceso en Background? ¿Como puedo hacer para pasar un proceso de background a foreground y viceversa?
Para ejecutar un proceso en background se agrega un & al final del commando a utilizar (ej: alacritty &).

En los sistemas operativos que cumplen la especificacion POSIX, un grupo de procesos es una coleccion de uno o mas procesos. Estos grupos de usan generalmente para la distribucion de señales. Un job o trabajo es la representacion del shell de un grupo de procesos. Las operaciones basicas son suspender, resumir o terminar todos los procesos de un job/process group.

Con el comando jobs se imprime una lista de los jobs en el shell actual, luego con bg %n o fg %n se puede llevar el job n al background o foreground respectivamente. Si no se agrega el parametro %n se asume el ultimo job.

Entonces para pasar el ultimo job de foreground a background basta con suspenderlo temporalmente usando `Ctrl + Z`, y luego enviarlo al fondo usando el comando bg. Para hacer lo contrario basta con ingresar el comando fg.

##### E) Pipe ( | ). ¿Cuál es su finalidad? Cite ejemplos de su utilización.
El pipe permite encadenar dos o mas comandos, de manera que la salida de un comando (stdout) se convierta en la entrada de otro (stdin). Ejemplo:
```bash
$ ls | wc -l # Cuenta cuantos archivos hay en un directorio.
```
##### F) Redirección. ¿Qué tipo de redirecciones existen? ¿Cuál es su finalidad? Cite ejemplos de utilización.
Las redirecciones permiten cambiar el flujo de entrada o salida de un comando o proceso.

Dos de las mas usadas son:
- Redireccion de salida (>): Si el archivo destino existe lo sobreescribe con el nuevo contenido, si no, lo crea. Ej: `echo hola > hola.txt`.
- Adicion de la salida redirigida (>>): Si el archivo destino existe le agrega la informacion al final, si no, lo crea. Ej: `echo hola >> hola.txt`.
##### G) Comando kill. ¿Cuál es su funcionalidad? Cite ejemplos.
El commando kill se usa para enviar señales a los procesos.
```bash
$ kill 1234 # Asesina al proceso con PID 1234.
$ kill -l # Imprime las señales disponibles.
$ kill -19 1234 # Envia la señal STOP al proceso con PID 1234.
```
##### H) Investigue la funcionalidad y parámetros de los siguientes comandos relacionados con el manejo de procesos en GNU/Linux. Además, compárelos entre ellos:
A) ps: Muestra informacion sobre los procesos en ejecucion.

B) kill: Envia señales a procesos.

C) pstree: Muestra los procesos en un arbol jerarquico.

D) killall: Termina todos los procesos que coincidan con el nombre especificado.

E) top: Monitorea los procesos en tiempo real y el uso de recursos.

F) nice: Ajusta la prioridad de un proceso.

#### 7. Otros comandos de Linux (Indique funcionalidad y parámetros):

##### A) ¿A qué hace referencia el concepto de empaquetar archivos en GNU/Linux?
##### B) Seleccione 4 archivos dentro de algún directorio al que tenga permiso y sume el tama-
ño de cada uno de estos archivos. Cree un archivo empaquetado conteniendo estos 4
archivos y compare los tamaños de los mismos. ¿Qué característica nota?
##### C) ¿Qué acciones debe llevar a cabo para comprimir 4 archivos en uno solo? Indique la
secuencia de comandos ejecutados.
##### D) ¿Pueden comprimirse un conjunto de archivos utilizando un único comando?
##### E) Investigue la funcionalidad de los siguientes comandos:
tar
grep
gzip
zgrep
wc
Pág. 3
UNLP |Facultad de Informática ISO 2024 | Práctica 2
#### 8. Indique qué acción realiza cada uno de los comandos indicados a continuación considerando
su orden. Suponga que se ejecutan desde un usuario que no es root ni pertenece al grupo
de root. (Asuma que se encuentra posicionado en el directorio de trabajo del usuario con el
que se logueó). En caso de no poder ejecutarse el comando, indique la razón:
l s −l > prueba
ps > PRUEBA
chmod 710 prueba
chown r o o t : r o o t PRUEBA
chmod 777 PRUEBA
chmod 700 / e t c / passwd
passwd r o o t
rm PRUEBA
man / e t c / shadow
f i n d / −name ∗ . c o n f
usermod r o o t −d /home/ newroot −L
cd / r o o t
rm ∗
cd / e t c
cp ∗ /home −R
shutdown
#### 9. Indique qué comando sería necesario ejecutar para realizar cada una de las siguientes ac-
ciones:
##### A) Terminar el proceso con PID 23.
##### B) Terminar el proceso llamado init o systemd. ¿Qué resultados obtuvo?
##### C) Buscar todos los archivos de usuarios en los que su nombre contiene la cadena “.conf”
##### D) Guardar una lista de procesos en ejecución el archivo /home/<su nombre de usua-
rio>/procesos
##### E) Cambiar los permisos del archivo /home/<su nombre de usuario>/xxxx a:
Usuario: Lectura, escritura, ejecución
Grupo: Lectura, ejecución
Otros: ejecución
##### F) Cambiar los permisos del archivo /home/<su nombre de usuario>/yyyy a:
Usuario: Lectura, escritura.
Grupo: Lectura, ejecución
Otros: Ninguno
##### G) Borrar todos los archivos del directorio /tmp
##### H) Cambiar el propietario del archivo /opt/isodata al usuario iso2010
##### I) Guardar en el archivo /home/<su nombre de usuario>/donde el directorio donde
me encuentro en este momento, en caso de que el archivo exista no se debe eliminar
su contenido anterior.
#### 10. Indique qué comando sería necesario ejecutar para realizar cada una de las siguientes ac-
ciones:
##### A) Ingrese al sistema como usuario “root”
##### B) Cree un usuario. Elija como nombre, por convención, la primer letra de su nombre
seguida de su apellido. Asígnele una contraseña de acceso.
Pág. 4
UNLP |Facultad de Informática ISO 2024 | Práctica 2
##### C) ¿Qué archivos fueron modificados luego de crear el usuario y qué directorios se crearon?
##### D) Crear un directorio en /tmp llamado cursada2017
##### E) Copiar todos los archivos de /var/log al directorio antes creado.
##### F) Para el directorio antes creado (y los archivos y subdirectorios contenidos en él) cambiar
el propietario y grupo al usuario creado y grupo users.
##### G) Agregue permiso total al dueño, de escritura al grupo y escritura y ejecución a todos
los demás usuarios para todos los archivos dentro de un directorio en forma recursiva.
##### H) Acceda a otra terminal virtual para loguearse con el usuario antes creado.
##### I) Una vez logueado con el usuario antes creado, averigüe cuál es el nombre de su terminal.
##### J) Verifique la cantidad de procesos activos que hay en el sistema.
##### K) Verifiqué la cantidad de usuarios conectados al sistema.
##### L) Vuelva a la terminal del usuario root, y envíele un mensaje al usuario anteriormente
creado, avisándole que el sistema va a ser apagado.
##### M) Apague el sistema.
#### 11. Indique qué comando sería necesario ejecutar para realizar cada una de las siguientes ac-
ciones:
##### A) Cree un directorio cuyo nombre sea su número de legajo e ingrese a él.
##### B) Cree un archivo utilizando el editor de textos vi, e introduzca su información personal:
Nombre, Apellido, Número de alumno y dirección de correo electrónico. El archivo
debe llamarse "LEAME".
##### C) Cambie los permisos del archivo LEAME, de manera que se puedan ver reflejados los
siguientes permisos:
Dueño: ningún permiso
Grupo: permiso de ejecución
Otros: todos los permisos
##### D) Vaya al directorio /etc y verifique su contenido. Cree un archivo dentro de su directorio
personal cuyo nombre sea leame donde el contenido del mismo sea el listado de todos
los archivos y directorios contenidos en /etc. ¿Cuál es la razón por la cuál puede crear
este archivo si ya existe un archivo llamado "LEAME.en este directorio?.
##### E) ¿Qué comando utilizaría y de qué manera si tuviera que localizar un archivo dentro
del filesystem? ¿Y si tuviera que localizar varios archivos con características similares?
Explique el concepto teórico y ejemplifique.
##### F) Utilizando los conceptos aprendidos en el punto e), busque todos los archivos cuya
extensión sea .so y almacene el resultado de esta búsqueda en un archivo dentro del
directorio creado en a). El archivo deberá llamarse .ejercicio_f".
#### 12. Indique qué acción realiza cada uno de los comandos indicados a continuación considerando
su orden. Suponga que se ejecutan desde un usuario que no es root ni pertenece al grupo
de root. (Asuma que se encuentra posicionado en el directorio de trabajo del usuario con el
que se logueó). En caso de no poder ejecutarse el comando indique la razón:
mkdir i s o
cd . / i s o ; ps > f 0
l s > f 1
cd /
echo $HOME
Pág. 5
UNLP |Facultad de Informática ISO 2024 | Práctica 2
l s −l $> $HOME/ i s o / l s
cd $HOME; mkdir f 2
l s −l d f 2
chmod 341 f 2
touch d i r
cd f 2
cd ~/ i s o
pwd >f 3
ps | grep ' ps ' | wc −l >> . . / f 2 / f 3
chmod 700 . . / f 2 ; cd . .
f i n d . −name e t c / passwd
f i n d / −name e t c / passwd
mkdir e j e r c i c i o 5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
##### A) Inicie 2 sesiones utilizando su nombre de usuario y contraseña. En una sesión vaya
siguiendo paso a paso las órdenes que se encuentran escritas en el cuadro superior.
En la otra sesión, cree utilizando algún editor de textos un archivo que se llame
.ejercicio10_explicacion"dentro del directorio creado en el ejercicio 9.a) y, para cada
una de las órdenes que ejecute en la otra sesión, realice una breve explicación de los
resultados obtenidos.
##### B) Complete en el cuadro superior los comandos 19 y 20, de manera tal que realicen la
siguiente acción:
19: Copiar el directorio iso y todo su contenido al directorio creado en el inciso
9.a).
20: Copiar el resto de los archivos y directorios que se crearon en este ejercicio al
directorio creado en el ejercicio 9.a).
##### C) Ejecute las órdenes 19 y 20 y comentelas en el archivo creado en el inciso a).
#### 13. Cree una estructura desde el directorio /home que incluya varios directorios, subdirectorios
y archivos, según el esquema siguiente. Asuma que “usuario” indica cuál es su nombre de
usuario. Además deberá tener en cuenta que dirX hace referencia a directorios y fX hace
referencia a archivos:
##### A) Utilizando la estructura de directorios anteriormente creada, indique que comandos
son necesarios para realizar las siguientes acciones:
Mueva el archivo "f3.al directorio de trabajo /home/usuario.
Pág. 6
UNLP |Facultad de Informática ISO 2024 | Práctica 2
Copie el archivo "f4.en el directorio "dir11".
Haga los mismo que en el inciso anterior pero el archivo de destino, se debe llamar
"f7".
Cree el directorio copia dentro del directorio usuario y copie en él, el contenido de
"dir1".
Renombre el archivo "f1"por el nombre archivo y vea los permisos del mismo.
Cambie los permisos del archivo llamado archivo de manera de reflejar lo siguiente:
• Usuario: Permisos de lectura y escritura
• Grupo: Permisos de ejecución
• Otros: Todos los permisos
Renombre los archivos "f32 "f4"de manera que se llamen "f3.exe2 "f4.exerespectivamen-
te.
Utilizando un único comando cambie los permisos de los dos archivos renombrados en
el inciso anterior, de manera de reflejar lo siguiente:
• Usuario: Ningún permiso
• Grupo: Permisos de escritura
• Otros: Permisos de escritura y ejecución
#### 14. Indique qué comando/s es necesario para realizar cada una de las acciones de la siguiente
secuencia de pasos (considerando su orden de aparición):
##### A) Cree un directorio llamado logs en el directorio /tmp.
##### B) Copie todo el contenido del directorio /var/log en el directorio creado en el punto
anterior.
##### C) Empaquete el directorio creado en 1, el archivo resultante se debe llamar "misLogs.tar".
##### D) Empaquete y comprima el directorio creado en 1, el archivo resultante se debe llamar
"misLogs.tar.gz".
##### E) Copie los archivos creados en 3 y 4 al directorio de trabajo de su usuario.
##### F) Elimine el directorio creado en 1, logs.
##### G) Desempaquete los archivos creados en 3 y 4 en 2 directorios diferentes.
