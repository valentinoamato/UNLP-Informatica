## Práctica 2 - Capa de Aplicacion HTTP

#### 1) ¿Cuál es la función de la capa de aplicación
La capa de aplicacion es la capa donde resideen los programas de red que usan los usuarios y donde se definen los protocolos (HTTP, DNS, SMTP, etc) que permiten que estos programas se comuniquen entre si.

#### 2) Si dos procesos deben comunicarse:
##### a) ¿Cómo podrían hacerlo si están en diferentes máquinas
Si estan en diferentes maquinas la comunicacion se realiza mediante el uso de sockets, que permite intercambar datos de manera fiable y ordenada. El socket funciona como una API entre la aplicacion y la red.

##### b) Y si están en la misma máquina, ¿qué alternativas existen?
Si los procesos estan en la misma maquina no es necesario usar sockets, en cambio se pueden usar otros mecanismos de comunicacion como memoria compartida, colas de mensajes u otros mecanismos propios del OS.

#### 3) Explique brevemente cómo es el modelo Cliente/Servidor. Dé un ejemplo de un sistema Cliente/Servidor en la “vida cotidiana” y un ejemplo de un sistema informático que siga el modelo Cliente/Servidor. ¿Conoce algún otro modelo de comunicación?
En el modelo cliente/servidor el cliente inicia la comunicacion con el servidor, mientras que este ultimo permanece en espera de dicha comunicacion. El servidor procesa la solicitud del cliente y le responde. 

Ejemplo de la vida cotidiana: Pedirle a un mozo un platillo en un restaurante. Ejemplo de un sistema informatico: Visita a una pagina web.

Otro modelo de comunicacion es P2P donde cada nodo actua como cliente y servidor.

#### 4) Describa la funcionalidad de la entidad genérica “Agente de usuario” o “User agent”.
El User Agent es la interfaz entre el usuario y el sistema de correo electronico. Provee servicios como componer, editar y leer mensajes de correo electronico.

#### 5) ¿Qué son y en qué se diferencian HTML y HTTP?
HTTP (HyperText Transfer Protocol): Protocolo de aplicacion que define como un cliente y un servidor intercambian mensajes.

HTML (HyperText Markup Language): Define el formato de un documento, la estructura del contenido que HTTP transporta. Lenguaje de formato de contenido.

#### 6. HTTP tiene definido un formato de mensaje para los requerimientos y las respuestas.
##### a. ¿Qué información de la capa de aplicación nos indica si un mensaje es de requerimiento o de respuesta para HTTP? ¿Cómo está compuesta dicha información?¿Para qué sirven las cabeceras?
Los mensajes HTTP consisten de una linea de inicio, lineas de cabecera, una linea en blanco y a veces un cuerpo:
1. Start-line
2. Headers
3. Blank line
4. Optional Body

Los mensajes de requerimiento comienzan con una request line, por ejemplo:
```
GET /index.html HTTP/1.1
```
Los mensajes de respuesta comienzan con una status line, por ejemplo:
```
HTTP/1.1 200 OK
```
Los headers sirven para transmitir informacion adicional de control para que el cliente y servidor manejen correctamente la peticion o respuesta.
##### b. ¿Cuál es su formato?
En general los headers tienen el siguiente formato:
```
Nombre-Header: valor
```
##### c. Suponga que desea enviar un requerimiento con la versión de HTTP 1.1 desde curl/7.74.0 a un sitio de ejemplo como www.misitio.com para obtener el recurso /index.html. En base a lo indicado, ¿qué información debería enviarse mediante encabezados? Indique cómo quedaría el requerimiento.
```
GET /index.html HTTP/1.1
Host: www.misitio.com
User-Agent: curl/7.74.0
Connection: close
```

#### 7. Utilizando la VM, abra una terminal e investigue sobre el comando curl. Analice para qué
sirven los siguientes parámetros (-I, -H, -X, -s).
Curl es una herramienta para tranferir informacion desde o hacia un servidor, usando disintos protocolos soportados (FTP, HTTP, HTTPS, SMTP, etc).
Soporta los siguientes parametros:
1. `-I`: Envia una peticion HEAD, no descarga el cuerpo del recurso.
2. `-H`: Permite agregar headers HTTP manualmente a la request.
3. `-X`: Fuerza el uso de un metodo HTTP diferente (Ej. GET, POST, PUT, DELETE, etc)
4. `-s`: Modo silencioso. No muestra barra de progreso ni errores.
5. `-v`: Modo verboso.

