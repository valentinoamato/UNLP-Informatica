# Práctica 1 - Introducción


#### 1. ¿Qué es una red? ¿Cuál es el principal objetivo para construir una red?
Una red es un conjunto de computadoras y dispositivos interconectados que pueden comunicarse y compartir recursos.
El principal objetivo es compartir información y recursos (archivos, aplicaciones, impresoras, Internet, etc.) de manera eficiente.

#### 2. ¿Qué es Internet? Describa los principales componentes que permiten su funcionamiento.
Internet es una red mundial de redes interconectadas que utilizan el conjunto de protocolos TCP/IP para comunicarse.
Componentes principales:

Routers: interconectan redes.

Proveedores de Servicios de Internet (ISP): ofrecen acceso a los usuarios.

Servidores: almacenan y brindan servicios (web, correo, DNS, etc.).

Protocolos de comunicación: TCP/IP, HTTP, DNS, entre otros.

#### 3. ¿Qué son las RFCs?
RFC (Request for Comments) son documentos oficiales que describen especificaciones, normas y protocolos de Internet. Sirven como referencia técnica y estándar.

#### 4. ¿Qué es un protocolo?
Es un conjunto de reglas y convenciones que definen cómo dos entidades en una red se comunican y transmiten datos.

#### 5. ¿Por qué dos máquinas con distintos sistemas operativos pueden formar parte de una misma red?
Porque se comunican a través de protocolos estandarizados (ej. TCP/IP), que son independientes del sistema operativo.

#### 6. ¿Cuáles son las 2 categorías en las que pueden clasificarse a los sistemas finales o End Systems? Dé un ejemplo del rol de cada uno en alguna aplicación distribuida que corra sobre Internet.

Clientes: consumen servicios (ejemplo: un navegador accediendo a una página web).

Servidores: ofrecen servicios (ejemplo: un servidor web que entrega páginas HTML).

#### 7. ¿Cuál es la diferencia entre una red conmutada de paquetes de una red conmutada de circuitos?

Conmutada de circuitos: establece un camino dedicado entre emisor y receptor durante toda la comunicación (ej: telefonía tradicional).

Conmutada de paquetes: divide los datos en paquetes que viajan por distintas rutas y se reensamblan al llegar (ej: Internet).

#### 8. Analice qué tipo de red es una red de telefonía y qué tipo de red es Internet.

Red de telefonía: red conmutada de circuitos.

Internet: red conmutada de paquetes.

#### 9. Describa brevemente las distintas alternativas que conoce para acceder a Internet en su hogar.

Fibra óptica: alta velocidad y estabilidad.

Cable coaxial (ISP de TV por cable).

ADSL: por línea telefónica.

Red móvil (4G/5G): acceso mediante redes celulares.

Satélite: usado en zonas rurales.

#### 10. ¿Qué ventajas tiene una implementación basada en capas o niveles?

Simplifica el diseño y la comprensión.

Permite modularidad (cada capa se desarrolla por separado).

Facilita la interoperabilidad entre distintos fabricantes.

Permite actualizaciones en una capa sin afectar a las demás.

#### 11. ¿Cómo se llama la PDU de cada una de las siguientes capas: Aplicación, Transporte, Red y Enlace?
PDU significa Protocol Data Unit (Unidad de Datos de Protocolo).
 Es la forma en la que los datos se representan en cada capa de un modelo de red (OSI o TCP/IP).
Cada capa toma los datos de la capa superior, les agrega su propia cabecera (a veces también un tráiler) y los entrega hacia abajo.

Aplicación → Mensaje

Transporte → Segmento (TCP) / Datagrama (UDP)

Red → Paquete

Enlace → Trama

#### 12. ¿Qué es la encapsulación? Si una capa realiza la encapsulación de datos, ¿qué capa del nodo receptor realizará el proceso inverso?
La encapsulación es el proceso en el que cada capa añade su propia información de control (cabeceras) a los datos de la capa superior.
En el receptor, la capa equivalente (misma capa en el otro extremo) realiza el proceso inverso, llamado desencapsulación.

#### 13. Describa cuáles son las funciones de cada una de las capas del stack TCP/IP o protocolo de Internet.

Aplicación: interacción con el usuario y servicios de red (HTTP, FTP, DNS, etc.).

Transporte: comunicación extremo a extremo, control de errores, confiabilidad (TCP, UDP).

Red: direccionamiento y enrutamiento de paquetes (IP).

Enlace: transmisión física en la red local, control de acceso al medio (Ethernet, Wi-Fi).

#### 14. Compare el modelo OSI con la implementación TCP/IP

Modelo OSI: teórico, de 7 capas (Aplicación, Presentación, Sesión, Transporte, Red, Enlace, Física).

Modelo TCP/IP: práctico, de 4 capas (Aplicación, Transporte, Red, Enlace).

Diferencias:

OSI separa más funciones (ej. presentación y sesión).

TCP/IP es el modelo realmente usado en Internet.
