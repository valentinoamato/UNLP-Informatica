## 8) Teatro
### HU-1:
#### ID:
`Reservar entradas.`
#### Titulo:
`Como empleado quiero reservar entradas para un cliente.`
#### Reglas de Negocio:
`Solo se pueden reservar 2 entradas como maximo.`

#### Criterios de aceptacion:
##### Escenario 1: Reserva exitosa.
>**Dado** un cliente con DNI 1 que desea reservar dos entradas para la obra "Juan".
>
>**Cuando** el empleado ingresa los siguietes datos:
>- Fecha de la obra: 1/1/2023.
>- Hora de la obra: 15:35.
>- Nombre de la obra: Juan.
>- Nombre del espectador: Pepe Pepol.
>- DNI del espectador: 1.
>- Cantidad de entradas: 2.
>
>y presiona "Reservar entradas".
>
>**Entonces** el sistema reserva las entradas para el cliente.

##### Escenario 2: Reserva fallida por exceso de entradas.
>**Dado** un cliente con DNI 2 que desea reservar dos entradas para la obra "Saltando".
>
>**Cuando** el empleado ingresa los siguietes datos:
>- Fecha de la obra: 2/1/2023.
>- Hora de la obra: 16:35.
>- Nombre de la obra: Saltando.
>- Nombre del espectador: Juan Pepol.
>- DNI del espectador: 2.
>- Cantidad de entradas: 4.
>
>y presiona "Reservar entradas".
>
>**Entonces** el sistema informa que solo se puede reservar un maximo de 2 entradas.

### HU-2:
#### ID:
`Comprar entradas en linea.`
#### Titulo:
`Como usuario quiero comprar entradas en linea para disfrutar de una obra.`
#### Reglas de Negocio:
`---`


#### Criterios de aceptacion:
##### Escenario 1: Compra exitosa.
>**Dado** el usuario con DNI 1, y que las condiciones son las adecuadas para un pago exitoso.
>
>**Cuando** el usuario selecciona una obra, ingresa el DNI 1, ingresa que desea 5 entradas y presiona "Pagar".
>
>**Entonces** el sistema redirige al usuario al pago con tarjeta de credito, espera respuesta, y emite un codigo de la compra.

##### Escenario 2: Compra fallida por error en el pago.
>**Dado** el usuario con DNI 2, y que las condiciones no son las adecuadas para un pago exitoso.
>
>**Cuando** el usuario selecciona una obra, ingresa el DNI 2, ingresa que desea 6 entradas y presiona "Pagar".
>
>**Entonces** el sistema redirige al usuario al pago co tarjeta de credito, espera respuesta, y informa que ocurrio un error en el pago, por lo que no se pudo llevar a cabo la compra.

### HU-3:
#### ID:
`Pagar con tarjeta.`
#### Titulo:
`Como usuario quiero pagar con tarjeta para comprar entradas.`
#### Reglas de  Negocio:
`Solo se aceptan numeros correspondientes a tarjetas de credito.`

#### Criterios de aceptacion:
##### Escenario 1: Pago exitoso.
>**Dado** que la conexion con el servidor del banco es exitosa, el numero 1234 corresponde a una tarjeta de credito y esta tiene saldo suficiente.
>
>**Cuando** el usuario ingresa los datos de la tarjeta:
>- Numero: 1234.
>- Vencimiento: 12/12/2030.
>- Codigo de seguridad: 332.
>
>y presiona "Pagar".
>
>**Entonces** el sistema registra el pago y retorna un resultado de exito.

##### Escenario 2: Pago fallido por error en la conexion con el servidor del banco.
>**Dado** que no se pudo realizar la conexion con el banco.
>
>**Cuando** el usuario ingresa los datos de la tarjeta:
>- Numero: 1333.
>- Vencimiento: 10/12/2030.
>- Codigo de seguridad: 335.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por conexion fallida con el servidor del banco.

##### Escenario 3: Pago fallido por numero de tarjeta invalido.
>**Dado** que la conexion con el servidor del banco es exitosa y el numero 1239 no corresponde a una tarjeta de credito.
>
>**Cuando** el usuario ingresa los datos de la tarjeta:
>- Numero: 1239.
>- Vencimiento: 15/4/2028.
>- Codigo de seguridad: 235.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por numero de tarjeta inexistente.

