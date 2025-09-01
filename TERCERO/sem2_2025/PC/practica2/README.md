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
sem no_lleno = N;
sem lleno = 0;
sem mutexP = 1;

Process Preparador[id: 1..P] {
    while (true) {
        paq = preparar();
        P(no_lleno);
        P(mutexP);
        cola[i] = paq;
        i = (i+1) mod N;
        V(mutexP);
        V(lleno);
    }
}

Process Entregador {
    int j = 0;
    while (true) {
        P(lleno);
        paq = cola[j];
        V(no_lleno);
        j = (j+1) mod N;
        entregar(paq);
    }
}
```

##### c)
```
paquete cola[N];
sem lleno = N;
sem vacio = 0;
sem mutexE = 1;
int j = 0;

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

Process Entregador[id: 1..E]{
    while (true) {
        P(vacio);
        P(mutexE);
        paq = cola[j];
        j = (j+1) mod N;
        V(mutexE);
        V(lleno);
        entregar(paq);
    }
}
```

##### d)
```
paquete cola[N];
int i = 0;
int j = 0;
sem no_lleno = N;
sem lleno = 0;
sem mutexP = 1;
sem mutexE = 1;

Process Preparador[id: 1..P] {
    while (true) {
        paq = preparar();
        P(no_lleno);
        P(mutexP);
        cola[i] = paq;
        i = (i+1) mod N;
        V(mutexP);
        V(lleno);
    }
}

Process Entregador[id: 1..E]{
    while (true) {
        P(vacio);
        P(mutexE);
        paq = cola[j];
        j = (j+1) mod N;
        V(mutexE);
        V(lleno);
        entregar(paq);
    }
}
```


### 6)
##### a)
```
sem mutex = 1;

Process Persona[id: 1..N] {
    P(mutex);
    Imprimir(documento);
    V(mutex);
}
```

##### b)
```
sem mutexI = 1;
sem mutexC = 1;
sem mutexP[N] = {0 ... 0};
cola turnos;

Process Persona[id: 0..N-1] {
    P(mutexC);
    if turnos.isEmpty() {
        P(mutexI);
        Imprimir(documento);
        V(mutexI);
        V(mutexC);
    } else {
        turnos.push(id);
        next = turnos.pop();
        V(mutexP[next]); 
        V(mutexC);
        
        P(mutexP[id]);
        P(mutexI);
        Imprimir(documento);
        V(mutexI);
    }
}
```

##### c)
```
sem mutexP[N] = {1, 0, 0, 0 ... 0};

Process Persona[id: 0..N-1] {
    P(mutexP[id]);
    Imprimir(documento);
    V(mutexP[id+1]);
}
```

##### d)
```
sem mutexI = 1;
sem mutexC = 1;
sem listo = 0;
sem mutexP[N] = {0 ... 0};
sem hola = 0;
cola turnos;

Process Cordiunador {
    for i in 0..N-1 {
        P(hola);

        P(mutexC);
        next = turnos.pop();
        V(mutexC);

        V(mutexP[next]);
        P(listo);
    }
}

Process Persona[id: 0..N-1] {
    P(mutexC);
    turnos.push(id);
    V(mutexC);
    V(hola);

    P(mutexP[id]);
    P(mutexI);
    Imprimir(documento);
    V(mutexI);
    V(listo);
    }
}
```

##### e)
```
sem mutexC = 1;
sem mutexD = 1;
sem mutexP[N] = {0 ... 0}; #Mutex de las personas
int which[N] = {0 ... 0}; #Comunica la impresora a usar
sem cant = 5;
sem hola = 0;
cola turnos;
cola disp; #Se inicializa con los ids de las impresoras (0,1,2,3,4)

