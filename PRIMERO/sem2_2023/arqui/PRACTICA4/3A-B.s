#3) * Analizar el siguiente programa con el simulador MIPS64:
.data
A: .word 1
B: .word 3
.code
ld r1, A(r0)
ld r2, B(r0)
loop: dsll r1, r1, 1
daddi r2, r2, -1
bnez r2, loop
halt
#a) Ejecutar el programa con Forwarding habilitado y responder:
#- ¿Por qué se presentan atascos tipo RAW?
#- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
#- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.
#b) Ejecutar ahora el programa deshabilitando el Forwarding y responder:
#- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y
#durante cuántos ciclos?
#- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ‘loop’?
#Comparar con la ejecución con Forwarding y explicar la diferencia.
#- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI
#con el caso con Forwarding.

#A)
#Por la dependencia de datos entre daddi y bnez con r2
#
#Cuando hay un salto, por defecto el procesador comienza a ejecutar la proxima instruccion. Cuando el resultado del salto es que hay
# que saltar, se debe sacar la instruccion del cauce generando un atasco.
#
#Ciclos: 21, Instrucciones: 12, CPI: 1,750
#
#B)
#La etapa id de la instruccion bnez tiene que esperar a el wb de daddi, generando dos atascos de tipo RAW
#
#El BTS dura un ciclo por cada vuelta del loop en la que se realiza el salto. Al desactivar el Forwarding tambien se incrementan
# los atascos RAW
#
#Ciclos:25, Instrucciones:12, CPI: 2.083
#
#
#
#
#
#