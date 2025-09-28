## Practica 3

### 1)
##### a)
Funciona porque el proceso que se despierta del await vuelve a chequear la condicion por la cual se fue a dormir.

##### b) 
Si. Si. Si. Si.
```
Monitor Puente {
    Procedure entrar(id: in) {
        //El auto id cruza el puente
    }
}

Process Auto [a: 1..M] {
    Puente.entrar(a);
}
```

##### c)
No. No.

### 2)
```
Monitor BD {
    int cant = 0;
    cond cola;

    Procedure entrar() {
        while (cant = 5) {
            wait(cola);
        }
        cant = cant + 1;
    }

    Procedure salir() {
        cant = cant – 1;
        signal(cola);
    }
}

Process Lector [id: 1..N] {
    BD.entrar();
    //Leer la bd
    BD.salir();
}
```

### 3)
##### a) 
```
Monitor Fotocopiadora {
    Procedure usar() {
        Fotocopiar();
    }
}

Process Persona[id: 1..N] {
    Fotocopiadora.usar();
}
```

##### b)
```
//No hace falta la cola, ni el array de variables de condicion
Monitor Fotocopiadora {
    cond personas[N]
    cola turnos;
    bool libre = true;

    Procedure entrar(id: in) {
        if (!libre) {
            turnos.push(id);
            wait(personas[id]);
        }
        libre = false;
    }

    Procedure salir() {
        if (turnos.isEmpty()) {
            libre = true;
        } else {
            next = turnos.pop();
            signal(personas[next];
        }
    }
}

Process Persona[id: 0..N-1] {
    Fotocopiadora.entrar(id);
    Fotocopiar();
    Fotocopiadora.salir();
}
```

##### c)
```
Monitor Fotocopiadora {
    cond personas[N]
    colaPrioridad turnos; //Cola con prioridad por edad
    bool libre = true;

    Procedure entrar(id: in, edad: in) {
        if (!libre) {
            turnos.push(id, edad);
            wait(personas[id]);
        }
        libre = false;
    }

    Procedure salir() {
        if (turnos.isEmpty()) {
            libre = true;
        } else {
            next = turnos.pop();
            signal(personas[next];
        }
    }
}

Process Persona[id: 0..N-1] {
    Fotocopiadora.entrar(id, edad);
    Fotocopiar();
    Fotocopiadora.salir();
}
```

##### d)
```
Monitor Fotocopiadora {
    cond next;
    int actual = 0;

    Procedure entrar(id: in) {
        //Cada vez que termina uno me fijo si es mi turno, sino sigo mimiendo
        while (actual != id) {
            wait(next);
        }
    }

    Procedure salir() {
        //Actualizo el turno actual y despierto a todos
        actual++;
        signalAll(next);
    }
}

Process Persona[id: 0..N-1] {
    Fotocopiadora.entrar(id);
    Fotocopiar();
    Fotocopiadora.salir();
}
```

##### e)
```
Monitor Empleado {
    cond personas[N]
    cola turnos;
    bool libre = true;

    Procedure pedirTurno(id: in) {
        if (!libre) {
            turnos.push(id);
            wait(personas[id]);
        }
        libre = false;
    }

    Procedure avisarFinDeUso() {
        if (turnos.isEmpty()) {
            libre = true;
        } else {
            next = turnos.pop();
            signal(personas[next];
        }
    }
}

Process Persona[id: 0..N-1] {
    Empleado.pedirTurno(id);
    Fotocopiar();
    Empleado.avisarFinDeUso();
}
```

##### f)
```
Monitor Fotocopiadora[id: 0..9] {
    Procedure usar() {
        Fotocopiar();
    }
}

Monitor Empleado {
    cond personas[N]
    cola turnos;
    cola impresoras; //Se asume que inica con las 10 impresoras encoladas

    Procedure pedirTurno(id: in, idImp: out) {
        //Si no hay impresoras o hay alguien esperando, hago fila
        if ((impresoras.isEmpty()) || (!turnos.isEmpty())) {
            turnos.push(id);
            wait(personas[id]);
        }
        idImp = impresoras.pop();
    }

    Procedure avisarFinDeUso(idImp: in) {
        //Si hay alguien esperando lo despierto
        if (!turnos.isEmpty()) {
            next = turnos.pop();
            signal(personas[next];
        }
        impresoras.push(idImp); //Encolo la impresora usada
    }
}

Process Persona[id: 0..N-1] {
    int idImp;
    Empleado.pedirTurno(id, idImp);
    Fotocopiadora[idImp].usar();
    Empleado.avisarFinDeUso(idImp);
}
```

