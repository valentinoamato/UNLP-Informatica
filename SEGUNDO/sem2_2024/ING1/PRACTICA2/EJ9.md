## 9) Pago Electronico.
### HU-1:
#### ID: 
`Realizar pago.`
#### Titulo:
`Como empleado quiero realizar un pago para un cliente.`
#### Reglas de Negocio:
`Si el segundo vencimiento esta vencido no se puede realizar el pago.`

`Si el primer vencimiento esta vencido se aplica un recargo al monto del pago.`
#### Criterios de aceptacion:
##### Escenario 1: Pago exitoso.
>**Dado** un cliente que desea pagar una factura que no se encuentra vencida y que las condiciones estan dadas para recuperar la informacion de la factura de la central de cobros.
>
>**Cuando** el empleado ingresa el codigo de pago 4 y presiona "Realizar pago".
>
>**Entonces** el sistema se conecta con la central de cobros, recupera los datos de la factura, y los muestra para realizar el pago.

##### Escenario 2: Pago con recargo.
>**Dado** un cliente que desea pagar una factura cuyo primer vencimiento se vencio y que las condiciones estan dadas para recuperar la informacion de la factura de la central de cobros.
>
>**Cuando** el empleado ingresa el codigo de pago 5 y presiona "Realizar pago".
>
>**Entonces** el sistema se conecta con la central de cobros, recupera los datos de la factura, aplica un recargo al monto original, y muestra los datos de la factura para realizar el pago.

##### Escenario 3: Pago fallido por factura vencida.
>**Dado** un cliente que desea pagar una factura que cuyo segundo vencimiento se vencio y que las condiciones estan dadas para recuperar la informacion de la factura de la central de cobros.
>
>**Cuando** el empleado ingresa el codigo de pago 6 y presiona "Realizar pago".
>
>**Entonces** el sistema se conecta con la central de cobros, recupera los datos de la factura, e informa que no se puede realizar el pago porque la factura se vencio.

##### Escenario 4: Pago fallido por error de conexion con la central de cobros.
>**Dado** un cliente que desea pagar una factura que no se encuentra vencida y que las condiciones no estan dadas para recuperar la informacion de la factura de la central de cobros.
>
>**Cuando** el empleado ingresa el codigo de pago 7 y presiona "Realizar pago".
>
>**Entonces** el sistema no logra conectarse con la central, e informa que no se puede realizar el pago porque ocurrio un fallo en la conexion con la central.

