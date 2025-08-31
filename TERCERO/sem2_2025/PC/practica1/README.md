# Practica 1
## 6.
Exclusion mutua: Se cumple ya que para que un proceso pueda ejecutar su SC debe ser su turno, y el otro proceso establece este turno luego de ejecutar su SC

Ausencia de deadlock: Nunca los procesos intentan acceder a su SC al mismo tiempo

Ausencia de demora innecesaria: No hay demora, cuando un proceso termina su SC, habilita al otro a que haga lo mismo

Eventual entrada: se cumple ya que SC y SNC son segmentos de codigo finito.

## 7.
```
int actual = -1;
int n;
bool turno[1..n]

Process SC [i = 1..n] {
    while (true) { 
        turno[i] = true;
        while (turno =! i) skip;
        SC;
        turno = -1;
    }
}

Process Cordinador {
    while (true) {
        while (turno =! -1) skip;
        for (j = 1 to n) {
            if (turno[j] == true) {
                turno[j] = false;
                turno = j;
                break;
            }
        }
    }
}
```
