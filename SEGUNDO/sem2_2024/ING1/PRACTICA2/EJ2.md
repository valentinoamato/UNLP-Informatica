## 2) Posgrado
### HU-1:
#### ID: 
`Cargar carrera.`
#### Titulo:
`Como empleado administrativo quiero cargar una carrera al sistema.`
#### Reglas de Negocio:
`- El nombre de la carrera no puede repetirse.`

`- La duracion no puede ser mayor a 5 años.`

#### Criterios de aceptacion:
##### Escenario 1: Carga exitosa.
>**Dado** la carrera con nombre "Medicina" que no ha sido cargada previamente y dura 3 años.
>
>**Cuando** el empleado administrativo ingresa los datos de la carrera:
>- Nombre: Medicina.
>- Duracion: 3 años.
>- Costo: $100.000.
>- Cuotas maximas: 12.
>
>y presiona "Cargar".
>
>**Entonces** el sistema realiza la carga de la carrera y retorna un resultado de exito.

##### Escenario 2: Carga fallida por carrera con duracion muy larga.
>**Dado** la carrera con nombre "Psicologia" que no ha sido cargada previamente y dura 6 años.
>
>**Cuando** el empleado administrativo ingresa los datos de la carrera:
>- Nombre: Psicologia.
>- Duracion: 6 años.
>- Costo: $200.000.
>- Cuotas maximas: 16.
>
>y presiona "Cargar".
>
>**Entonces** el sistema no realiza la carga de la carrera y retorna un resultado de error porque la carrera dura mas de 5 años.

##### Escenario 3: Carga fallida por carrera cargada previamente.
>**Dado** la carrera con nombre "Odontologia" que ya ha sido cargada previamente y dura 4 años.
>
>**Cuando** el empleado administrativo ingresa los datos de la carrera:
>- Nombre: Odontologia.
>- Duracion: 4 años.
>- Costo: $150.000.
>- Cuotas maximas: 8.
>
>y presiona "Cargar".
>
>**Entonces** el sistema no realiza la carga de la carrera y retorna un resultado de error porque el nombre de la carrera ya se encuentra registrado.

### HU-2:
#### ID:
`Registro de alumno.`
#### Titulo:
`Como alumno quiero registrarme en el sistema.`
#### Reglas de Negocio:
`Los nombres de usuario no pueden repetirse.`

`La contraseña debe tener mas de 6 digitos.`

#### Criterios de aceptacion:
##### Escenario 1: Registro exitoso.
>**Dado** que el nombre de usuario "JuanManuel" no se encuentra registrado.
>
>**Cuando** el alumno ingresa el los siguientes datos:
>- Nombre: Juan Manuel.
>- Apellido: Garcia.
>- Nombre de usuario: "JuanManuel".
>- Contraseña: "12345678".
>y presiona "Registrar".
>
>**Entonces** el sistema registra al alumno e informa el exito de la operacion.

##### Escenario 2: Registro fallido por nombre de usuario repetido.
>**Dado** que el nombre de usuario "JuanCarlos" ya se encuentra registrado.
>
>**Cuando** el alumno ingresa los siguientes datos:
>- Nombre: Juan Carlos.
>- Apellido: Perez.
>- Nombre de usuario: "JuanCarlos".
>- Contraseña: "87654321".
>y presiona "Registrar".
>
>**Entonces** el sistema no registra al alumno e informa que nombre de usuario ya se encuentra registrado.

##### Escenario 3: Registro fallido por contraseña demasiado corta.
>**Dado** que el nombre de usuario "PedroJ" no se encuentra registrado.
>
>**Cuando** el alumno ingresa el los siguientes datos:
>- Nombre: Pedro.
>- Apellido: Jimenez.
>- Nombre de usuario: "PedroJ".
>- Contraseña: "12345".
>y presiona "Registrar".
>
>**Entonces** el sistema no registra al alumno e informa que la contraseña debe tener mas de 6 digitos.

### HU-3:
#### ID:
`Inicio de sesion.`
#### Titulo:
`Como alumno quiero iniciar sesion en el sistema para inscribirme en una carrera.`
#### Reglas de Negocio:
`El alumno debe estar registrado.`

