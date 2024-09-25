## 3) Contratos
### HU-1:
#### ID: 
`Confeccionar minuta.`
#### Titulo:
`Como empleado de mesa de entradas quiero confeccionar una minuta para que se de un contrato.`
#### Reglas de Negocio:
`El monto del contrato no puede ser mayor a $25.000.`

`La duracion del contrato no puede ser mayor a 6 meses.`

#### Criterios de aceptacion:
##### Escenario 1: Confeccion exitosa.
>**Cuando** el empleado de mesa de entradas ingresa los datos de la minuta:
>- Nombre de la persona a contratar: Juan Garcia.
>- CUIT de la persona a contratar: 5555.
>- Tipo de contrato: Permanente.
>- Fecha de comienzo: 12/12/2023.
>- Duracion: 5 meses.
>- Monto: $20.000.
>
>y presiona "Confeccionar minuta".
>
>**Entonces** el sistema confecciona la minuta correctamente y retorna un mensaje de exito informando el numero de la nueva minuta.

##### Escenario 2: Confeccion fallida por monto demasiado alto.
>**Cuando** el empleado de mesa de entradas ingresa los datos de la minuta:
>- Nombre de la persona a contratar: Carlos Magnum.
>- CUIT de la persona a contratar: 6666.
>- Tipo de contrato: Temporal.
>- Fecha de comienzo: 11/11/2023.
>- Duracion: 4 meses.
>- Monto: $26.000.
>
>y presiona "Confeccionar minuta".
>
>**Entonces** el sistema no confecciona la minuta y retorna un mensaje de error informando que el monto no puede exeder los $25.000.

##### Escenario 3: Confeccion fallida por duracion demasiado alta.
>**Cuando** el empleado de mesa de entradas ingresa los datos de la minuta:
>- Nombre de la persona a contratar: Matias Jaime.
>- CUIT de la persona a contratar: 4444.
>- Tipo de contrato: Temporal.
>- Fecha de comienzo: 5/10/2023.
>- Duracion: 8 meses.
>- Monto: $22.000.
>
>y presiona "Confeccionar minuta".
>
>**Entonces** el sistema no confecciona la minuta y retorna un mensaje de error informando que la duracion no puede exeder los 6 meses.

### HU-2:
#### ID:
`Aprobar minuta.`
#### Titulo:
`Como empleado de rendiciones quiero aprobar una minuta para que se de un contrato.`
#### Reglas de Negocio:
`La persona a contratar no puede tener 3 minutas aprobadas.`

`El CUIT de la persona a contratar no debe estar inhabilitado por la AFIP.`

#### Criterios de aceptacion:
##### Escenario 1: Aprobacion exitosa.
>**Dado** la minuta con numero 5, que corresponde a una persona que no tiene ninguna minuta aprobada, y su CUIT (1234) no se encuentra inhabilitado por la AFIP.
>
>**Cuando** el empleado de rendiciones ingresa el numero de minuta 5 y presiona el boton de "Aprobar".
>
>**Entonces** el sistema aprueba la minuta y retorna un mensaje de exito.

##### Escenario 2: Aprobacion fallida por exceso de minutas aprobadas.
>**Dado** la minuta con numero 6, que corresponde a una persona que tiene 3 minutas aprobadas, y su CUIT (4321) no se encuentra inhabilitado por la AFIP.
>
>**Cuando** el empleado de rendiciones ingresa el numero de minuta 6 y presiona el boton de "Aprobar".
>
>**Entonces** el sistema no aprueba la minuta y retorna un mensaje de error indicando que la persona ya tiene 3 minutas aprobadas.

##### Escenario 3: Aprobacion fallida por CUIT inhabilitado por la AFIP.
>**Dado** la minuta con numero 7, que corresponde a una persona que no tiene minutas aprobadas, y su CUIT (4444) se encuentra inhabilitado por la AFIP.
>
>**Cuando** el empleado de rendiciones ingresa el numero de minuta 7 y presiona el boton de "Aprobar".
>
>**Entonces** el sistema no aprueba la minuta y retorna un mensaje de error indicando que el CUIT de la persona se encuentra inhabilitado por la AFIP.

### HU-3:
#### ID:
`Imprimir listados.`
#### Titulo:
`Como empleado de rendiciones quiero imprimir los listados con las minutas aprobadas para darselo al jefe de departamento.`

#### Criterios de aceptacion:
##### Escenario 1: Impresion exitosa.
>**Cuando** el empleado de rendiciones aprieta el boton "Imprimir Listados".
>
>**Entonces** el sistema imprime los listados con las minutas aprobadas.
