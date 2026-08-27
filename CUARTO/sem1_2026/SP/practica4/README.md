## Practica 4
### 2)
| np | blocking | nonblocking |
| -- | -- | -- |
| 4 | 6s | 6s|
| 8 | 14s | 14s|
| 16 | 30s | 30s|

Cuando se remueve la linea 52:
```c
MPI_Wait(&request, &status);
```
No se espera a que la operacion de recepcion termine y entonces nunca se recibe ningun mensaje, sino que el programa imprime el valor previo del buffer.

### 3)
El tiempo de la comunicacion es mayor en la version bloqueante ya que en esta los procesos esperan a recibir para enviar.