#### 8. Ejecute el comando curl sin ningún parámetro adicional y acceda a www.redes.unlp.edu.ar. Luego responda:
##### a. ¿Cuántos requerimientos realizó y qué recibió? Pruebe redirigiendo la salida (>) del comando curl a un archivo con extensión html y abrirlo con un navegador.
Al realizar un requerimiento, se recibe el codigo HTML de la pagina.

Cuando se redirecciona la salida a un archivo, se pueden ver en el terminal estadisticas sobre la request. Al abrir este archivo en el navegador se renderiza la pagina.
##### b. ¿Cómo funcionan los atributos href de los tags link e img en html?
Los atributos `href` funcionan como URLs que apuntan a recursos externos (CSS, imagenes, etc.). EL navegador los interpreta y realiza nuevos requerimientos para obtener cada uno.
##### c. Para visualizar la página completa con imágenes como en un navegador,¿alcanza con realizar un único requerimiento?
No, no alcanza. El navegador necesita hacer requerimientos adicionales para los recursos externos.
##### d. ¿Cuántos requerimientos serían necesarios para obtener una página que tiene dos CSS, dos Javascript y tres imágenes? Diferencie cómo funcionaría un navegador respecto al comando curl ejecutado previamente.
Serian necesarios:
- CSS: 2
- JS: 2
- Imagenes: 3

El navegador realiza estos requerimientos adicionales de forma automatica mientras que curl no.

#### 9. Ejecute a continuación los siguientes comandos:
```bash
curl -v -s www.redes.unlp.edu.ar > /dev/null
curl -I -v -s www.redes.unlp.edu.ar
```
##### a. ¿Qué diferencias nota entre cada uno?
En el primero se obtiene el cuerpo del documento, pero de descarta con la redireccion. En la segunda se hace una request HEAD y no se obtiene el cuerpo, solo cabeceras.
##### b. ¿Qué ocurre si en el primer comando se quita la redirección a /dev/null? ¿Por qué no es necesaria en el segundo comando?
Si se quita la redireccion se imprimiran los headers y el HTML completo de la pagina. En el segundo no es necesario porque el argumento `-I` realiza una request HEAD.
##### c. ¿Cuántas cabeceras viajaron en el requerimiento? ¿Y en la respuesta?
En el requerimiento viajaron 3 cabeceras (La primera linea es la request line):
```
> GET / HTTP/1.1
> Host: www.redes.unlp.edu.ar
> User-Agent: curl/7.74.0
> Accept: */*
```
Y en la respuesta viajaron 7 cabeceras (La primera es la status line):
```
< HTTP/1.1
< Date: ...
< Server: ...
< Last-Modified: ...
< ETag: ...
< Accept-Ranges: bytes
< Content-Length: 4898
< Content-Type: text/html
```
En ambos casos la primera linea es la start line, no un header.

#### 10. ¿Qué indica la cabecera Date?
La cabecera `Date` indica la fecha y hora en que el servidor genero la respuesta HTTP.

#### 11. En HTTP/1.0, ¿cómo sabe el cliente que ya recibió todo el objeto solicitado de manera completa? ¿Y en HTTP/1.1?
En HTTP/1.0 no hay conexiones persistentes por defecto, asi que el cliente save que termino de recibir el objeto cuando el servidor cierra la conexion TCP.

En HTTP/1.0 existen conexiones persistentes, por lo que el servidor no cierra la conexion al terminar. El cliente debe saber el final del objeto usando:
- `Content-Length`: Con este header el cliente sabe cuantos bytes recibir
- `Transfer-Encoding: chunked`: Permite que dividir la respuesta en pequeñas piezas sin necesidad de conocer el tamaño total con anterioridad. Se termina la transmision cuando se recibe un chunk de tamaño 0.

#### 12. Investigue los distintos tipos de códigos de retorno de un servidor web y su significado. Considere que los mismos se clasifican en categorías (2XX, 3XX, 4XX, 5XX)
Los codigos de estado HTTP se agrupan por categorias segun su primer digito:
- 1XX: Respuestas informativas.
- 2XX: Exito.
    - `200 OK`: La request fue exitosa.
    - `201 Created`: La request fue exitosa y como resultado se a creado un recurso.
    - `204 No Content`: Operacion exitosa sin cuerpo de respuesta.
