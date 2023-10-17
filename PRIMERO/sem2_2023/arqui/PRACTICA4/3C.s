#c) Reordenar las instrucciones para que la cantidad de RAW sea ‘0’ en la ejecución del programa (Forwarding habilitado)
.data
A: .word 1
B: .word 3
.code
ld r2, B(r0)
ld r1, A(r0)
loop: 
daddi r2, r2, -1
dsll r1, r1, 1
bnez r2, loop
halt