##### Escenario 4: Pago fallido por fondos insuficientes.
>**Dado** que la conexion con el servidor del banco es exitosa y el numero 1240 corresponde a una tarjeta de credito que no tiene saldo suficiente.
>
>**Cuando** el usuario ingresa los datos de la tarjeta:
>- Numero: 1240.
>- Vencimiento: 16/4/2028.
>- Codigo de seguridad: 225.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por fondos insuficientes.

### HU-4:
#### ID:
`Comprar entradas presencialmente.`
#### Titulo:
`Como empleado quiero realizar la compra de entradas para un cliente.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Compra exitosa.
>**Dado** el usuario con DNI 1, y que las condiciones son las adecuadas para un pago exitoso.
>
>**Cuando** el empleado ingresa siguientes datos:
>- Obra: "El Renacer".
>- DNI del cliente: 1.
>- Cantidad de entradas: 4.
>
>y presiona "Realizar compra".
>
>**Entonces** el sistema habilita el pago con tarjeta para el cliente en una terminal separada, espera respuesta, e imprime las entradas.

##### Escenario 2: Compra fallida por eror en el pago.
>**Dado** el usuario con DNI 2, y que las condiciones no son las adecuadas para un pago exitoso.
>
>**Cuando** el empleado ingresa siguientes datos:
>- Obra: "El Renacer 2".
>- DNI del cliente: 2.
>- Cantidad de entradas: 6.
>
>y presiona "Realizar compra".
>
>**Entonces** el sistema habilita el pago con tarjeta para el cliente en una terminal separada, espera respuesta, e informa que ocurrio un error en el pago.

### HU-5:
#### ID:
`Retirar entradas reservadas.`
#### Titulo:
`Como empleado quiero realizar el retiro de entradas reservadas para un cliente.`
#### Reglas de Negocio:
`El cliente debe tener entradas reservadas.`

`La reserva no puede estar vencida.`
#### Criterios de aceptacion:
##### Escenario 1: Retiro exitoso.
>**Dado** el cliente con DNI 1 que tiene una reserva vigente de entradas.
>
>**Cuando** el empleado el DNI (1) y nombre (Juan Sulinga) del cliente y presiona "Retirar Entradas".
>
>**Entonces** el sistema registra el retiro de las entradas y las imprime.

##### Escenario 2: Retiro fallido por reserva vencida.
>**Dado** el cliente con DNI 2 que tiene una reserva vencida de entradas.
>
>**Cuando** el empleado el DNI (2) y nombre (Mateo Sulinga) del cliente y presiona "Retirar Entradas".
>
>**Entonces** el sistema informa que la reserva de entradas del cliente se vencio.

##### Escenario 3: Retiro fallido por reserva inexistente.
>**Dado** el cliente con DNI 3 que tiene no tiene una reserva de entradas.
>
>**Cuando** el empleado el DNI (3) y nombre (Carlos Sulinga) del cliente y presiona "Retirar Entradas".
>
>**Entonces** el sistema informa que el cliente no posee ninguna entrada reservada.

### HU-6:
#### ID:
`Retirar entradas compradas.`
#### Titulo:
`Como empleado quiero realizar el retiro de entradas compradas para un cliente.`
#### Reglas de Negocio:
`---`
#### Criterios de aceptacion:
##### Escenario 1: Retiro exitoso.
>**Dado** el codigo de compra 5 que corresponde a una compra de entradas valida.
>
>**Cuando** el empleado ingresa el codigo de compra 5 y presiona "Retirar Entradas".
>
>**Entonces** el sistema registra el retiro de las entradas y las imprime.

##### Escenario 2: Retiro codigo de compra invalido.
>**Dado** el codigo de compra 6 que no corresponde a una compra de entradas valida.
>
>**Cuando** el empleado ingresa el codigo de compra 6 y presiona "Retirar Entradas".
>
>**Entonces** el sistema informa que el codigo de compra ingresado es invalido.

### HU-7:
#### ID:
`Administrar programacion de las salas.`
#### Titulo:
`Como administrador quiero ingresar la distribucion semanal de las obras para vender entradas.`
#### Reglas de Negocio:
`---`
#### Criterios de aceptacion:
##### Escenario 1: Administracion exitosa.
>**Dado** el administrador que posee una distribucion semanal de las obras.
>
>**Cuando** el administrador ingresa la distribucion semanal de las obras en las salas y presiona "Actualizar".
>
>**Entonces** el sistema registra la nueva distribucion y retorna un mensaje de exito.
