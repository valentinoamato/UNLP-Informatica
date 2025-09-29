## Semaforos
### 1)
#### a)
```
sem personas[P] = {0,0,...,0};
cola esperando;
sem mutex = 1;
bool libre = true;

Process Persona[id: 0..P-1] {
    P(mutex);
    if (!libre) { //Si no esta libre
        esperando.push(id); //Espero
        V(mutex);
        P(personas[id]);
    else { //Si esta libre
        libre = false; //Ya no esta libre
        V(mutex);
    }

    UsarTerminal();

    P(mutex);
    if (!esperando.isEmpty()) { //Si hay alquien esperando
        V(personas[esperando.pop()]); //Lo despierto
    else { //Sino 
        libre = true; //La maquina esta libre
    }
    V(mutex);
}
```

#### b)
```
sem personas[P] = {0,0,...,0};
cola esperando;
sem mutex = 1;
int usando = 0; //Personas usando terminales
cola terminales; //Se asume que todos los terminales inician encolados

Process Persona[id: 0..P-1] {
    P(mutex);
    if (usando < t) { //Si hay lugar
        usando++;
        Terminal t = terminales.pop();
        V(mutex);
    else { //Si no hay lugar
        esperando.push(id); //Espero
        V(mutex);
        P(personas[id]);
    }

    UsarTerminal(t);

    P(mutex);
    terminales.push(t);
    if (!esperando.isEmpty()) { //Si hay alquien esperando
        V(personas[esperando.pop()]); //Lo despierto
    else { //Sino 
        usando--;
    }
    V(mutex);
}
```
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

### 3)
```
int latas = 100;
sem vacio = 0; //Aviso que esta vacio
sem lleno = 0; //Aviso que esta lleno

bool libre = true; //La maquina esta libre
cola esperando; //Fila de personas
sem mutex = 1; //Mutex de la cola y el libre
sem personas[U] = {0,0,...,0}; //Aviso a una persona que le toca

Process Repositor[id: 0] {
    while (true) {
        P(vacio); //Espero que este vacio

        latas = 100;

        V(lleno); //Aviso que esta lleno
    }
}

Process Persona[id: 0..U-1] {
    P(mutex);
    if (libre) {
        libre = false;
        V(mutex);
    } else {
        esperando.push(id);
        V(mutex);
        P(personas[id]);
    }
    //Solo se accede a uno a esta seccion
    if (latas == 0) { //Si no hay latas
        V(vacio); //Aviso que no hay mas latas
        P(lleno); //Espero que se llenen de latas
    }
    latas--;

    P(mutex);
    if (esperando.isEmpty()) { //Si no hay nadie esperando
        libre = true;
    } else { //Sino
        V(personas[esperando.pop()]); //Aviso al proximo
    }
    V(mutex);
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
        terminaron++;
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
