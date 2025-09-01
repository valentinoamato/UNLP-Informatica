## Practica 2
### 1)
##### b)
```
sem mutex = 1;
Process Persona[id: 1..N] {
    P(mutex);
    //Usar detector
    V(mutex);
}
```

##### c)
```
sem mutex = 3;
Process Persona[id: 1..N] {
    P(mutex);
    //Usar detector
    V(mutex);
}
```

##### d)
```
sem mutex = 3;
Process Persona[id: 1..N] {
    int cant = random();
    for (i in 1..cant) {
        P(mutex);
        //Usar detector
        V(mutex);
    }
}
```

### 2)
##### a)
```
int nivelesFallos[N];
int idFallos[N];

Process Saltarin[id: 1..4] {
    int actual = id;
    while (actual <= N) {
        if (nivelesFallos[actual-1] == 3) {
            //Imprimir mensaje
        }
        actual = actual + 4;
    }
}
```

##### b)
```
int nivelesFallos[N];
int idFallos[N];
int cant[4] = {0,0,0,0};
sem mutex[4] = {1,1,1,1};

Process Saltarin[id: 1..4] {
    int cantLocal[4] = {0,0,0,0};
    int actual = id;
    while (actual <= N) {
        actual = actual + 4;
        cantLocal[nivelesFallos[actual-1]] ++;
    }
    for i in 0..3 {
        P(mutex(nivelesFallos[i]);
        cant[nivelesFallos[i]] =+ cantLocal[i];
        V(mutex(nivelesFallos[i]);
    }
}
```

##### c)
```
#Esta mal porque claramente no hay concurrencia pero esta fachera
int nivelesFallos[N];
int idFallos[N];
int cant[4] = {0,0,0,0};
sem work[4] = {1,0,0,0};
int inicio = true;
int actual = 0;

Process Gusanito[id: 1..4] {
    while True {
        P(work[id-1]);
        if inicio {
            inicio = false;
            V(work[nivelesFallos[0]);
        } else {
            cant[id-1]++;
            actual++;
            V(work[nivelesFallos[actual]);
        }
    }
}

#Version concurrente
int nivelesFallos[N];
int idFallos[N];
int cant[4] = {0,0,0,0};

Process Worker[id: 1..4] {
    int cantLocal = 0;
    for i in 1..N {
        if (nivelesFallos[i-1] == (id-1)) {
            cantLocal++;
        }
    }
    cant[id-1]+=cantLocal;
}
```

### 3)
```
#Las instancias se encuentran encoladas
cola inst;
sem mutex = 1;
sem disp = 5;

Process Worker[id: 0..P-1] {
    P(disp);
    P(mutex);
    recurso = inst.pop();
    V(mutex);
    #Usa recurso
    P(mutex);
    inst.push(recurso);
    V(mutex);
    V(disp);
}
```

### 4)
Ausencia de espera innecesaria: No se cumple, Si entran 6 de prioridad alta y un instante despues 2 de prioridad baja, los ultimos deben esperar a que se liberen lugares de total, por mas de que solo se usen 4 recursos.

Solucion: Preguntar primero por alta o baja respectivamente y luego por total.

Siempre se pregunta por el especifico y luego por el general.

### 5)

##### a)
```
paquete cola[N];
sem lleno = N;
sem vacio = 0;

Process Preparador {
    int i = 0;
    while (true) {
        paq = preparar();
        P(lleno);
        cola[i] = paq;
        V(vacio);
        i = (i+1) mod N;
    }
}

Process Entregador {
    int j = 0;
    while (true) {
        P(vacio);
        paq = cola[j];
        V(lleno);
        j = (j+1) mod N;
        entregar(paq);
    }
}
```

##### b)
```
paquete cola[N];
int i = 0;
int j = 0;
sem no_lleno = N;
sem lleno = 0;

Process Preparador {
    paq = preparar();
    P(no_lleno);
    cola[i] = paq;
    V(lleno);
    i = (i+1) mod N;
}

Process Entregador {
    P(lleno);
    paq = cola[j];
    V(no_lleno);
    j = (j+1) mod N;
    entregar(paq);
}
```
