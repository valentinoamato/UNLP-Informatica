Comienzo ordenando las redes segun la cantidad de hosts requeridos:
- Red A: 125+2 Hosts
- Red B: 85+2 Hosts
- Red C: 31+2 Hosts
- Red D: 27+2 Hosts

Para la red A necesito 127 hosts, osea que necesito 7 bits de hosts. Tomando esos 7 bits de los 9 bits de hosts que usa 49.183.68.0/23 me quedan 2 bits para la subred:

00110001.11000001.01000100.00000000 Red
11111111.11111111.11111110.00000000 Mascara de red

Divido en 4 subredes

00110001.11000001.0100010|0.0|0000000 -> Red A 49.183.68.0/25
00110001.11000001.0100010|0.1|0000000 -> Red B 49.183.68.128/25
00110001.11000001.0100010|1.0|0000000 -> Libre 49.183.69.0/25
00110001.11000001.0100010|1.1|0000000 -> Libre 49.183.69.128/25
11111111.11111111.11111111.10000000

Como para la red B necesito 87 hosts (>64,<128) necesito 7 bits asi que asigno la segunda subred a la red B. quedan dos redes libres. Como la red C necesita 33 hosts necesito 6 bits de hosts. vuelvo a dividir la primera red libre

00110001.11000001.0100010|1.00|000000 -> Red C 49.183.69.0/26
00110001.11000001.0100010|1.01|000000 -> Libre 49.183.69.64/26


Vuelvo a dividor

00110001.11000001.0100010|1.010|00000 -> Red E 49.183.69.64/27
00110001.11000001.0100010|1.011|00000 -> Red D 49.183.69.96/27

Divido la de arriba para los punto a punto. Necesito 1 de 6 hosts y 2 de 4


00110001.11000001.0100010|1.10000|000 -> 49.183.69.128/29 -> R1-R2-R3
00110001.11000001.0100010|1.10001|000 -> 49.183.69.136/29 -> Libre
00110001.11000001.0100010|1.10010|000 -> 49.183.69.144/29 -> Libre
...
00110001.11000001.0100010|1.11111|000 -> Libre 49.183.69.248/29 -> Libre


00110001.11000001.0100010|1.100010|00 -> R3-R4 49.183.69.136/30 -> Libre
00110001.11000001.0100010|1.100011|00 -> R3-R5 49.183.69.140/30 -> Libre

2:
Destination            Mask        Gateway        Iface
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
48.183.68
0.0.0.0                 /0          

3:
Trama:
Mac Destino: ff:ff:ff:ff
Mac Origen: MAC_R4

APR:
MAC Destino: 00:00:00:00
MAC Origen: MAC_R4
IP Destino: 49.183.69.137
IP Origen: 49.183.69.138