- 3XX: Mensajes de redireccion.
    - `301 Moved Permanently`: El recurso fue movido permanentemente.
    - `302 Found`: Redireccion temporal.
    - `304 Not Modified`: El recurso no cambio; usar copia en cache.
- 4XX: Error del cliente.
    - `400 Bad Request`: Requerimiento mal formado.
    - `401 Unauthorized`: Requiere autenticacion.
    - `403 Forbidden`: El cliente no tiene permiso de acceder al recurso.
    - `404 Not Found`: El recurso solicitado no se encontro o no existe.
- 5XX: Error del servidor.
    - `500 Internal Server Error`: Error generico del servidor.
    - `502 Bad Gateway`: El servidor (proxy), recibio una respuesta invalida del servidor ascendente.
    - `503 Service Unavailable`: Servidor temporalmente no disponible.
    - `504 Gateway Timeout`: El servidor (proxy) no obtubo una respuesta a tiempo del upstream.

#### 13. Utilizando curl, realice un requerimiento con el método HEAD al sitio www.redes.unlp.edu.ar e indique:
##### a. ¿Qué información brinda la primera línea de la respuesta?
La primera linea de la respuesta muestra la status line:
```
HTTP/1.1 200 OK
```
##### b. ¿Cuántos encabezados muestra la respuesta?
Se muestran 7 encabezados:
- Date
- Server
- Last-Modified
- ETag
- Accept-Ranges
- Content-Length
- Content-Type
##### c. ¿Qué servidor web está sirviendo la página?
Apache/2.4.56
##### d. ¿El acceso a la página solicitada fue exitoso o no?
Si, fue exitoso.
##### e. ¿Cuándo fue la última vez que se modificó la página?
Sun, 19 Mar 2023 19:04:46 GMT
##### f. Solicite la página nuevamente con curl usando GET, pero esta vez indique que quiere obtenerla sólo si la misma fue modificada en una fecha posterior a la que efectivamente fue modificada. ¿Cómo lo hace? ¿Qué resultado obtuvo? ¿Puede explicar para qué sirve?
Para hacer esta request, se usa el header `If-Modified-Since`:
```
curl -H "If-Modified-Since: Mon, 20 Mar 2023 00:00:00 GMT" http://www.redes.unlp.edu.ar/
```
Esto sirve para evitar descargar un recurso si no fue modificado. Es una optimizacion tipica que permite reducir el trafico, el uso del servidor y acelerar la carga de paginas.

