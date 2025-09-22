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
