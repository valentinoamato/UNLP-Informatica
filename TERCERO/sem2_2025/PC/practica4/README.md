### 1)
#### a)
```cpp
chan Solicitudes((int, tipoSolicitud));
chan Resultados[N](tipoResultado);

Process Persona[id: 0..N-1] {
    tipoSolicitud solicitud = getSolictud(); //Solicitud del cliente
    tipoResultado resultado; //Resultado de la solicitud

    send Solicitudes((id, solicitud)); //Enviar la solicitud al empleado

    receive Resultados[id](resultado); //Esperar resultado
}

Process Empleado[id: 1] {
    tipoSolicitud solicitud;
    tipoResultado resultado;
    int idCliente;

    for int i in 1..N {
        receive Solicitudes((idCliente, solicitud)); //Recibir solicitud del proximo cliente

        resultado = procesarSolicitud(solicitud); //Procesar solicitud

        send Resultados[idCliente](resultado); //Envio resultado al cliente
    }
}
```

#### b)
```cpp
chan Solicitudes[2]((int, tipoSolicitud)); //Solicitudes de los empleados
chan Resultados[N](tipoResultado);

Process Persona[id: 0..N-1] {
    tipoSolicitud solicitud = getSolictud(); //Solicitud del cliente
    tipoResultado resultado; //Resultado de la solicitud

    if (empty(Solicitudes[0])) {
        send Solicitudes[0]((id, solicitud)); //Enviar la solicitud al empleado 0
    } else {
        send Solicitudes[1]((id, solicitud)); //Enviar la solicitud al empleado 1
    }

    receive Resultados[id](resultado); //Esperar resultado
}

Process Empleado[id: 0..1] {
    tipoSolicitud solicitud;
    tipoResultado resultado;
    int idCliente;

    while (true) {
        receive Solicitudes[id]((idCliente, solicitud)); //Recibir solicitud del proximo cliente

        resultado = procesarSolicitud(solicitud); //Procesar solicitud

        send Resultados[idCliente](resultado); //Envio resultado al cliente
    }
}
```

#### c)
```cpp
chan Solicitudes[2]((int, tipoSolicitud)); //Solicitudes de los empleados
chan Resultados[N](tipoResultado);

Process Persona[id: 0..N-1] {
    tipoSolicitud solicitud = getSolictud(); //Solicitud del cliente
    tipoResultado resultado; //Resultado de la solicitud

    if (empty(Solicitudes[0])) {
        send Solicitudes[0]((id, solicitud)); //Enviar la solicitud al empleado 0
    } else {
        send Solicitudes[1]((id, solicitud)); //Enviar la solicitud al empleado 1
    }

    receive Resultados[id](resultado); //Esperar resultado
}

Process Empleado[id: 0..1] {
    tipoSolicitud solicitud;
    tipoResultado resultado;
    int idCliente;

    while (true) {
        if (empty(Solicitudes[id])) {
            delay(15*60); //Tareas administrativas
        } else {
            receive Solicitudes[id]((idCliente, solicitud)); //Recibir solicitud del proximo cliente

            resultado = procesarSolicitud(solicitud); //Procesar solicitud

            send Resultados[idCliente](resultado); //Envio resultado al cliente
        }
    }
}
```

### 2)
```cpp
chan RequestTurno(int); //Persona solicita un turno
chan NumeroCaja[P](int); //Banco informa numero de caja a usar
chan Boletas[5]((int, tipoBoleta)); //Cliente envia su id y boleta
chan Facturas[P](tipoFactura); //Caja envia factura del pago
chan Fin(int); //Caja le avisa al banco que termino de atender a una persona

Process Persona[id: 0..P-1] {
    tipoBoleta boleta = getBoleta(id); //Obtiene la boleta a pagar
    tipoFactura factura;
    int caja;

    send RequestTurno(id); //Pido un turno
    receive NumeroCaja[id](caja); //Recibo el numero de caja

    send Boletas[caja]((id, boleta)); //Envio mi boleta
    receive Facturas[id](factura); //Recibo la factura
}

Process Caja[id: 0..4] {
    tipoBoleta boleta;
    tipoFactura factura;
    int idPersona;

    while (true) {
        receive Boleta[id]((idPersona, boleta)); //Recibir boleta del proximo cliente

        factura = procesarPago(boleta); //Realizar el pago

        send Factura[idPersona](factura); //Enviar la factura al cliente

        send Fin(id); //Avisar al banco que ya atendi al cliente
    }
}

Process Banco[id: 0] {
    int cants[5] = {0,0,0,0,0}; //Clientes esperando
    int idCliente;
    int cantMin; //Cantidad de personas en la caja que tiene menos
    int cajaMin; //Caja con menos personas
    int caja; //Caja que atendio a un cliente

    while (true) {
        receive RequestTurno(idCliente);

        cantMin = min(cants); //Calcular cantidad minima de personas esperando
        cajaMin = cants.get(cantMin); //Tomo la caja que tiene la cantidad minima calculada

        cants[cajaMin]++; //Actualizo la cantidad

        send NumeroCaja[idCliente](cajaMin); //Aviso al cliente la caja a usar

        while (!empty(Fin)) { //Si se atendio a algun cliente
            //Actualizo las cantidades
            receive Fin(caja);
            cants[caja]--;
        }
    }
}
```

