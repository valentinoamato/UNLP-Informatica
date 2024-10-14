## 12-B) Venta de libros.
### Historias de uso:
`Registrar usuario.`

`Confirmar correo.`

`Iniciar sesion.`

`Cerrar sesion.`

`Comprar libros.`

`Pagar con tarjeta.`
### HU-1:
#### ID:
`Registrar usuario.`
#### Titulo:
`Como visitante de el sitio web quiero registrarme para comprar libros.`
#### Reglas de Negocio:
`La clave debe ser de 6 caracteres.`

#### Criterios de aceptacion:
##### Escenario 1: Registro exitoso.
>**Dado** el correo electronico "juanmaria@gmail.com" que no se encuentra registrado.
>
>**Cuando** el visitante ingresa los siguientes datos:
> - Nombre: Juan Maria.
> - Apellido: Tevez.
> - DNI: 1234.
> - Correo electronico: juanmaria@gmail.com.
> - Clave: juanma
>
> y presiona "Registrar".
>
>**Entonces** el sistema genera el codigo de verificacion de 16 digitos, lo envia al correo ingresado y informa el exito de la operacion.

##### Escenario 2: Registro fallido por clave invalida.
>**Dado** el correo electronico "juancarlos@gmail.com" que no se encuentra registrado.
>
>**Cuando** el visitante ingresa los siguientes datos:
> - Nombre: Juan Carlos.
> - Apellido: Tevez.
> - DNI: 1235.
> - Correo electronico: juancarlos@gmail.com.
> - Clave: juan12345
>
> y presiona "Registrar".
>
>**Entonces** el sistema informa que la contraseña debe tener 6 digitos.

##### Escenario 3: Registro fallido correo ya registrado.
>**Dado** el correo electronico "joaquin@gmail.com" que ya se encuentra registrado.
>
>**Cuando** el visitante ingresa los siguientes datos:
> - Nombre: Joaquin.
> - Apellido: Ortiz.
> - DNI: 1236.
> - Correo electronico: joaquin@gmail.com.
> - Clave: joa123.
>
> y presiona "Registrar".
>
>**Entonces** el sistema informa que el correo ingresado ya fue registrado.

### HU-2:
#### ID:
`Confirmar correo.`
#### Titulo:
`Como visitante de el sitio web quiero confirmar mi correo para terminar el registro de mi cuenta.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Confirmacion exitosa.
>**Dado** un visitante con el correo "hernan@gmail.com" que se registro, se le envio el codigo de confirmacion 1234567890123456 y todavia no confirmo su correo.
>
>**Cuando** el visitante ingresa la direccion de correo "hernan@gmail.com" y el codigo 1234567890123456, y presiona "Confirmar Correo".
>
>**Entonces** el sistema registra definitivamente al visitante como usuario y muestra un mensaje de exito.

##### Escenario 2: Confirmacion fallida por datos invalidos.
>**Dado** que el codigo 1234567890666666 no corresponde a un codigo de confirmacion valido para el correo "nuria@gmail.com".
>
>**Cuando** el visitante ingresa la direccion de correo "nuria@gmail.com" y el codigo 1234567890666666, y presiona "Confirmar Correo".
>
>**Entonces** el sistema informa que los datos ingresados son invalidos.

### HU-3:
#### ID:
`Iniciar sesion.`
#### Titulo:
`Como usuario registrado quiero iniciar sesion para comprar libros.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Inicio de sesion exitoso.
>**Dado** que existe un usuario registrado con el correo "gianfranco@gmail.com" y la contraseña "gian32".
>
>**Cuando** el usuario ingresa el correo "gianfranco@gmail.com", la contraseña "gian32" y presiona "Iniciar Sesion".
>
>**Entonces** el sistema inicia la sesion del usuario.

##### Escenario 2: Inicio de sesion fallido por credenciales invalidas.
>**Dado** que no existe un usuario registrado con el correo "tomas@gmail.com" y la contraseña "tomas7".
>
>**Cuando** el usuario ingresa el correo "tomas@gmail.com", la contraseña "tomas7" y presiona "Iniciar Sesion".
>
>**Entonces** el sistema informa que las credenciales son invalidas.