### HU-2:
#### ID:
`Recuperar datos de factura.`
#### Titulo:
`Como empleado quiero obtener los datos de una factura para que pueda pagarla un cliente.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Recuperacion exitosa.
>**Dado** el codigo de pago 4 que corresponde a una factura, el token 4 que es valido y que las condiciones estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central, y envia le envia el token "4" junto con el codigo de pago "4".
>
>**Entonces** la central verifica el token, busca la informacion de la facutra solicitada y retorna los datos correspondientes.

##### Escenario 2: Recuperacion fallida por token invalido.
>**Dado** el codigo de pago 4 que corresponde a una factura, el token 5 que es invalido y que las condiciones estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central, y envia le envia el token "5" junto con el codigo de pago "4".
>
>**Entonces** la central verifica el token y retorna un error por token invalido.

##### Escenario 3: Recuperacion fallida por codigo de pago invalido.
>**Dado** el codigo de pago 5 que no corresponde a una factura, el token 4 que es valido y que las condiciones estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central, y envia le envia el token "4" junto con el codigo de pago "5".
>
>**Entonces** la central verifica el token, busca la informacion de la facutra solicitada y retorna un error por que el codigo de pago no corresponde a una factura valida.

##### Escenario 4: Recuperacion fallida por fallo de conexion con la central.
>**Dado** el codigo de pago 4 que corresponde a una factura, el token 4 que es valido y que las condiciones no estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central.
>
>**Entonces** el sistema retorna un error por conexion fallida con la central.

### HU-3:
#### ID:
`Registrar pagos.`
#### Titulo:
`Como gerente quiero registrar en la central los pagos realizados por los clientes para que otras sucursales puedan acceder a la informacion.`
#### Reglas de Negocio:
`Solo se pueden registrar los pagos una vez por dia.`

#### Criterios de aceptacion:
##### Escenario 1: Registro exitoso.
>**Dado** la clave maestra "5" que es valida, que no se registraron los pagos previamente en el dia y que las condiciones estan dadas para el envio de datos exitoso a la central.
>
>**Cuando** el gerente ingresa la clave maestra "5" y presiona "Registrar Pagos".
>
>**Entonces** el sistema verifica la clave maestra, envia los datos a la central y esta retorna el exito de la operacion. El sistema registra que ya se enviaron los datos en el dia de la fecha y retorna un mensaje de exito.

##### Escenario 2: Registro fallido por clave maestra invalida.
>**Dado** la clave maestra "6" que no es valida.
>
>**Cuando** el gerente ingresa la clave maestra "6" y presiona "Registrar Pagos".
>
>**Entonces** el sistema verifica la clave maestra, y retorna un error por clave maestra invalida.

##### Escenario 3: Registro fallido por fallo de conexion.
>**Dado** la clave maestra "5" que es valida, que no se registraron los pagos previamente en el dia y que las condiciones no estan dadas para el envio de datos exitoso a la central.
>
>**Cuando** el gerente ingresa la clave maestra "5" y presiona "Registrar Pagos".
>
>**Entonces** el sistema verifica la clave maestra, intenta enviar los datos a la central, y retorna un mensaje error por fallo en el envio de datos a la central.

##### Escenario 4: Registro fallido informacion ya enviada en el dia.
>**Dado** la clave maestra "5" que es valida, que ya se registraron los pagos previamente en el dia y que las condiciones estan dadas para el envio de datos exitoso a la central.
>
>**Cuando** el gerente ingresa la clave maestra "5" y presiona "Registrar Pagos".
>
>**Entonces** el sistema verifica la clave maestra, y reporta un erro por que ya se enviaron los datos de los cobros en el dia de la fecha.

### HU-4:
#### ID:
`Enviar informacion de cobros.`
#### Titulo:
`Como gerente quiero enviar la informacion de los cobros a la central para que quede registrada.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Envio exitoso.
>**Dado** el token 4 que es valido y que las condiciones estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central, y envia le envia el token "4" junto con los informacion de los cobros del dia.
>
>**Entonces** la central verifica el token, registra la informacion recibida y confirma la recepcion de la informacion. El sistema retorna un mensaje de exito.

##### Escenario 2: Envio fallido por fallo en la conexion.
>**Dado** el token 4 que es valido y que las condiciones no estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central.
>
>**Entonces** la conexion no se puede llevar a cabo, el sistema informa el error.

##### Escenario 3: Envio fallido por token invalido.
>**Dado** el token 5 que es invalido y que las condiciones estan dadas para una conexion exitosa con la central.
>
>**Cuando** el sistema solicita la conexion con la central, y envia le envia el token "5" junto con los informacion de los cobros del dia.
>
>**Entonces** la central verifica el token, y retorna que el mismo es invalido. El sistema informa el error.

### HU-5:
#### ID:
`Ver estadisticas.`
#### Titulo:
`Como gerente quiero ver las estadisticas de los los servicios y impuestos cobrados para calcular los ingresos de la sucursal.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Acceso exitoso.
>**Dado** la clave maestra "4" que es valida.
>
>**Cuando** el gerente ingresa la clave maestra "4", un rango de fechas, y presiona "Ver Estadisticas".
>
>**Entonces** el sistema verifica la clave maestra, calcula las estadisticas, y muestra los montos y cantidad de cobros realizados, agrupados por empresa.

##### Escenario 2: Acceso fallido por clave maestra invalida.
>**Dado** la clave maestra "5" que es invalida.
>
>**Cuando** el gerente ingresa la clave maestra "5", un rango de fechas, y presiona "Ver Estadisticas".
>
>**Entonces** el sistema verifica la clave maestra, e informa que la misma es invalida.
