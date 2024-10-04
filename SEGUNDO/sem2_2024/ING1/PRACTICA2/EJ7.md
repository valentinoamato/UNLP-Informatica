## 7) Mutual.
### HU-1:
#### ID: 
`Afiliar persona.`
#### Titulo:
`Como persona quiero afiliarme para acceder a las prestaciones brindadas.`
#### Reglas de Negocio:
`La persona debe tener una tarjeta de credito.`

#### Criterios de aceptacion:
##### Escenario 1: Afilicacion exitosa.
>**Dado** una persona con DNI 1234 que tiene un tarjeta de credito valida con el numero 4321.
>
>**Cuando** la persona ingresa el DNI 1234 y el numero de tarjeta 4321 y presiona "Afliliarse".
>
>**Entonces** el sistema registra a la persona como afiliado y retorna un resultado de exito junto con su numero de afiliado.

##### Escenario 2: Afilicacion fallida por tarjeta invalida.
>**Dado** una persona con DNI 1235 y la tarjeta de debito con el numero 4322.
>
>**Cuando** la persona ingresa el DNI 1235 y el numero de tarjeta 4322 y presiona "Afliliarse".
>
>**Entonces** el sistema informa que no se llevo a cabo la operacion porque la tarjeta es invalida.

### HU-2:
#### ID:
`Asociar familia.`
#### Titulo:
`Como afiliado quiero tener a cargo a mi familia para que ellos tambien puedan acceder a las prestaciones.`
#### Reglas de Negocio:
`Los hijos del efiliado no pueden ser mayores a 18 años.`


#### Criterios de aceptacion:
##### Escenario 1: Asociacion de pareja exitosa.
>**Dado** un afiliado con DNI 123 y su pareja con DNI 1234.
>
>**Cuando** el afiliado ingresa el su DNI (123) y el de su pareja (1234) y presiona "Asociar Familiar".
>
>**Entonces** el sistema crea registra la operacion y informa el numero de afiliado de la pareja del afiliado.

##### Escenario 2: Asociacion de hijo exitosa.
>**Dado** un afiliado con DNI 124 y su hijo  de 16 años con DNI 1235.
>
>**Cuando** el afiliado ingresa el su DNI (124) y el de su hijo (1235) y presiona "Asociar Familiar".
>
>**Entonces** el sistema crea registra la operacion y informa el numero de afiliado del hijo del afiliado.

##### Escenario 3: Asociacion de hijo fallida por edad mayor a la maxima.
>**Dado** un afiliado con DNI 125 y su hijo  de 21 años con DNI 1236.
>
>**Cuando** el afiliado ingresa el su DNI (125) y el de su hijo (1236) y presiona "Asociar Familiar".
>
>**Entonces** el sistema informa que la operacion no se llevo a cabo por que el hijo del afiliado tiene mas de 18 años.

### HU-3:
#### ID:
`Ortodoncia.`
#### Titulo:
`Como afiliado quiero hacerme una ortodoncia para verme mejor.`
#### Reglas de  Negocio:
`Solo se reconoce una.`

`Solo pueden realizarla los afiliados menores de 15 años afiliados desde hace al menos 9 meses.`

`Debe presentarse historia clinica.`
#### Criterios de aceptacion:
##### Escenario 1: Solicitud exitosa.
>**Dado** un afiliado con DNI 123, de 10 años, que se afilio hace 10 meses, posee historia clinica, y no se hizo una ortodoncia previamente.
>
>**Cuando** el socio ingresa el DNI 123, ingresa su historia clinica, y selecciona la opcion de "Realizar Ortodoncia".
>
>**Entonces** el sistema registra la operacion y emite un comprobante que sera usado por el afiliado para realizar la ortodoncia.

##### Escenario 2: Solicitud fallida por ortodoncia ya realizada.
>**Dado** un afiliado con DNI 124, de 11 años, que se afilio hace 11 meses, posee historia clinica, y se hizo una ortodoncia previamente.
>
>**Cuando** el socio ingresa el DNI 124, ingresa su historia clinica, y selecciona la opcion de "Realizar Ortodoncia".
>
>**Entonces** el sistema informa que el afiliado ya se hizo una ortodoncia.

##### Escenario 3: Solicitud fallida por edad invalida.
>**Dado** un afiliado con DNI 125, de 17 años, que se afilio hace 12 meses, posee historia clinica, y no se hizo una ortodoncia previamente.
>
>**Cuando** el socio ingresa el DNI 125, ingresa su historia clinica, y selecciona la opcion de "Realizar Ortodoncia".
>
>**Entonces** el sistema informa que el afiliado debe ser menor de 15 años.

##### Escenario 4: Solicitud fallida por tiempo de afiliacion insuficiente.
>**Dado** un afiliado con DNI 126, de 12 años, que se afilio hace 8 meses, posee historia clinica, y no se hizo una ortodoncia previamente.
>
>**Cuando** el socio ingresa el DNI 126, ingresa su historia clinica, y selecciona la opcion de "Realizar Ortodoncia".
>
>**Entonces** el sistema informa que el afiliado debe estar afiliado hace por lo menos 9 meses.

##### Escenario 5: Solicitud fallida por falta de historia clinica.
>**Dado** un afiliado con DNI 127, de 13 años, que se afilio hace 2 años, no posee historia clinica, y se hizo una ortodoncia previamente.
>
>**Cuando** el socio ingresa el DNI 126, y selecciona la opcion de "Realizar Ortodoncia".
>
>**Entonces** el sistema informa que el afiliado debe ingresar su historia clinica.