### 3)
```cpp
chan Pedido((int, tipoPedido)); //Cliente realiza un pedido
chan Comida[C](comida); //Cliente recibe la comida
chan RealizarPlato((id, tipoPedido)); //Vendedor pide a cocinero que realice un plato

Process Cliente[id:0..C-1] {
    tipoPedido pedido = getPedido(id); //Obtener el pedido a realizar
    tipoComida comida;

    send Pedido((id, pedido)); //Realizar el pedido
    receive Comida[id](comida); //Recibir la comida
}

Process Vendedor[id: 0..2] {
    tipoPedido pedido;
    int cliente;
    while (true) {
        if (empty(Pedido)) { //Si no hay pedidos
            reponerHeladera();
        } else {
            receive Pedido((cliente, pedido)); //Recibir pedido
            send RealizarPlato((cliente, pedido)); //Enviar el pedido al cocinero
        }
    }
}

Process Cocinero[id: 0..1] {
    tipoPedido pedido;
    int cliente;
    tipoComida comida;

    while (true) {
        receive RealizarPlato((cliente, pedido)); //Recibir un pedido del vendedor

        comida = Cocinar(pedido);

        send Comida[cliente](comida); //Enviar la comida al cliente
    }
}
```

### 4
#### a)
```cpp
chan SolicitarCabina(int); //Cliente solicita una cabina
chan NroCabina[N](int); //Empleado le dice a cliente que cabina usar
chan Termine((int, int)); //Cliente le dice al empleado que termino de usar la cabina c
chan Factura[N](tipoFactura); //Empleado le da la factura el cliente

Process Cliente[id: 0..N-1] {
    int cabina;
    tipoFactura factura;

    send SolicitarCabina(id); //Solicito una cabina
    receive NroCabina[id](cabina); //Recibo el nro de cabina a usar

    usarCabina(cabina); //Uso la cabina

    send Termine((id, cabina)); //Aviso que termine de usar la cabina
    receive Factura[id](factura); //Recibo la factura
}

Process Empleado[id: 0] {
    colaCabina cabinas; //Se asume que ya tiene encolados todos los numeros de cabinas (1..10)
    int cliente;
    tipoFactura factura;

    while (true) {
        receive SolicitarCabina(cliente); //Recibo solicitud de cliente
        send NroCabina[cliente](cabinas.pop()); //Le digo al cliente cual usar

        //Si no hay solicitudes o no quedan cabinas, hago un cobro, sino atiendo al proximo
        //Prioriza a las solicitudes ante los cobros (si se puede antender al proximo lo hace)
        if ((empty(SolicitarCabina)) || (cabinas.isEmpty())) {
            receive Termine((cliente,cabina)); //Recibe la cabina que se termino de usar

            cabinas.push(cabina); //Encolo la cabina usada

            factura = Cobrar(cliente, cabina); //COBRAR

            send Factura[cliente](factura); //Enviar la factura al cliente
        }

    }
}
```

