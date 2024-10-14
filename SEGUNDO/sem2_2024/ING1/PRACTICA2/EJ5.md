## 5) Casa de fotografia
### HU-1:
#### ID: 
`Registrar persona.`
#### Titulo:
`Como persona quiero registrarme en el sistema para comprar subir fotos.`

#### Criterios de aceptacion:
##### Escenario 1: Registro exitoso.
>**Cuando** la persona ingresa los siguientes datos:
>- Nombre: Juan Carlos.
>- Apellido: Cuchau.
>- Mail: juancarlos@gmail.com.
>- Domicilio: 16 e35 y 36, N1234.
>- Nombre de usuario: Juancarlos.
>- Contraseña: juancarlos123.
>y presiona "Registrar".
>
>**Entonces** el sistema registra el usuario y informa un mensaje de exito.

### HU-2:
#### ID:
`Inicio de sesion.`
#### Titulo:
`Como usuario registrado quiero iniciar sesion para subir fotos.`
#### Reglas de Negocio:
`El usuario debe estar registrado.`

#### Criterios de aceptacion:
##### Escenario 1: Inicio de sesion exitoso.
>**Dado** un usuario que se encuentra registrado en el sistema.
>
>**Cuando** el usuario ingresa sus credenciales y presiona "Iniciar Sesion".
>
>**Entonces** el sistema inicia la sesion del usuario.

##### Escenario 2: Inicio de sesion fallido por credenciales invalidas.
>**Cuando** un usuario ingresa credenciales invalidas y presiona "Iniciar Sesion".
>
>**Entonces** el sistema informa que las credenciales no corresponden a un usuario registrado.

### HU-3:
#### ID:
`Cerrar sesion.`
#### Titulo:
`Como usuario quiero cerrar mi sesion actual.`

#### Criterios de aceptacion:
##### Escenario 1: Cierre de sesion exitoso.
>**Dado** un usuario que tiene una sesion abierta en el sistema.
>
>**Cuando** el usuario presiona "Cerrar Sesion".
>
>**Entonces** el sistema cierra la sesion del usuario.

### HU-4:
#### ID:
`Subir fotos.`
#### Titulo:
`Como usuario quiero subir fotos para luego imprimirlas.`
#### Reglas de Negocio:
`Se pueden subir 50 fotos como maximo.`

#### Criterios de aceptacion:
##### Escenario 1: Subida exitosa.
>**Dado** un usuario que inicio sesion.
>
>**Cuando** el usuario ingresa 40 fotos y presiona "Subir".
>
>**Entonces** el sistema registra las fotos correctamente y redirige al usuario al pago.

##### Escenario 2: Subida fallida por demasiadas fotos ingresadas.
>**Dado** un usuario que inicio sesion.
>
>**Cuando** el usuario ingresa 51 fotos y presiona "Subir".
>
>**Entonces** el sistema no registra las fotos y informa al usuario que el maximo de fotos es 50.

### HU-5:
#### ID:
`Pagar con tarjeta.`
#### Titulo:
`Como usuario quiero pagar con tarjeta para imprimir mis fotos.`
#### Reglas de Negocio:
`Solo se aceptan numeros correspondientes a tarjetas de credito.`

#### Criterios de aceptacion:
##### Escenario 1: Pago exitoso.
>**Dado** que la conexion con el servidor del banco es exitosa, el numero 1234 corresponde a una terketa de credito y la tarjeta tiene saldo suficiente.
>
>**Cuando** el usuario ingresa el numero de tarjeta 1234 y presiona "Pagar".
>
>**Entonces** el sistema registra el pago, retorna un resultado de exito y otorga al cliente un codigo unico para retirar las fotos.

##### Escenario 2: Pago fallido por numero de tarjeta de credito inexistente.
>**Dado** que la conexion con el servidor del banco es exitosa y el numero 3456 no corresponde a un numero de tarjeta de credito.
>
>**Cuando** el usuario ingresa el numero de la tarjeta 3456 y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por numero de tarjeta inexistente.

##### Escenario 3: Pago fallido por saldo insuficiente de tarjeta de credito.
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

### HU-6:
#### ID:
`Registrar codigo unico de encargo.`
#### Titulo:
`Como empleado quiero registrar un codigo unico de encargo para estar al tanto de pedidos pendientes y retirados.`

#### Criterios de aceptacion:
##### Escenario 1: Registro de codigo exitoso.
>**Dado** un codigo unico de encargo, 34, que existe.
>
>**Cuando** el empleado ingresa el codigo 34 y la fecha de retiro 4/8/2023.
>
>**Entonces** el sistema registra el retiro y le informa al empleado las fotos que debe entregar.

##### Escenario 2: Registro de codigo fallido por codigo inexistente.
>**Dado** un codigo unico de encargo, 35, que no corresponde a un pedido pendiente valido.
>
>**Cuando** el empleado ingresa el codigo 35 y la fecha de retiro 5/9/2024.
>
>**Entonces** el sistema informa que el codigo no corresponde a un pedido pendiente de retiro.
