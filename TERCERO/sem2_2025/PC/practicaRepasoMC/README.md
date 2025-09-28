## Semaforos
### 2)
```
transaccion transacciones[10000];
int actual = 0; //Transaccion actual
sem mutexT = 1; //Mutex de las transacciones

int cants[10] = {0,0,...,0} //Cantidad de transacciones por resultado
sem mutexC = 1; //Mutex de las cantidades

Process Worker[id: 0..6] {
    int cantsLocal = {0,0,...,0}; //Cantidades locales
    transaccion miTrans;
    bool continuar = true;

    while (continuar) {
        P(mutexT); //Espera para tomar una transaccion
            if (actual < 10000) { //Si quedan transacciones
                miTrans = transacciones[actual]; //Tomo mi transaccion
                actual++;
            } else { //Si no quedan transacciones
                continuar = false;
            }
        V(mutexT); //Libero la estructura

        if (continuar) {
            cantsLocal[Validar(T)]++; //Valido e incremento cant
        }
    }

    //Actualizo las cantidades globales
    P(mutexC);
    for i in 0..9 {
        cants[i]+=cantsLocal[i];
    }
    V(mutexC);
}
```

## Monitores
### 2)
```
Monitor Grupo[id: 0..4] {
    int ventas = 0; //Ventas del grupo
    int llegaron = 0; //Vendedores que llegaron
    cond lleguen; //Esperar a que lleguen todos
    int terminaron = 0; //Vendedores que terminaron
    cond terminen; //Esperar a que terminen todos

    Procedure llegue() {
        llegaron++;
        if (llegaron < 4) {
            await(lleguen);
        } else {
            signalAll(lleguen);
        }
    }

    Procedure termine(misVentas: in, ventasTotales:out) {
        llegaron++;
        ventas+=misVentas;
        if (terminaron < 4) {
            await(terminen);
        } else {
            signalAll(terminen);
        }
        ventasTotales = ventas;
    }
}

Process Vendedor[id: 0..19] {
    int equipo = getEquipo();
    int misVentas = 0;
    int ventasTotales = 0;
    Grupo[equipo-1].llegue();
    //Realizar ventas
    Grupo[equipo-1].termine(misVentas, ventasTotales);
}
```
