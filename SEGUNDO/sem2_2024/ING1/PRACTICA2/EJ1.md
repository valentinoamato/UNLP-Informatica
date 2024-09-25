## 1) Alquiler de mobiliario
### HU-1:
#### ID: 
`Cargar mueble.`
#### Titulo:
`Como encargado quiero cargar un mueble para habilitarlo.`
#### Reglas de Negocio:
`- El codigo de inventario del mueble no puede repetirse.`

`- El encargado debe estar autenticado en el sistema.`

#### Criterios de aceptacion:
##### Escenario 1: Alta exitosa.
>**Dado** el codigo de inventario del mueble 1, el cual no fue registrado en el sistema, y que el encargado se encuentra autenticado.
>
>**Cuando** el encargado ingresa los siguientes datos:
>- Codigo: 1.
>- Tipo de mueble: Silla.
>- Fecha de creacion: 10/10/2023.
>- Fecha de ultimo mantenimiento: 20/4/2024.
>- Estado: Libre.
>- Precio: 12USD.
>
> y presiona "Cargar Mueble".
>
>**Entonces** el sistema carga el mobiliario y retorna un resultado de exito.

##### Escenario 2: Alta fallida por codigo de mueble repetido.
>**Dado** el codigo de inventario del mueble 2, el cual ya fue registrado en el sistema, y que el encargado se encuentra autenticado.
>
>**Cuando** el encargado ingresa los siguientes datos:
>- Codigo: 2.
>- Tipo de mueble: Mesa.
>- Fecha de creacion: 11/11/2023.
>- Fecha de ultimo mantenimiento: 21/5/2024.
>- Estado: Libre.
>- Precio: 18USD.
>
> y presiona "Cargar Mueble".
>
>**Entonces** el sistema no carga el mobiliario y retorna un resultado de error informando que el mobiliario ya existe.

### HU-2:
#### ID:
`Realizar reserva.`
#### Titulo:
`Como usuario quiero realizar una reserva para un evento.`
#### Reglas de Negocio:
`- La reserva debe incluir un minimo de 3 muebles.`

#### Criterios de aceptacion:
##### Escenario 1: Reserva exitosa.
>**Dado** que las condiciones son adecuadas para un pago exitoso.
>
>**Cuando** el usuario ingresa los datos solicitados para reservar 3 o mas muebles y realiza el pago correspondiente.
>
>**Entonces** el sistema realiza la reserva y emite el numero de reserva unico.

##### Escenario 2: Alta fallida por minimo de muebles.
>**Dado** que las condiciones son adecuadas para un pago exitoso.
>
>**Cuando** el usuario ingresa los datos solicitados para reservar 2 muebles.
>
>**Entonces** el sistema informa que se deben reservar al menos 3 muebles.

##### Escenario 3: Reserva fallida por error en el pago.
>**Dado** que las condiciones no son adecuadas para un pago exitoso.
>
>**Cuando** el usuario ingresa los datos solicitados para reservar 3 o mas muebles e intenta realizar el pago correspondiente.
>
>**Entonces** el sistema informa que ocurrio un error en el pago y que no se pudo realizar la reserva.

### HU-3:
#### ID:
`Pagar con tarjeta.`
#### Titulo:
`Como usuario quiero pagar con tarjeta para realizar una reserva.`
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

### HU-4:
#### ID:
`Iniciar Sesion.`
#### Titulo:
`Como encargado del mobiliario quiero iniciar sesion para cargar muebles.`

#### Criterios de aceptacion:
##### Escenario 1: Inicio de sesion exitoso.
>**Dado** que el nombre de usuario "JuanManuel" se encuentra registrado con la contraseña "Juan1234".
>
>**Cuando** el encargado de mobiliario ingresa el nombre de usuario "JuanManuel" y la contraseña "Juan1234", y presiona "Iniciar Sesion".
>
>**Entonces** el sistema inicia la sesion del encargado.

##### Escenario 1: Inicio de sesion fallido por credenciales invalidas.
>**Dado** que el nombre de usuario "JuanCarlos" se encuentra registrado con la contraseña "Juan4321
>
>**Cuando** el encargado de mobiliario ingresa el nombre de usuario "JuanCarlos" y la contraseña "Juan4321", y presiona "Iniciar Sesion".
>
>**Entonces** el sistema no inicia la sesion e informa que las credenciales son invalidas.

### HU-5:
#### ID:
`Cerrar sesion.`
#### Titulo:
`Como encargado del mobiliario quiero cerrar sesion para irme a almorzar.`

#### Criterios de aceptacion:
##### Escenario 1: Cierre de sesion exitoso.
>**Dado** un encargado de mobiliario que tiene una sesion iniciada.
>
>**Cuando** el encargado de mobiliario presiona "Cerrar Sesion".
>
>**Entonces** el sistema cierra la sesion del encargado.
