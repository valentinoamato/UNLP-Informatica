## 4) Venta de bebidas
### HU-1:
#### ID: 
`Registrar persona.`
#### Titulo:
`Como persona quiero registrarme en el sistema para comprar bebidas alcoholicas.`
#### Reglas de Negocio:
`La persona debe ser mayor de edad.`

`Los mails no pueden repetirse.`

#### Criterios de aceptacion:
##### Escenario 1: Registro exitoso.
>**Dado** una persona mayor de edad con el mail juancarlos@gmail.com que no se encuentra registrado.
>
>**Cuando** la persona ingresa los siguientes datos:
>- Nombre: Juan Carlos.
>- Apellido: Cuchau.
>- Mail: juancarlos@gmail.com.
>- Edad: 25.
>
>y presiona "Registrar".
>
>**Entonces** el sistema registra el usuario y le envia una contraseña al mail ingresado.

##### Escenario 2: Registro fallido por persona menor de edad.
>**Dado** una persona menor de edad con el mail juanmaria@gmail.com que no se encuentra registrado.
>
>**Cuando** la persona ingresa los siguientes datos:
>- Nombre: Juan Maria.
>- Apellido: Heineken.
>- Mail: juanmaria@gmail.com.
>- Edad: 15.
>
>y presiona "Registrar".
>
>**Entonces** el sistema no registra el usuario y le informa a la persona que debe ser mayor de edad para registrarse.

##### Escenario 3: Registro fallido por mail ya registrado.
>**Dado** una persona mayor de edad con el mail juancarlos@gmail.com que ya se encuentra registrado.
>
>**Cuando** la persona ingresa los siguientes datos:
>- Nombre: Juan Carlos.
>- Apellido: Cuchau.
>- Mail: juancarlos@gmail.com.
>- Edad: 25.
>
>y presiona "Registrar".
>
>**Entonces** el sistema no registra el usuario y le informa que el mail juancarlos@gmail.com ya se encuentra registrado.

### HU-2:
#### ID:
`Inicio de sesion.`
#### Titulo:
`Como usuario registrado quiero iniciar sesion para comprar bebidas alcoholicas.`
#### Reglas de Negocio:
`El usuario debe estar registrado.`

#### Criterios de aceptacion:
##### Escenario 1: Inicio de sesion exitoso.
>**Dado** un usuario que se encuentra registrado en el sistema.
>
>**Cuando** el usuario ingresa sus credenciales y presiona "Iniciar Sesion".
>
>**Entonces** el sistema inicia la sesion del usuario y le muestra una lista de bebidas.

##### Escenario 2: Inicio de sesion fallido por credenciales invalidas.
>**Cuando** un usuario ingresa credenciales invalidas y presiona "Iniciar Sesion".
>
>**Entonces** el sistema informa que las credenciales no corresponden a un usuario registrado.

### HU-3:
#### ID:
`Comprar bebidas.`
#### Titulo:
`Como usuario quiero comprar bebidas alcoholicas para una reunion.`
#### Reglas de Negocio:
`Si el usuario selecciono productos por un monto superior a los $4500 se le hace un 10% de descuento.`

`Si el usuario es premium se le hace un descuento del 20%.`

`Los dos descuentos son compatibles.`
#### Criterios de aceptacion:
##### Escenario 1: Compra exitosa.
>**Dado** un usuario no premium que inicio sesion.
>
>**Cuando** el usuario selecciona varios productos por un monto total de $4000
>
>**Entonces** el sistema informa un monto de $4000 y continua con la compra.

##### Escenario 2: Compra exitosa con descuento por monto mayor a $4500.
>**Dado** un usuario no premium que inicio sesion.
>
>**Cuando** el usuario selecciona varios productos por un monto total de $5000
>
>**Entonces** el sistema informa un monto de $4500 (-10%) y continua con la compra.

##### Escenario 3: Compra exitosa con descuento por usuario premium.
>**Dado** un usuario premium que inicio sesion.
>
>**Cuando** el usuario selecciona varios productos por un monto total de $1000
>
>**Entonces** el sistema informa un monto de $800 (-20%) y continua con la compra.

##### Escenario 4: Compra exitosa con descuento por usuario premium y monto mayor a $4500.
>**Dado** un usuario premium que inicio sesion.
>
>**Cuando** el usuario selecciona varios productos por un monto total de $6000
>
>**Entonces** el sistema informa un monto de $4000 (-30%) y continua con la compra.

### HU-4:
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
