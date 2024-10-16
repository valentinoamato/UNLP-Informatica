# Introducción a los Sistemas Operativos
## Práctica 3
### Objetivo:
#### El objetivo de esta práctica es que el alumno desarrolle habilidades concernientes a Shell Scripting.

#### 1. ¿Qué es el Shell Scripting? ¿A qué tipos de tareas están orientados los script? ¿Los scripts deben compilarse? ¿Por qué?
Shell scripting es la creacion de scripts o programas diseñados para ser ejecutados mediante un shell unix.
Los scripts estan orientados a tareas como la administracion de del sistema, la automatizacion de procesos, el manejo de archivos, el procesamiento de texto y la interaccion con programas del sistema.
Los scripts no necesitan compilarse ya que son interpretados linea por linea por el shell.

#### 2. Investigar la funcionalidad de los comandos echo y read.
- (a) ¿Como se indican los comentarios dentro de un script?
- (b) ¿Cómo se declaran y se hace referencia a variables dentro de un script?

`echo` muestra texto o el valor de variables en la salida estandar.

`read` permite la entrada de datos del usuario para almacenarlos en variables.

Los comentarios se indican mediante el simbolo numeral `#`.

Las variables se declaran simplemente asignando un valor a un nombre, y luego se las referencia usando el prefijo `$`:
```bash
variable="valor"
echo $variable
```

#### 3. Crear dentro del directorio personal del usuario logueado un directorio llamado practica-shell-script y dentro de él un archivo llamado mostrar.sh cuyo contenido sea el siguiente:
```bash
#!/bin/bash
# Comentarios acerca de lo que hace el script
# Siempre comento mis scripts, si no hoy lo hago
# y mañana ya no me acuerdo de lo que quise hacer
echo "Introduzca su nombre y apellido:"
read nombre apellido
echo "Fecha y hora actual:"
date
echo "Su apellido y nombre es:
echo "$apellido $nombre"
echo "Su usuario es: `whoami`"
echo "Su directorio actual es:"
```
- a) Asignar al archivo creado los permisos necesarios de manera que pueda ejecutarlo.

    >`chmod u+x EJ3.sh`
- b) Ejecutar el archivo creado de la siguiente manera: ./mostrar

    :thumbsup:
- c) ¿Qué resultado visualiza?

    >El script muestra la fecha y el usuario actual, junto con el nombre completo ingresado por teclado.