#### 14. Utilizando curl, acceda al sitio www.redes.unlp.edu.ar/restringido/index.php y siga las instrucciones y las pistas que vaya recibiendo hasta obtener la respuesta final. Será de utilidad para resolver este ejercicio poder analizar tanto el contenido de cada página como los encabezados.
1. Al hacer una request a la pagina esta responde con un 401, y en el body nos sugiere visitar `www.redes.unlp.edu.ar/obtener-usuario.php`.
2. En esta nueva pagina nos recomienda hacer una request con un header particular:
```
curl -H "Usuario-Redes: obtener" www.redes.unlp.edu.ar/obtener-usuario.php
```
En la respuesta se nos informa un usuario y contraseña ("redes", "RYC", e instrucciones.

3. Repitiendo la primera request con los headers adecuados:
Primero codificamos las claves en base64:

```
"redes:RYC" = "cmVkZXM6UllD"
```
Y luego hacemos la request con el header correspondiente:
```
curl -v -H "Authorization: Basic cmVkZXM6UllD" www.redes.unlp.edu.ar/restringido/index.php
```
Y como respuesta obtenemos un 302 y el enlace a una nueva pagina.

4. Hacemos una request a esta pagina:
```
curl -v -H "Authorization: Basic cmVkZXM6UllD" www.redes.unlp.edu.ar/restringido/the-end.php
```
Y esta nos responde que llegamos al fin del ejercicio.

#### 15. Utilizando la VM, realice las siguientes pruebas:
##### a. Ejecute el comando ’curl www.redes.unlp.edu.ar/extras/prueba-http-1-0.txt’ y copie la salida completa (incluyendo los dos saltos de línea del final).
```
GET /http/HTTP-1.1/ HTTP/1.0
User-Agent: curl/7.38.0
Host: www.redes.unlp.edu.ar
Accept: */*


```
##### b. Desde la consola ejecute el comando telnet www.redes.unlp.edu.ar 80 y luego pegue el contenido que tiene almacenado en el portapapeles. ¿Qué ocurre luego de hacerlo?
Se realiza una request a la pagina usando HTTP/1.0, el servidor responde inmediatamente y luego cierra la conexion ya que HTTP/1.0 no usa conexiones persistentes.
##### c. Repita el proceso anterior, pero copiando la salida del recurso /extras/prueba-http-1-1.txt. Verifique que debería poder pegar varias veces el mismo contenido sin tener que ejecutar el comando telnet nuevamente
Ahora se hace la misma request pero usando HTTP/1.1, esto hace que el servidor mantenga la conexion abierta luego de responder.

#### 16. En base a lo obtenido en el ejercicio anterior, responda:
##### a. ¿Qué está haciendo al ejecutar el comando telnet?
Esta abriendo una conexion TCP al servidor `www.redes.unlp.edu.ar` en el puerto 80, y luego enviando manualmente una request HTTP al pegar el texto.
##### b. ¿Qué método HTTP utilizó? ¿Qué recurso solicitó?
Se utilizo el metodo `GET`. El recurso solicitado fue `http://www.redes.unlp.edu.ar/http/HTTP-1.1/`.
##### c. ¿Qué diferencias notó entre los dos casos? ¿Puede explicar por qué?
En el primer caso al pegar el texto, se hace la request, se obtiene la respuesta y se cierra la conexion. Si se desea hacer otra request se debe volver a ejecutar `telnet`. En cambio en el segundo caso, al pegar el texto, se hace la request y se obtiene la respuesta, pero la conexion no se cierra, lo que permite seguir haciendo requerimientos sin necesidad de volver a ejecutar `telnet`.

Esto se debe a que en el primer caso usamos `HTTP/1.0` que no soporta conexiones persistentes, mientras que en el segundo caso usamos `HTTP/1.1`, que si las soporta.
##### d. ¿Cuál de los dos casos le parece más eficiente? Piense en el ejercicio donde analizó la cantidad de requerimientos necesarios para obtener una página con estilos, javascripts e imágenes. El caso elegido, ¿puede traer asociado algún problema?
En general `HTTP/1.1` es mas eficiente ya que permite realizar varios requerimientos en una misma conexion. En en ejercicio mencionado si se usara `HTTP/1.0` se deberian abrir y cerrar 8 conexiones.

El problema que puede traer `HTTP/1.1` es que conexiones mas largas ocupan recursos del servidor, muchos clientes con conexiones persistentes pueden agotar el pool de conexiones del servidor.

#### 17. En el siguiente ejercicio veremos la diferencia entre los métodos POST y GET. Para ello, será necesario utilizar la VM y la herramienta Wireshark.
##### a. Abra un navegador e ingrese a la URL: www.redes.unlp.edu.ar e ingrese al link en la sección “Capa de Aplicación” llamado “Métodos HTTP”. En la página mostrada se visualizan dos nuevos links llamados: Método GET y Método POST.
`-`
##### b. Analice el código HTML
Ambas paginas contienen principal mente un formulario, la diferencia entre ellas es el metodo de dicho formulario:
```html
<form method="GET" action="metodos-lectura-valores.php">
<form method="POST" action="metodos-lectura-valores.php">
```
##### c. Utilizando el analizador de paquetes Wireshark capture los paquetes enviados y recibidos al presionar el botón Enviar.
`-`
##### d. ¿Qué diferencias detectó en los mensajes enviados por el cliente?
###### GET:
- Los datos del formulatio viajan en la URL de la request: `GET /http/metodos-lectura-valores.php?form_nombre=Nombre+Get&form_apellido=Apellido+Get&...`
- No hay cuerpo (body) en el mensaje
- No hay cabeceras como `Content-Type` ni `Content-Length`
###### POST:
- La url no contiene los datos: `POST /http/metodos-lectura-valores.php HTTP/1.1`
- Los datos del formulario se envian en el cuerpo del mensaje.
- El cliente envia los headers `Content-Type` y `Content-Length`
asdads
##### e. ¿Observó alguna diferencia en el browser si se utiliza un mensaje u otro?
No, la respuesta es la misma.

#### 18. Investigue cuál es el principal uso que se le da a las cabeceras Set-Cookie y Cookie en HTTP y qué relación tienen con el funcionamiento del protocolo HTTP.
Una cookie es un pequeño archivo de texto emitido por un sitio web y almacenada en el navegador del usuario, que contiene informacion sobre la actividad del usuario en el mismo sitio web.

- `Set-Cookie` (Servidor -> Cliente): El servidor la usa para crear una cookie en el navegador y asociarla a una sesion, preferencias, autenticacion, etc.
```
Set-Cookie: session_id=abc123; Path=/; Expires=...
```
- `Cookie` (Cliente -> Servidor): El cliente envia la cookie al servidor.
```
Cookie: session_id=abc123
```
Como el protocolo HTTP es sin estado, las cookies permiten mantener estado, jugando un rol fundamental en sesiones de usuario, autenticacion, persistencia de preferencias, etc.
#### 19. ¿Cuál es la diferencia entre un protocolo binario y uno basado en texto? ¿De qué tipo de protocolo se trata HTTP/1.0, HTTP/1.1 y HTTP/2?
Basado en texto (`HTTP/1.0`,`HTTP/1.1`):
- Los mensajes estan formados por texto legible (ASCII/UTF-8)
- Facil de leer y depurar
- Menos eficiente en tamaño
Binario (`HTTP/2.0`):
- Los mensajes usan un formato compacto y legible por maquina
- Mas eficiente, menor tamaño y mejor rendimiento
- Se necesita de herramientas especiales para inspeccionarse
#### 20. Responder las siguientes preguntas:
##### a. ¿Qué función cumple la cabecera Host en HTTP 1.1? ¿Existía en HTTP 1.0? ¿Qué sucede en HTTP/2?
`Host`: Identifica a que sitio virtual dentro del mismo servidor se esta solicitando.
Ejemplo:
```
Host: www.redes.unlp.edu.ar
```
No existe en `HTTP/1.0`. En `HTTP/1.1` es obligatoria.

En `HTTP/2.0` no se usa, el equivalente es el pseudo-header:
```
:authority: www.redes.unlp.edu.ar
```

##### b. En HTTP/1.1, ¿es correcto el siguiente requerimiento?
```
GET /index.php HTTP/1.1
User-Agent: curl/7.54.0
```
No es correcto, ya que falta el header `Host`.

##### c. ¿Cómo quedaría en HTTP/2 el siguiente pedido realizado en HTTP/1.1 si se está usando https?
```
GET /index.php HTTP/1.1
Host: www.info.unlp.edu.ar
```
Version `HTTP/2.0` con pseudo-headers:
```
:method: GET
:path: /index.php
:scheme: https
:authority: www.info.unlp.edu.ar
```

#### Ejercicio de Parcial
```
$ curl -X ?? www.redes.unlp.edu.ar/??
> HEAD /metodos/ HTTP/??
> Host: www.redes.unlp.edu.ar
> User-Agent: curl/7.54.0

< HTTP/?? 200 OK
< Server: nginx/1.4.6 (Ubuntu)
< Date: Wed, 31 Jan 2018 22:22:22 GMT
< Last-Modified: Sat, 20 Jan 2018 13:02:41 GMT
< Content-Type: text/html; charset=UTF-8
< Connection: close
```

##### a. ¿Qué versión de HTTP podría estar utilizando el servidor?
El servidor podria estar usando `HTTP/1.0` o `HTTP/1.1`.
##### b. ¿Qué método está utilizando? Dicho método, ¿retorna el recurso completo solicitado?
Esta utilizando el metodo `HEAD`, este metodo solo devuelve los headers, no el cuerpo.
##### c. ¿Cuál es el recurso solicitado?
El recurso solicitado es `/metodos/`.
##### d. ¿El método funcionó correctamente?
Si, ya que la codigo de respuesta es `200 OK`.
##### e. Si la solicitud hubiera llevado un encabezado que diga:
```
If-Modified-Since: Sat, 20 Jan 2018 13:02:41 GMT
```
##### ¿Cuál habría sido la respuesta del servidor web? ¿Qué habría hecho el navegador en este caso?
En este caso la respuesta tendria el statud code `304 Not Modified` y el navegador utilizaria la copia en cache.