Process Cordinador {
    while (true) {
        P(hola); #Alguien saco turno

        P(mutexC); #Bloqueo la cola de turnos
        next = turnos.pop(); #Me fijo quien saco turno
        V(mutexC);

        P(cant); #Espera que haya una imp disponible

        P(mutexD); #Bloquea la cola de disponibles
        impD = disp.pop(); #Toma una disponible
        V(mutexD);

        which[next] = impD; #Le digo al proceso next que tiene que usar la impresora impD
        V(mutexP[next]); #Le aviso al proceso next que es su turno
}

Process Persona[id: 0..N-1] {
    P(mutexC); #Bloqueo la cola de turnos
    turnos.push(id); #Pido turno
    V(mutexC);
    V(hola); #Aviso al cordinador

    P(mutexP[id]); #Espero a mi turno

    Imprimir(documento, which[id]); #Imprimo

    P(mutexD); #Bloqueo la cola de impresoras
    disp.push(which[id]); #Encolo mi impresora
    V(mutexD);

    V(cant); #Aumento la cantidad
}
```

### 7)
##### a)
```
sem entregar = 0; //Alumno avisa que entrego
sem mutexC = 1; //Mutex de la cola
sem corregir[10] = {0 ... 0}; //Profesor avisa que corrigio un enunciado
int terminaron[10] = {0 ... 0}; //Alumnos que terminaron cada enunciado
int notas[10]; //Nota de cada enunciado
cola colaEntregas; //Numeros de enunciados entregados


Process Alumno[id: 1..50] {
    int enun = elegir(); //Elijo enunciado
    //Realizar tarea

    V(mutexC); //Bloqueo la cola
    colaEntregas.push(enun); //"Entrego"
    P(mutexC);
    V(entregar); //Aviso que entregue

    P(corregir[enun-1]); //Espero la correccion
    int nota = notas[enun-1]; //Obtengo mi nota
}

Process Profe {
    int nota = 10;
    for j in 1..50 {
        P(entregar); //Espero que alguien entregue

        P(mutexC);
        int enun = colaEntregas.pop(); //Veo el enunciado de el que entrego
        V(mutexC);

        terminaron[enun-1]++; //Aumento la cantidad de alumnos que entregaron el enunciado

        //Si ya termino el grupo
        if (terminaron[enun-1] == 5) {
            notas[enun-1] == nota; #Guardo la nota de los alumnos con este enunciado
            for k in 1..5 {
                V(corregir[enun-1]); #Les aviso que corregi
            }
            nota--; //Reduzco la nota
        }
    }
}

//Si llega el profesor tarde funciona igual, gracias cola
```

### 8)
##### b)
```
int cant = 0; //Cantidad de empleados que llegaron
sem mutexCant = 1;
sem llegaron = 0; //Indica si llegaron todos los empleados
sem mutexM = 1;
sem mutexP = 1;
p piezas[T]; //Se asume que contiene las piezas
int indiceP = 0; //Indice actual de piezas[]
int max = 0; //Maximo de piezas
int maxId = -1; //Empleado que hizo mas piezas

Process Empleado[id: 0..E-1] {
    int cantPiezas = 0; //Piezas fabricadas por el empleado

    P(mutexCant); //Bloqueo cant
    cant++; //Llegue
    if (cant == E) { //Si llegaron todos
        V(mutexCant);
        cant == 0; //Reset cant (se usa mas abajo)
        for i in 1..E { //Permitir que continuen todos
            V(llegaron);
        }
    } else {
        V(mutexCant);
    }
    P(llegaron); //Esperar que lleguen todos

    //Mientras haya piezas por fabricar
    while (true) {
        //Bloquear las piezas y tomar una
        P(mutexP);
        if (indiceP < T) {
            p pieza = piezas[indiceP];
            indiceP++;
        } else {
            V(mutexP);
            break;
        }
        V(mutexP);

        //Realizar la pieza

        cantPiezas++;
    }

    //Actualizar el maximo
    P(mutexM);
    if (cantPiezas > max) {
        max = cantPiezas;
        maxId = id;
    }
    V(mutexM);

    //Aumentar la cantidad de empleados que terminaron
    P(mutexCant);
    cant++;

    //Si soy el ultimo, informar el maximo
    if (cant == E) {
        print("El empleado",maxId,"fabrico mas piezas:",max);
    } else {
        V(mutexCant);
    }
}