- d) Las backquotes (`) entre el comando whoami ilustran el uso de la sustitución de comandos. ¿Qué significa esto?

    >La sustitucion de comandos permite ejecutar un comando dentro de otro, y que el resultado sea remplazado en su lugar.
- e) Realizar modificaciones al script anteriormente creado de manera de poder mostrar distintos resultados (cuál es su directorio personal, el contenido de un directorio en particular, el espacio libre en disco, etc.). Pida que se introduzcan por teclado (entrada estándar) otros datos.

    >[Script](../Scripts/EJ3.sh)


#### 4. Parametrización: ¿Cómo se acceden a los parámetros enviados al script al momento de su invocación? ¿Qué información contienen las variables $#, $*, $? Y $HOME dentro de un script?
Se accede a los parametros enviados al script mediante las variables `$1`, `$2`, etc.

`$#`: Contiene la cantidad de parametros pasados al script.

`$*`: Contiene todos los parametros como una sola cadena.

`$?`: Contiene el codigo de salida del ultimo comando ejecutado.

`$HOME`: Contiene la ruta del directorio personal del usuario.

`$0`: Contiene el nombre del script ejecutado.

#### 5. ¿Cual es la funcionalidad de comando exit? ¿Qué valores recibe como parámetro y cual es su significado?
El comando exit permite finalizar la ejecucion del script y devolver un valor de salida. Si el valor de salida es 0 se entiende que el script termino con exito, de lo contrario se entiende que ocurrio un error.
#### 6. El comando expr permite la evaluación de expresiones. Su sintaxis es: expr arg1 op arg2, donde arg1 y arg2 representan argumentos y op la operación de la expresión. Investigar que tipo de operaciones se pueden utilizar.
El comando expr permite realizar operaciones aritmeticas y logicas.

#### 7. El comando “test expresión” permite evaluar expresiones y generar un valor de retorno, true o false. Este comando puede ser reemplazado por el uso de corchetes de la siguiente manera [ expresión ]. Investigar que tipo de expresiones pueden ser usadas con el comando test. Tenga en cuenta operaciones para: evaluación de archivos, evaluación de cadenas de caracteres y evaluaciones numéricas.
Las operaciones mas comunes son las siguientes:

|Operador|Con strings|Con numeros|
|-|-|-|
|Igualdad |"$nombre" = "Maria"| $edad -eq 20|
|Desigualdad | "$nombre" != "Maria" |$edad -ne 21|
|Mayor |A > Z | 5 -gt 20|
|Mayor o igual| A >= Z |5 -ge 20|
|Menor |A < Z |5 -lt 20|
|Menor o igual |A <= Z |5 -le 20|

|Operador| Descripcion|
|-|-|
| -e| El archivo existe.|
| -f| El archivo existe y es un archivo regular.|
| -d| El archivo existe y es un directorio.|
| -r| El archivo existe y el usuario tiene permiso de lectura.|
| -w| El archivo existe y el usuario tiene permiso de escritura.|
| -x| El archivo existe y el usuario tiene permiso de ejecucion.|
| -z| El string tiene longitud 0.|
| -n| El string tiene una longitud mayor a 0.|

#### 8. Estructuras de control. Investigue la sintaxis de las siguientes estructuras de control incluidas en shell scripting:
`if:`
```bash
if [ $1 -gt 10 ]
then
  # Cuerpo para la rama if
  echo "$1 es mas grande que 10"
elif [ $1 -lt 5 ]
then
  # Cuerpo para esta rama elif
  echo "$1 es mas chico que que 5"
else
  # Cuerpo para la rama else
  echo "$1 esta entre 5 y 10"
fi
```
`case:`
```bash
case $1 in
  1)
    echo "Caso 1"
    ;;
  2)
    echo "Caso"
    echo "2"
    ;;
  *)
    echo "Caso desconocido"
    ;;
esac
```
`while & until:`
```bash
i=1
while [ $i -lt 10 ]
do
  echo "Pasada $i"
  let i++
done

until [ $i -lt 1 ]
do
  echo "Pasada $i"
  let i--
done
```
`for:`
```bash
for valor in uno dos tres cuatro cinco seis
do
  echo $valor
done

arreglo=(seis cinco cuatro tres dos uno)
for valor in ${arreglo[*]}
do
  echo $valor
done

for i in {0..32..4}
do 
 echo $i
done
```
`select:`
```bash
select opcion in uno dos salir
do
  #Se ejecuta el case solo si se selecciona una de las opciones disponibles.
  echo $opcion
  case $opcion in
    uno)
      echo "Selecciono la opcion 1!"
      ;;
    dos)
      echo "Selecciono la opcion 2!"
      ;;
    salir)
      echo "Fin del script."
      break
      ;;
  esac
done
```

#### 9. ¿Qué acciones realizan las sentencias break y continue dentro de un bucle? ¿Qué parámetros reciben?
`break [n]` termina el bucle n, por defecto el mas interior.
`continue [n]` salta el resto de la iteracion actual del bucle [n], por defecto el mas interior.

#### 10. ¿Qué tipo de variables existen? ¿Es shell script fuertemente tipado? ¿Se pueden definir arreglos? ¿Cómo?
Existen dos tipos de variables strings y arrays.

Bash no tiene tipado fuerte.

Se pueden definir arreglos de la siguiente manera:
```bash
array=(elemento1 elemento2 elemento3)
```
#### 11. ¿Pueden definirse funciones dentro de un script? ¿Cómo? ¿Cómo se maneja el pasaje de parámetros de una función a la otra?
Se pueden definir funciones y pasarse parametros de la siguiente manera:
```bash
function test {
    echo "Parametro 1: $1"
    echo "Parametro 2: $2"
    echo "Parametro 3: $3"
    return 5 #Termina la ejecucion de la funcion y retorna el exit code 5
}
test $3 $2 $1
echo "La funcion devolvió el código de salida $?"
```
#### 15. Comando cut. El comando cut nos permite procesar la líneas de la entrada que reciba (archivo, entrada estándar, resultado de otro comando, etc) y cortar columnas o campos, siendo posible indicar cual es el delimitador de las mismas. Investigue los parámetros que puede recibir este comando y cite ejemplos de uso.
Los parametros mas importantes de este comando son:

`-d` especifica el delimitador a usar.

`-f` especifica los campos a seleccionar.

Ejemplo:
```bash
#Toma la salida de cat, delimita las columnas por ":" e imprime las primeras tres columnas.
cat /etc/passwd | cut -d":" -f 1,2,3
```
