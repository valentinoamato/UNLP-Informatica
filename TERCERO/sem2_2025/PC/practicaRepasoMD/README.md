## Practica de Repaso - MD

### 1)
#### a)
```cpp
chan Solicitud(Documento));

Process Impresora[id: 0..4] {
    Documento doc;

    while (true) {
        receive Solicitud(doc);
        ImprimirDocumento(doc);
    }
}

Process Empleado[id: 0..99] {
    Documento doc;

    while (true) {
        doc = GenerarDocumento();
        send Solicitud(doc);
    }
}
```

#### b)
```cpp
Process Impresora[id: 0..4] {
    Documento doc;

    while (true) {
        Buffer!prox(_);
        Buffer?documento(doc);
        ImprimirDocumento(doc);
    }
}

Process Buffer[id: 0] {
    cola docs;
    int id;

    do
        if Empleado[*]?documento(doc) -> cola.push(dir);
        ☐ (!cola.isEmpty()); Impresora[*]?prox(id) -> Impresora[id]!documento(docs.pop());
        fi
    od
}

Process Empleado[id: 0..99] {
    Documento doc;

    while (true) {
        doc = GenerarDocumento();
        Buffer!documento(doc);
    }
}
```


### 2)
```cpp
Process Terminal[id: 0] {
    Solicitud sol;
    Comprobante com;
    int id;

    for i in 1..P {
        Buffer!listo(_);
        Buffer?prox(id);
        Persona[id]!listo(_);
        Persona[id]?solicitud(sol);
        com = ResolverSolicitud(sol);
        Persona[id]!comprobante(com);
    }
}

Process Buffer[id: 0] {
    cola turnos;
    int id;

    do
        if Persona[*]?turno(id) -> cola.push(id);
        ☐ (!cola.isEmpty()); Terminal?listo(_) -> Terminal!prox(turnos.pop());
        fi
    od
}

Process Persona[id: 0..P] {
    Solicitud sol = GetSolicitud(id);
    Comprobante com;

    Buffer!turno(id);
    Terminal?listo(_);
    Terminal!solicitud(sol);
    Terminal?comprobante(com);
}
```


### 3)
```cpp
chan Solicitud((id, boletas, dinero)));
chan SolRapida((id, boletas, dinero)));
chan SolEmbarazada((id, boletas, dinero)));
chan llegue(int);
chan Resultado[0..P-1]((vuelto, recibo));

Process Caja[id: 0] {
    Boleta boletas[];
    float dinero;
    Recibo recibo;
    int id;

    while (true) {
        receive llegue(_);
        if (not empty(SolEmbarazada) {
            receive SolEmbarazada((id, boletas, dinero));
        } else if (not empty(SolRapida) {
            receive SolRapida((id, boletas, dinero));
        } else {
            receive Solicitud((id, boletas, dinero));
        }
        recibo = ProcesarPago(boletas, dinero); //Modifica dinero, dejando el vuelto

        //Enviar recibo
        send Resultado[id](vuelto, recibo);
    }
}

Process Persona[id: 0..P-1] {
    Boleta boletas[];
    bool embarazada;
    Recibo recibo;
    float dinero;

    //Asumo que las variables estan inicializadas

    if (embarazada) {
        send SolEmbarazada((id, boletas, dinero));
    } else if (boletas.len() < 5) {
        send SolRapida((id, boletas, dinero));
    } else {
        send Solicitud((id, boletas, dinero));
    }
    send llegue(0);

    receive Resultado[id]((dinero, recibo));
}
```
