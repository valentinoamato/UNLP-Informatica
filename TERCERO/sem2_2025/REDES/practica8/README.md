## Práctica 8
## Capa de Red: Fragmentación - Ruteo

### Fragmentación
#### 1. Se tiene la siguiente red con los MTUs indicados en la misma. Si desde pc1 se envía un paquete IP a pc2 con un tamaño total de 1500 bytes (cabecera IP más payload) con el campo Identification = 20543, responder:
#### ● Indicar IPs origen y destino y campos correspondientes a la fragmentación cuando el paquete sale de pc1
#### ● ¿Qué sucede cuando el paquete debe ser reenviado por el router R1?
#### ● Indicar cómo quedarían los paquetes fragmentados para ser enviados por el enlace entre R1 y R2.
#### ● ¿Dónde se unen nuevamente los fragmentos? ¿Qué sucede si un fragmento no llega?
#### ● Si un fragmento tiene que ser reenviado por un enlace con un MTU menor al tamaño del fragmento, ¿qué hará el router con ese fragmento?



11.
### PC-A (ss)

| Local Address:Port | Peer Address:Port |
|--------------------|-------------------|
| 192.168.1.2:49273  | 190.50.10.63:80 |
| 192.168.1.2:37484  | 190.50.10.63:25   |
| 192.168.1.2:51238  | 190.50.10.81:8080 |

### PC-B (ss)

| Local Address:Port | Peer Address:Port |
|--------------------|-------------------|
| 192.168.1.3:52734  | 190.50.10.81:8081 |
| 192.168.1.3:39275 | 190.50.10.81:8080 |

### RTR-1 (Tabla de NAT)

| Lado LAN              | Lado WAN              |
|-----------------------|-----------------------|
| 192.168.1.2:49273     | 205.20.0.29:25192     |
| 192.168.1.2:51238     | 205.20.0.29:16345     |
| 192.168.1.3:52734     | 205.20.0.29:51091     |
| 192.168.1.2:37484     | 205.20.0.29:41823     |
| 192.168.1.3:39275     | 205.20.0.29:9123      |

### SRV-A (ss)

| Local Address:Port | Peer Address:Port |
|--------------------|-------------------|
| 190.50.10.63:80    | 205.20.0.29:25192 |
| 190.50.10.63:25    | 205.20.0.29:41823 |

### SRV-B (ss)

| Local Address:Port | Peer Address:Port |
|--------------------|-------------------|
| 190.50.10.81:8080  | 205.20.0.29:16345 |
| 190.50.10.81:8081  | 205.20.0.29:51091 |
| 190.50.10.81:8080  | 205.20.0.29:9123  |