### HU-4:
#### ID:
`Cerrar sesion.`
#### Titulo:
`Como usuario registrado quiero cerrar sesion para irme a leer un libro.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Cierre de sesion exitoso.
>**Dado** que existe un usuario registrado con una sesion activa.
>
>**Cuando** el usuario presiona "Cerrar Sesion".
>
>**Entonces** el sistema cierra la sesion del usuario.

### HU-5:
#### ID:
`Comprar libros.`
#### Titulo:
`Como usuario registrado comprar libros para hacer un regalo.`
#### Reglas de Negocio:
`---`

#### Criterios de aceptacion:
##### Escenario 1: Compra exitosa.
>**Dado** un usuario con sesion activa, que el ISBN 5 corresponde a un libro y que las condiciones son las adecuadas para un pago exitoso.
>
>**Cuando** el usuario ingresa el ISBN 5 y presiona "Comprar".
>
>**Entonces** el sistema redirige al usuario al pago con tarjeta, espera respuesta, genera el enlace de descarga y se envia al correo del usuario.

##### Escenario 2: Compra fallida por ISBN invalido.
>**Dado** un usuario con sesion activa, que el libro con ISBN 6 no existe y que las condiciones son las adecuadas para un pago exitoso.
>
>**Cuando** el usuario ingresa el ISBN 6 y presiona "Comprar".
>
>**Entonces** el sistema muestra un mensaje informando que el ISBN 6 no corresponde a un libro.

##### Escenario 3: Compra fallida por error en el pago.
>**Dado** un usuario con sesion activa, que el libro con ISBN 7 existe y que las condiciones no son las adecuadas para un pago exitoso.
>
>**Cuando** el usuario ingresa el ISBN 7 y presiona "Comprar".
>
>**Entonces** el sistema redirige al usuario al pago con tarjeta, espera respuesta, e informa que ocurrio un error en el pago.

### HU-6:
#### ID:
`Pagar con tarjeta.`
#### Titulo:
`Como usuario registrado quiero pagar con tarjeta para terminar mi compra.`
#### Reglas de Negocio:
`Solo el titular de la tarjeta puede realizar la compra.`

#### Criterios de aceptacion:
##### Escenario 1: Pago exitoso.
>**Dado** que el usuario registrado de nombre Juan Garcia posee una tarjeta de credito valida, a su nombre, con el numero 1234, fondos suficientes, y la conexion con el servidor del banco es exitosa.
>
>**Cuando** el usuario ingresa los siguientes datos de la tarjeta:
>- Apellido: Garcia.
>- Nombre: Juan.
>- Numero de tarjeta: 1234.
>
>y presiona "Pagar".
>
>**Entonces** el sistema registra el pago y retorna un resultado de exito.

##### Escenario 2: Pago fallido por error de conexion.
>**Dado** que el usuario registrado de nombre Juan Amato posee una tarjeta de credito valida, a su nombre, con el numero 1235, fondos suficientes, y no se pudo realizar la conexion con el servidor del banco.
>
>**Cuando** el usuario ingresa los siguientes datos de la tarjeta:
>- Apellido: Amato.
>- Nombre: Juan.
>- Numero de tarjeta: 1235.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por conexion fallida.

##### Escenario 3: Pago fallido por fondos insuficientes.
>**Dado** que el usuario registrado de nombre Martin Fernandez posee una tarjeta de credito valida, a su nombre, con el numero 1236, fondos insuficientes, y la conexion con el servidor del banco es exitosa.
>
>**Cuando** el usuario ingresa los siguientes datos de la tarjeta:
>- Apellido: Fernandez.
>- Nombre: Martin.
>- Numero de tarjeta: 1236.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por fondos insuficientes.

##### Escenario 4: Pago fallido por numero de tarjeta inexistente.
>**Dado** el usuario registrado de nombre Albert Einstein, que el numero 1237 no corresponde a un numero de tarjeta valido, y que la conexion con el servidor del banco es exitosa.
>
>**Cuando** el usuario ingresa los siguientes datos de la tarjeta:
>- Apellido: Einstein.
>- Nombre: Albert.
>- Numero de tarjeta: 1237.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error por numero de tarjeta inexistente.

##### Escenario 5: Pago fallido por uso de tarjeta que no pertenece al usuario.
>**Dado** el usuario registrado de nombre Charles Darwin, que el numero 1238 corresponde a un numero de tarjeta valido, que tiene fondos suficientes, su propietario es Dexter Morgan, y que la conexion con el servidor del banco es exitosa.
>
>**Cuando** el usuario ingresa los siguientes datos de la tarjeta:
>- Apellido: Morgan.
>- Nombre: Dexter.
>- Numero de tarjeta: 1238.
>
>y presiona "Pagar".
>
>**Entonces** el sistema retorna un error porque el usuario no es el titular de la tarjeta.
