## 6) Biblioteca
### HU-1:
#### ID: 
`Recibir donacion.`
#### Titulo:
`Como bibliotecaria quiero registrar los libros de una donacion para que puedan prestarse.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Registro exitoso.
>**Dado** la informacion de los libros donados.
>
>**Cuando** la biliotecaria ingresa los datos de los nuevos libros y presiona "Registrar".
>
>**Entonces** el sistema registra los nuevos libros.

### HU-2:
#### ID:
`Asociar alumno.`
#### Titulo:
`Como alumno quiero asociarme para pedir libros prestados.`
#### Reglas de Negocio:
`---`


#### Criterios de aceptacion:
##### Escenario 1: Asociacion exitosa.
>**Dado** un alumno que que es alumno regular.
>
>**Cuando** el alumno ingresa el DNI 1234, sube su certificado de alumno regular y presiona "Asociarse".
>
>**Entonces** el sistema crea un nuevo socio, y emite el carnet con el numero de socio correspondiente.

### HU-3:
#### ID:
`Realizar prestamo.`
#### Titulo:
`Como socio habilitado quiero realizar un prestamo para leer libros.`
#### Reglas de  Negocio:
`El socio no puede tener mas de tres prestamos vigentes.`

`El socio no puede tener prestamos vencidos.`

`Los libros a prestar deben estar en buen estado.`

#### Criterios de aceptacion:
##### Escenario 1: Prestamo exitoso.
>**Dado** un socio habilitado con DNI 1234, que no tiene prestamos vigentes ni vencidos y el libro "Las historias de Pepe" que se encuentra en buen estado.
>
>**Cuando** el socio ingresa el DNI 1234 y selecciona el libro "Las historias de Pepe" y presiona "Realizar Prestamo".
>
>**Entonces** el sistema registra la transaccion e informa la fecha de vencimiento del prestamo.

##### Escenario 2: Prestamo fallido por demasiados prestamos vigentes.
>**Dado** un socio habilitado con DNI 1235, que tiene 4 prestamos vigentes, ninguno vencido y el libro "Las historias de Pepe 2" que se encuentra en buen estado.
>
>**Cuando** el socio ingresa el DNI 1235 y selecciona el libro "Las historias de Pepe 2" y presiona "Realizar Prestamo".
>
>**Entonces** el sistema informa que el prestamo no se realizo porque el socio tiene mas de tres prestamos vigentes.

##### Escenario 3: Prestamo fallido por prestamo vencido.
>**Dado** un socio habilitado con DNI 1236, que no tiene prestamos vigentes, pero tiene 1 prestamo vencido y el libro "Las historias de Pepe 3" que se encuentra en buen estado.
>
>**Cuando** el socio ingresa el DNI 1236 y selecciona el libro "Las historias de Pepe 3" y presiona "Realizar Prestamo".
>
>**Entonces** el sistema informa que el prestamo no se realizo porque el socio tiene un prestamo vencido.

##### Escenario 4: Prestamo fallido libro en mal estado.
>**Dado** un socio habilitado con DNI 1237, que no tiene prestamos vigentes, ni vencidos y el libro "Las historias de Pepe 4" que se encuentra en mal estado.
>
>**Cuando** el socio ingresa el DNI 1237 y selecciona el libro "Las historias de Pepe 4" y presiona "Realizar Prestamo".
>
>**Entonces** el sistema informa que el prestamo no se realizo porque el libro se encuentra en mal estado.

### HU-4:
#### ID:
`Retornar libro.`
#### Titulo:
`Como socio quiero retornar un libro para poder pedir otros prestados.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Devolucion exitosa.
>**Dado** el socio con DNI 123 que realizo el prestamo del libro "El retorno de Juan" que se encuentra vigente.
>
>**Cuando** el socio ingresa el DNI 123 y el libro "El retorno de Juan".
>
>**Entonces** el sistema registra la devolucion y emite un comprobante.

##### Escenario 2: Devolucion con plazo vencido.
>**Dado** el socio con DNI 124 que realizo el prestamo del libro "El retorno de Juan 2" que se vencio.
>
>**Cuando** el socio ingresa el DNI 124 y el libro "El retorno de Juan 2".
>
>**Entonces** el sistema registra la devolucion, emite un comprobante y suspende al socio, informandole que no podra realizar prestamos por 15 dias.
