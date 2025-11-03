## PMA

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
chan Solicitud(Documento));

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