### HU-4:
#### ID:
`Plantillas.`
#### Titulo:
`Como afiliado quiero hacerme plantillas para que no me duelan los pies.`
#### Reglas de  Negocio:
`Solo se reconocen dos por años.`

`Debe presentarse la indicacion del profesional.`

`Debe presentarse la factura del comercio que la confecciono.`
#### Criterios de aceptacion:
##### Escenario 1: Solicitud exitosa.
>**Dado** un afiliado con DNI 123, que posee indicacion del profesional, factura del comercio que confecciono las plantillas, y no se hizo plantillas previamente en el año.
>
>**Cuando** el socio ingresa el DNI 123, ingresa la indicacion del profesional, la factura, y selecciona la opcion de "Realizar Plantilla".
>
>**Entonces** el sistema registra la operacion y emite un comprobante que sera usado por el afiliado para realizar la plantilla.

##### Escenario 2: Solicitud fallida por exceso de plantillas realizadas.
>**Dado** un afiliado con DNI 124, que posee indicacion del profesional, factura del comercio que confecciono las plantillas, y se hizo 2 plantillas previamente en el año.
>
>**Cuando** el socio ingresa el DNI 124, ingresa la indicacion del profesional, la factura, y selecciona la opcion de "Realizar Plantilla".
>
>**Entonces** el sistema informa que el afiliado ya exedio la cantidad de plantillas permitidas por año.

##### Escenario 3: Solicitud fallida por falta de indicacion del profesional.
>**Dado** un afiliado con DNI 125, que no posee indicacion del profesional,  tiene factura del comercio que confecciono las plantillas, y se hizo 1 plantilla previamente en el año.
>
>**Cuando** el socio ingresa el DNI 125, ingresa la factura, y selecciona la opcion de "Realizar Plantilla".
>
>**Entonces** el sistema informa que el afiliado debe ingresar la indicacion del profecional.

##### Escenario 4: Solicitud fallida por falta de factura.
>**Dado** un afiliado con DNI 126, que posee indicacion del profesional, y se hizo 1 plantilla previamente en el año.
>
>**Cuando** el socio ingresa el DNI 125, ingresa la indicacion del profesional, y selecciona la opcion de "Realizar Plantilla".
>
>**Entonces** el sistema informa que el afiliado debe ingresar la factura.

### HU-5:
#### ID:
`Anteojos.`
#### Titulo:
`Como afiliado quiero hacerme anteojos para ver mejor.`
#### Reglas de  Negocio:
`El beneficiado debe estar afiliado hace mas de tres meses.`

`Solo se puede acceder a un par cada 18 meses.`
#### Criterios de aceptacion:
##### Escenario 1: Solicitud exitosa.
>**Dado** un afiliado con DNI 123, que se afilio hace 10 meses, y no solicito un par de anteojos previamente.
>
>**Cuando** el socio ingresa el DNI 123, y selecciona la opcion de "Realizar Anteojos.".
>
>**Entonces** el sistema registra la operacion y emite un comprobante que sera usado por el afiliado para realizar el par de anteojos.

##### Escenario 2: Solicitud fallida por fecha de afiliacion invalida.
>**Dado** un afiliado con DNI 124, que se afilio hace 2 meses, y no solicito un par de anteojos previamente.
>
>**Cuando** el socio ingresa el DNI 124, y selecciona la opcion de "Realizar Anteojos.".
>
>**Entonces** el sistema informa que para realizar la operacion el se debe haber estado afiliado por al menos 3 meses.

##### Escenario 3: Solicitud fallida exceso de solicitudes.
>**Dado** un afiliado con DNI 125, que se afilio hace 7 meses, y solicito un par de anteojos hace 2 meses.
>
>**Cuando** el socio ingresa el DNI 125, y selecciona la opcion de "Realizar Anteojos.".
>
>**Entonces** el sistema informa que el afiliado que solicito un par de enteojos hace 2 meses.

### HU-6:
#### ID:
`Internacion.`
#### Titulo:
`Como afiliado quiero internarme para no fallecer?!`.
#### Reglas de  Negocio:
`---`
#### Criterios de aceptacion:
##### Escenario 1: Solicitud exitosa.
>**Dado** un afiliado con DNI 125.
>
>**Cuando** el socio ingresa el DNI 123, y selecciona la opcion de "Realizar internacion?!.".
>
>**Entonces** el sistema registra la operacion y emite un comprobante que sera usado por el afiliado para realizar la internacion.

### HU-7:
#### ID:
`Consultas medicas.`
#### Titulo:
`Como afiliado quiero hacer una consulta medica para asegurarme de que estoy saludable.`
#### Reglas de  Negocio:
`Solo se puede acceder a dos consultas cada 2 meses.`
#### Criterios de aceptacion:
##### Escenario 1: Solicitud exitosa.
>**Dado** un afiliado con DNI 123, y no solicito consultas previamente.
>
>**Cuando** el socio ingresa el DNI 123, y selecciona la opcion de "Solicitar consulta".
>
>**Entonces** el sistema registra la operacion y emite un comprobante que sera usado por el afiliado para obtener la consulta.

##### Escenario 2: Solicitud fallida por exceso de consultas.
>**Dado** un afiliado con DNI 125, y realizo 3 consultas en el mes.
>
>**Cuando** el socio ingresa el DNI 125, y selecciona la opcion de "Solicitar consulta".
>
>**Entonces** el sistema informa que el afiliado ya exedio el limite de dos consultas por mes.
