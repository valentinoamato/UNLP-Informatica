#5) El siguiente programa multiplica por 2 los elementos de un arreglo llamado datos y genera un nuevo arreglo llamado res.
#Ejecutar el programa en el simulador winmips64 con la opción Delay Slot habilitada.
.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0
.code
dadd r1, r0, r0
ld r2, cant(r0)
loop: ld r3, datos(r1)
daddi r2, r2, -1
dsll r3, r3, 1
sd r3, res(r1)
daddi r1, r1, 8
bnez r2, loop
nop
halt
#a) ¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?.
#b) ¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.
#c) Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa.
#
#A)
#Al habilitar el Delay Slot cuando la CPU se encuentra con una instruccion de salto, ejecuta siempre la instruccion que le sigue 
# al salto, independientemente de si hay que saltar o no. De esta manera se eliminan los BTS.
#
#B)
#La instruccion NOP se incluye para que sea ejecutada cada vez que se procesa el salto. Si no estuviera, la instruccion proxima
# al salto seria halt, y de esta manera el programa terminaria y no se daria ningun salto.
#
#C) 
#Ciclos: 61, Instrucciones: 59, CPI: 1.068