#### Criterios de aceptacion:
##### Escenario 1: Inicio de sesion exitoso.
>**Dado** un alumno que se encuentra registrado en el sistema.
>
>**Cuando** el usuario ingresa sus credenciales y presiona "Iniciar Sesion".
>
>**Entonces** el sistema inicia la sesion del alumno.

##### Escenario 2: Inicio de sesion fallido por credenciales invalidas.
>**Cuando** un usuario ingresa credenciales invalidas y presiona "Iniciar Sesion".
>
>**Entonces** el sistema informa que las credenciales no corresponden a un alumno registrado.

### HU-4:
#### ID:
`Cerrar sesion.`
#### Titulo:
`Como alumno quiero cerrar mi sesion actual para que otro alumno pueda iniciar sesion.`

#### Criterios de aceptacion:
##### Escenario 1: Cierre de sesion exitoso.
>**Dado** un alumno que tiene una sesion abierta en el sistema.
>
>**Cuando** el alumno presiona "Cerrar Sesion".
>
>**Entonces** el sistema cierra la sesion del alumno.

### HU-5:
#### ID:
`Inscripcion a carrera.`
#### Titulo:
`Como alumno quiero inscribirme a una carrera para cursarla.`

#### Criterios de aceptacion:
##### Escenario 1: Inscripcion exitosa.
>**Dado** las condiciones para un pago exitoso y un alumno que inicio sesion en el sistema.
>
>**Cuando** el alumno selecciona  la carrera "Odontologia", ingresa la cantidad de cuotas a pagar (5) e ingresa el numero de tarjeta de credito (1234). Luego presiona el boton "Realizar Inscripcion".
>
>**Entonces** el sistema realiza el cobro y la inscripcion, e imprime dos comprobantes respectivamente.

##### Escenario 2: Inscripcion fallida por error en el pago.
>**Dado** un alumno que inicio sesion en el sistema y las condiciones no son las adecuadas para un pago exitoso.
>
>**Cuando** el alumno selecciona  la carrera "Veterinaria", ingresa la cantidad de cuotas a pagar (8) e ingresa el numero de tarjeta de credito (9876). Luego presiona el boton "Realizar Inscripcion".
>
>**Entonces** el sistema informa que la inscripcion no se llevo a cabo por un fallo en el pago.

### HU-6:
#### ID:
`Pagar con tarjeta.`
#### Titulo:
`Como usuario quiero pagar con tarjeta para inscribirme a una carrera.`
#### Reglas de Negocio:
`Solo se aceptan numeros correspondientes a tarjetas de credito.`

#### Criterios de aceptacion:
##### Escenario 1: Pago exitoso.
>**Dado** que la conexion con el servidor del banco es exitosa, el numero 1234 corresponde a una terketa de credito y la tarjeta tiene saldo suficiente.
>
>**Cuando** el usuario ingresa el numero de tarjeta 1234 y presiona "Pagar".
>
>**Entonces** el sistema registra el pago y retorna un resultado de exito.

##### Escenario 2: Pago fallido por numero de tarjeta de credito inexistente.
>**Dado** que la conexion con el servidor del banco es exitosa y el numero 3456 no corresponde a un numero de tarjeta de credito.
>
>**Cuando** el usuario ingresa el numero de la tarjeta 3456 y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por numero de tarjeta inexistente.

##### Escenario 3: Pago fallido saldo insuficiente de tarjeta de credito.
>**Dado** que la conexion con el servidor del banco es exitosa y el numero de tarjeta 2134 corresponde a una tarjeta de credito y no tiene saldo suficiente.
>
>**Cuando** el usuario ingresa el numero de tarjeta 2134 y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por saldo insuficiente.

##### Escenario 4: Pago fallido por fallo en la conexion con el servidor externo del banco.
>**Dado** que no se pudo realizar la conexion con el servidor del banco.
>
>**Cuando** el usuario ingresa un numero de tarjeta y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por conexion fallida.
