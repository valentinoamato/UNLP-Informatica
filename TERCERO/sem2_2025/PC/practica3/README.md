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

##### a) 
```
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
        next = turnos.pop();
        if (next == id) {
            next = turnos.pop();
        }
        
    }
}

Process Persona[id: 0..N-1] {
    Fotocopiadora.entrar(id);
    Fotocopiar();
    Fotocopiadora.salir();
}
```