#### b)
```cpp
chan SolicitarCabina(int); //Cliente solicita una cabina
chan NroCabina[N](int); //Empleado le dice a cliente que cabina usar
chan Termine((int, int)); //Cliente le dice al empleado que termino de usar la cabina c
chan Factura[N](tipoFactura); //Empleado le da la factura el cliente

Process Cliente[id: 0..N-1] {
    int cabina;
    tipoFactura factura;

    send SolicitarCabina(id); //Solicito una cabina
    receive NroCabina[id](cabina); //Recibo el nro de cabina a usar

    usarCabina(cabina); //Uso la cabina

    send Termine((id, cabina)); //Aviso que termine de usar la cabina
    receive Factura[id](factura); //Recibo la factura
}

Process Empleado[id: 0] {
    colaCabina cabinas; //Se asume que ya tiene encolados todos los numeros de cabinas (1..10)
    int cliente;
    tipoFactura factura;

    while (true) {
        //Si termino alguien le cobro
        //Si no hay cabinas, le cobro al que este esperando o al que llegue
        //Prioriza a los cobros, ya que si puede cobrarle a alguien lo hace
        if ((!empty(Termine)) || (cabinas.isEmpty())) {
            receive Termine((cliente,cabina)); //Recibe la cabina que se termino de usar

            cabinas.push(cabina); //Encolo la cabina usada

            factura = Cobrar(cliente, cabina); //COBRAR

            send Factura[cliente](factura); //Enviar la factura al cliente
        } else {//Si nadie espera a que le cobren, y hay cabinas
            receive SolicitarCabina(cliente); //Recibo solicitud de cliente
            send NroCabina[cliente](cabinas.pop()); //Le digo al cliente cual usar
        }

    }
}
```

### 5
#### a)
```cpp
chan Trabajo(tipoTrabajo); //Admin envia el trabajo a imprimir

Process Admin[id: 0..N-1] {
    tipoTrabajo trabajo;
    int impresora;

    while (true) {
        trabajo = trabajar(); //TRABAJAR

        send Trabajo(trabajo); //Enviar trabajo a imprimir
    }
}

Process Impresora[id: 0..2] {
    tipoTrabajo trabajo;

    while (true) {
        receive Trabajo(trabajo); //Recibir un trabajo a imprimir

        imprimir(trabajo); //Imprimir el trabajo
    }
}
```

#### b)
```cpp
chan TrabajoA(tipoTrabajo); //Admin envia el trabajo a imprimir
chan TrabajoD(tipoTrabajo); //Director envia el trabajo a imprimir

Process Admin[id: 0..N-1] {
    tipoTrabajo trabajo;
    int impresora;

    while (true) {
        trabajo = trabajar(); //TRABAJAR

        send TrabajoA(trabajo); //Enviar trabajo a imprimir
    }
}

Process Director[id: 0] {
    tipoTrabajo trabajo;
    int impresora;

    while (true) {
        trabajo = trabajar(); //TRABAJAR

        send TrabajoD(trabajo); //Enviar trabajo a imprimir
    }
}

Process Impresora[id: 0..2] {
    tipoTrabajo trabajo;

    while (true) {
        if (!empty(TrabajoD)) { //Si el director envio un trabajo
            receive TrabajoD(trabajo); //Recibo el trabajo del director
        } else  {
            receive TrabajoA(trabajo); //Recibo un trabajo de un Admin
        }

        imprimir(trabajo); //Imprimir el trabajo
    }
}
```

#### c)
```cpp
chan Trabajo(tipoTrabajo); //Admin envia el trabajo a imprimir

Process Admin[id: 0..N-1] {
    tipoTrabajo trabajo;
    int impresora;

    for int i in 1..10 {
        trabajo = trabajar(); //TRABAJAR

        send Trabajo(trabajo); //Enviar trabajo a imprimir
    }
}

Process Impresora[id: 0..2] {
    tipoTrabajo trabajo;

    for int i in 1..(N*10) {
        receive Trabajo(trabajo); //Recibir un trabajo a imprimir

        imprimir(trabajo); //Imprimir el trabajo
    }
}
```

#### d)
```cpp
chan TrabajoA(tipoTrabajo); //Admin envia el trabajo a imprimir
chan TrabajoD(tipoTrabajo); //Director envia el trabajo a imprimir

Process Admin[id: 0..N-1] {
    tipoTrabajo trabajo;
    int impresora;

    for int i in 1..10 {
        trabajo = trabajar(); //TRABAJAR

        send TrabajoA(trabajo); //Enviar trabajo a imprimir
    }
}

Process Director[id: 0] {
    tipoTrabajo trabajo;
    int impresora;

    for int i in 1..10 {
        trabajo = trabajar(); //TRABAJAR

        send TrabajoD(trabajo); //Enviar trabajo a imprimir
    }
}

Process Impresora[id: 0..2] {
    tipoTrabajo trabajo;
    int impAdmin = 0; //Trabajos impresos por los admin

    for int i in 1..(N*10 + 10) {
        if ((!empty(TrabajoD) || (impAdmin == 100)) { //Si el director envio un trabajo o los admins terminaron
            receive TrabajoD(trabajo); //Recibo el trabajo del director
        } else {
            receive TrabajoA(trabajo); //Recibo un trabajo de un Admin
            impAdmin++;
        }

        imprimir(trabajo); //Imprimir el trabajo
    }
}
```