### 4)
```

Monitor Puente {
    int pesoTotal = 0; //Peso soportado actualmente
    cond autos[N]; //Para avisar a los autos que pasen
    cola turnos;
    int despertarA = -1; //Proximo auto que debe pasar
    bool yaDesperte = true; //Ya se desperto

    Procedure pasar(id: in, peso: in) {
        //Si no hay espacio o hay alguien esperando, espero
        if (((peso + pesoTotal) > 50000)  || (!turnos.isEmpty())) {
            turnos.push(id);

            repeat {
                wait(personas[id]);
                //Capaz despierto a uno pero todavia no puede pasar
            } until ((peso + pesoTotal) <= 50000);
        }
        //Aviso que no hace falta que me despierten mas
        if (despertarA == id) {
            yaDesperte = true;
        }
        pesoTotal+=peso;
    }

    Procedure salir(peso: in) {
        //Si hay que despertar a uno lo despierto
        if (!yaDesperte) {
            signal(autos[despertarA]);
        } else if (!turnos.isEmpty()) {
            //Si hay alquien esperando le doy el turno
            next = turnos.pop();
            signal(personas[next];
            //Puede ser que cuando se despierte no pueda pasar
            //Asi que hago que el proximo auto que termine lo despierte si hace falta:
            despertarA = next;
            yaDesperte = false;
        }
        pesoTotal-=peso;
    }
}

Process Auto[id: 0..N-1] {
    int peso = getPeso();
    Puente.entrar(id, peso);
    pasar();
    Puente.salir(peso);
}
```

### 5)
##### a)
```
Monitor Empleado {
    Procedure realizarCompra(lista: in, comprobante: out) {
        //Realizar la compra
        comprobante = getComprobante();
        Corralon.termineDeAtender();
    }
}

Monitor Corralon {
    cond personas[N]
    cola turnos;
    bool libre = true;

    Procedure pedirTurno(id: in) {
        //Si hay alguien esperando o el empleado esta ocupado, hago fila
        if ((!libre) || (!turnos.isEmpty())) {
            turnos.push(id);
            wait(personas[id]);
        }
        libre = false;
    }

    Procedure termineDeAtender() {
        //Si hay alguien esperando lo despierto
        if (!turnos.isEmpty()) {
            next = turnos.pop();
            signal(personas[next]);
        } else {
            libre = true;
        }
    }
}

Process Persona[id: 0..N-1] {
    lista l = getLista();;
    comprobante c;
    Corralon.pedirTurno(id);
    Empleado.realizarCompra(l, c);
}
```

##### b)
```
Monitor Empleado[id: 0..E] {
    Procedure realizarCompra(lista: in, comprobante: out) {
        //Realizar la compra
        comprobante = getComprobante();
        Corralon.termineDeAtender(id);
    }
}

Monitor Corralon {
    cond personas[N]
    cola turnos;
    cola empleados; //Se asume que inicia con los ids de empleado encolados

    Procedure pedirTurno(id: in, idEmp: out) {
        //Si no hay empleados o hay alguien esperando, hago fila
        if ((empleados.isEmpty()) || (!turnos.isEmpty())) {
            turnos.push(id);
            wait(personas[id]);
        }
        idEmp = empleados.pop();
    }

    Procedure termineDeAtender(idEmp: in) {
        //Si hay alguien esperando lo despierto
        if (!turnos.isEmpty()) {
            next = turnos.pop();
            signal(personas[next];
        }
        empleados.push(idEmp); //Encolo al empleado que termino la atencion
    }
}

Process Persona[id: 0..N-1] {
    int idEmp;
    lista l = getLista();;
    comprobante c;
    Corralon.pedirTurno(id, idEmp);
    Empleado[idEmp].realizarCompra(l, c);
}
```

##### c)
```
Requerimiento resuelto en el inciso B).
```

