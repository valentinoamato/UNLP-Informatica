## 12-A) Creditos Bancarios.
### Historias de uso:
`- Iniciar tramite.`

`- Consultar estado de tramite.`

`- Pedir listado.`
### HU-1:
#### ID:
`Iniciar tramite.`
#### Titulo:
`Como cliente del banco quiero iniciar un tramite para pedir un credito.`
#### Reglas de Negocio:
`El monto del credito solicitado no puede superar los $400.000.`

#### Criterios de aceptacion:
##### Escenario 1: Inicio de tramite exitoso.
>**Dado** el DNI 1234 que corresponde a un cliente del banco.
>
>**Cuando** el cliente ingresa los siguientes datos:
> - DNI: 1234.
> - Nombre: Juan Maria.
> - Apellido: Tevez.
> - Correo electronico: juanmaria@gmail.com.
> - Tipo de credito: Personal.
> - Monto: $150.000.
>
> y presiona "Iniciar tramite.".
>
>**Entonces** el sistema almacena el tramite e imprime un numero de comprobante para el cliente.

##### Escenario 2: Inicio de tramite fallido por DNI invalido.
>**Dado** el DNI 1235 que no corresponde a un cliente del banco.
>
>**Cuando** el cliente ingresa los siguientes datos:
> - DNI: 1235.
> - Nombre: Juan Carlos.
> - Apellido: Garcia.
> - Correo electronico: juancarlos@gmail.com.
> - Tipo de credito: Personal.
> - Monto: $110.000.
>
> y presiona "Iniciar tramite.".
>
>**Entonces** el sistema informa que el DNI ingresado no corresponde a un cliente del banco, y envia al correo electronico ingresado un instructivo para hacerse cliente del banco.

##### Escenario 3: Inicio de tramite fallido monto excesivo.
>**Dado** el DNI 1236 que corresponde a un cliente del banco.
>
>**Cuando** el cliente ingresa los siguientes datos:
> - DNI: 1236.
> - Nombre: Juan Ignacio
> - Apellido: Jaime.
> - Correo electronico: juanignacio@gmail.com.
> - Tipo de credito: Vivienda.
> - Monto: $435.000.
>
> y presiona "Iniciar tramite.".
>
>**Entonces** el sistema informa el siguiente mensaje de error: "El monto solicitado excede el limite permitido".

### HU-2:
#### ID:
`Consultar estado de tramite.`
#### Titulo:
`Como cliente del banco quiero consultar el estado de un tramite para seguir la solicitud de mi credito.`
#### Reglas de Negocio:
`Solo se permiten tres consultas invalidas por dia.`

#### Criterios de aceptacion:
##### Escenario 1: Consulta exitosa.
>**Dado** el numero de comprobante 5, que es valido y corresponde a un tramite; y un cliente que no ha realizado consultas en el dia.
>
>**Cuando** el cliente ingresa el numero de comprobante 5 y presiona "Realizar consulta".
>
>**Entonces** el sistema retorna un informe con el estado del tramite correspondiente.

##### Escenario 2: Consulta fallida por comprobante invalido.
>**Dado** el numero de comprobante 6, que es invalido y no corresponde a un tramite; y un cliente que no ha realizado consultas en el dia.
>
>**Cuando** el cliente ingresa el numero de comprobante 6 y presiona "Realizar consulta".
>
>**Entonces** el sistema muestra el siguiente mensaje de error: "tramite inexistente".

##### Escenario 3: Repeticion de consultas fallidas por comprobante invalido.
>**Dado** el numero de comprobante 7, que es invalido y no corresponde a un tramite; y un cliente que ha realizado dos consultas con numeros de comprobantes invalidos en la ultima media hora.
>
>**Cuando** el cliente ingresa el numero de comprobante 7 y presiona "Realizar consulta".
>
>**Entonces** el sistema muestra el siguiente mensaje de error "tramite inexistente" y bloquea la direccion IP del cliente por 24 horas.

##### Escenario 4: Consulta fallida por exceso de consultas invalidas.
>**Dado** un cliente que ha realizado tres consultas con numeros de comprobantes invalidos en la ultima media hora.
>
>**Cuando** el cliente ingresa el numero de comprobante 8 y presiona "Realizar consulta".
>
>**Entonces** el sistema muestra el siguiente mensaje de error "Usted ha excedido el numero de consultas invalidas".

### HU-3:
#### ID:
`Pedir listado.`
#### Titulo:
`Como gerente del banco quiero pedir un listado de creditos aprobados para calcular estadisticas.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Pedido de listado exitoso.
>**Dado** que existen 5 creditos aprobados entre el 1/2/2023 y el 1/3/2023.
>
>**Cuando** el gerente ingresa las fechas 1/2/2023 y 1/3/2023 y presiona "Pedir Listado".
>
>**Entonces** el sistema muestra un listado con los 5 creditos aprobados entre las fechas ingresadas.

##### Escenario 2: Pedido de listado fallido por fechas invalidas.
>**Dado** un gerente que desea pedir un listado el dia 5/4/2023.
>
>**Cuando** el gerente ingresa las fechas 1/2/2025 y 1/3/2024 y presiona "Pedir Listado".
>
>**Entonces** el sistema muestra el siguiente mensaje de error: "las fechas ingresadas no son validas".

##### Escenario 3: Pedido de listado fallido por ausencia de creditos aprobados.
>**Dado** que no existen creditos aprobados entre el 4/6/2022 y el 4/7/2022; y dichas fechas son validas.
>
>**Cuando** el gerente ingresa las fechas 4/6/2022 y  4/7/2022 y presiona "Pedir Listado".
>
>**Entonces** el sistema muestra el siguiente mensaje de error: "No hay creditos aprobados en las fechas ingresadas.".
>