### 6)
```
Monitor JTP {
    //Para avisarle a un grupo que su nota esta lista
    cond grupos[0..24];
    cond esperar;
    int llegaron[0..24] = {0,0,...,0};
    int terminaron[0..24] = {0,0,...,0};
    int notas[0..24] = {0,0,...,0};
    int cant = 0; //Cantidad de alumnos que llegaron

    Procedure llegue(grupo: out) {
        //Esperar a que lleguen todos
        cant++;
        if (cant == 50) {
            signalAll(esperar);
            cant = 25;
        } else {
            wait(esperar);
        }

        //Asignar los grupos
        grupo = AsignarNroGrupo();
        //Asignar un numero hasta que haya uno valido
        while (llegaron[grupo] == 2) {
            grupo = AsignarNroGrupo();
        }
        llegaron[grupo]++;
    }

    Procedure corregir(grupo: in, nota: out) {
        terminaron[grupo]++;
        //Si termino mi grupo
        if (terminaron[grupo] == 2) {
            nota = cant; //Guardo la nota del alumno
            notas[grupo] = cant;
            //Despierto al otro alumno
            signal(grupos[grupo]);
            cant--; //Nota del proximo grupo
        } else {
        //Si mi grupo no termino espero
            await(grupos(grupo));
            nota = notas[grupo];
        }
    }
}

Process Alumno[id: 0..49] {
    int nota, grupo;
    JTP.llegue(grupo);
    //Hacer la tarea
    JTP.corregir(grupo,nota);
}

```

### 7)
```
Monitor Carrera {
    int cant = 0;
    cond esperar;

    Procedure llegue() { //Barrera
        cant++;
        if (cant < C) {
            await(esperar);
        } else {
            signalAll(esperar);
        }
    }
}

Monitor Expendedora {
    int cant = 20;
    int esperando = 0; //Personas esperando 
    cond vacio;
    cond lleno;
    cond prox; //Proximo turno
    bool cargando = false; //El repositor esta cargando
    bool libre = true; //La maquina esta libre

    Procedure cargar() {
        if (cargando) {
            if (cant < 19) { //Si falta mas de una
                cant++;
            } else { //Si esta es la ultima
                cant++;
                cargando = false;
                signal(lleno);
            }
        } else if (cant == 0) { //Si no estoy cargando, pero no hay mas tengo que cargar
            cargando = true;
            cant++;
        } else { //Si no estoy cargando, ni tengo que cargar, espero
            await(vacio);
            cargando = true;
            cant++;
        }
    }

    Procedure Tomar() {
        if (!libre) { //Si la maquina no esta libre espero
            esperando++;
            await(prox);
            esperando--;
        }

        if (cant > 0) { //Si hay botellas
            cant--; //Tomo la botella
            if (esperando > 0) { //Si hay alquien esperando le digo que pase
                signal(prox); //Le aviso al proximo que puede pasar
            } else {
                libre = true;
            }

        } else { //Si no hay botellas
            signal(vacio); //Aviso que no hay botellas
            libre = false; //Que nadie se me adelante
            await(lleno); //Espero que se carguen las botellas
            cant--; Tomo la botella
            if (esperando > 0) { //Si hay alquien esperando le digo que pase
                signal(prox); //Le aviso al proximo que puede pasar
            } else {
                libre = true;
            }
        }
    }
}

Process Repositor[id: 0] {
    while (true) {
        Expendedora.cargar();
    }
}

Process Corredor[id: 0..C-1] {
    Carrera.llegue();
    //Correr
    Expendedora.tomar();
}
```

### 8)
```
Monitor Entrenamiento {
    int cant[4] = {0,0,0,0}; //Cantidad de jugadores de cada equipo
    cond esperar[4];
    int canchas[4] = {0,0,0,0}; //Cancha en la que juega cada equipo
    int equipos = 0; //Equipos con canchas asignadas

    Procedure llegue(equipo: in, cancha: out) {
        cant[equipo-1]++;
        if (cant[equipo-1] == 5) { //Si ya estamos todos
            equipos++; //Equipos con canchas asignadas
            cancha = 1 if (equipos < 2) else 2; //Si ya hay dos equipos voy a la cancha 2
            canchas[equipo-1] = cancha; //Guardo la cancha para mis compa;eros
            signalAll(esperar[equipo-1]); //Les aviso que estamos para jugar
        } else {
            await(esperar[equipo-1]); //Espero que llegue el ultimo
            cancha = canchas[equipo-1]; //Agarro el nro de cancha
        }
    }
}

Monitor Cancha[id: 1..2] {
    cond esperar;
    int cant = 0;

    Procedure jugar() {
        cant++;
        if (cant < 10) {
            await(esperar);
        } else {
            sleep(50 * 60);
            signalAll(esperar);
        }
    }
}

Process Jugador[id: 0..19] {
    int equipo = DarEquipo();
    int cancha;
    Entrenamiento.llegue(equipo, cancha);
    //Se dirige a la cancha
    Cancha[cancha].jugar();
}
```

### 9)
```
Monitor Evaluacion {
    int cant = 0;
    Enunciado enunciado;
    cond llegada; //Llegada de los 45 alumnos
    cond entrega; //Entrega del enunciado

    Examen examenActual;
    int notaActual;

    cond profesora; //Para esperar a la profesora
    cond alumno; //Para esperar al alumno
    bool profEsperando = false; //La profesora esta esperando
    int alumEsperando = 0; //Alumnos esperando

    cond nota; //El alumno tiene disponible su nota
    cond listo;  //El alumno recibio su nota


    Procedure pedirEnunciado(enun: out) {//El alumno pide el enunciado
        cant++;
        if (cant < 45) {
            await(llegada);
        } else {
            signalAll(llegada);
        }

        await(entrega); //Espera que el preceptor entregue el enunciado
        enun = enunciado;
    }

    Procedure entregarEnunciado(enun: in) {//El preceptor entrega el enunciado
        enunciado = enun; //Le doy el enunciado a los alumnos
        if (cant == 45) { //Si ya llegaron todos
            signalAll(entrega); //Les aviso que ya tienen el enunciado
        } else {
            await(llegada); //Espero a que lleguen todos
        }
    }

    Procedure solicitarNota(examen: in, miNota: out) {//El alumno solicita nota
        if (!profEsperando) { //Si la profesora no esta esperando
            alumEsperando++;
            await(profesora); //La espero yo a ella
            alumEsperando--;
        }
        examenActual = examen; //Le paso mi examen a la profesora
        signal(alumno); //Le aviso
        await(nota); //Espero que me corriga
        miNota = notaActual; //Guardo mi nota
        signal(listo); //Aviso que ya recibi mi nota
    }

    Procedure corregir(examen: out) { //La profesora toma un examen
        if (alumEsperando == 0) { //Si no hay alumnos esperando
            profEsperando = true;
            await(alumno); //Espero a un alumno
            profEsperando = false;
        } else {
            signal(profesora); //Le aviso que llegue
            await(alumno); //Espero que me de el examen
        }
        examen = examenActual; //Tomo el examen del alumno
    }

    Procedure entregarNota(notaAlum: in) { //La profesora entrega la nota
        notaActual = notaAlum; //Le guardo la nota al alumno;
        signal(nota); //Le aviso que ya esta su nota
        await(listo); //Espero que la reciba
    }
}

Process Alumno[id: 0..44] {
    Enunciado enun;
    Evaluacion.pedirEnunciado(enun);
    //Realizar examen
    int nota;
    Evaluacion.solicitarNota(examen, nota);
}

Process Preceptor[id: 0] {
    Enunciado enun;
    //Hacer el enunciado
    Evaluacion.entregarEnunciado(enun); //Entrega el enunciado
}

Process Profesora[id: 0] {
    for i in 1..45 {
        Examen e;
        int nota;
        Evaluacion.corregir(examen); //Recibe un examen de un alumno
        nota = corregirExamen(nota); //Lo corrige
        Evaluacion.entregarNota(nota); //Entrega la nota
    }
}
```

### 10)
```
Monitor Juego {
    cond empleado; //Esperar al empleado
    cond persona; //Esperar a la persona
    int personaEsperando = 0;

    cond termine; //Esperar a que termine de jugar

    Procedure proximo() { //El empleadodeja pasar a la proxima persona
        if (personaEsperando == 0) { //Si no hay nadie esperando
            await(persona); //Espero a que llegue una persona
        }
        signal(empleado); //Le aviso que puede pasar
        await(esperar); //Espero que termine de jugar
    }

    Procedure llegue() { //La persona llega y espera a poder jugar
        //NO ME FIJO SI YA ESTA EL EMPLEADO:
        //EL ENUNCIADO DICE QUE ESPERO HASTA QUE EL ME AVISE

        signal(persona); //Anuncio mi llegada

        //Espero que el empleado me deje pasar
        personaEsperando++;
        await(empleado);
        personaEsperando--;
    }

    Procedure termine() { //La persona avisa al empleado que termino de jugar
        signal(esperar);
    }
}

Process Persona[id: 0..N-1] {
    Juego.llegue();
    Usar_juego()//
    Juego.termine();
}

Process Empleado[id: 0] {
    for i in 1..N {
        Desinfectar_juego();
        Juego.proximo();
    }
}
```
