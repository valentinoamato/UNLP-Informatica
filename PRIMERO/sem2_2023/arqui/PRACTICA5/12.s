#12) El siguiente programa espera usar una subrutina que calcule en forma recursiva el factorial de un número entero:

.data
valor: .word 12
result: .word 0

.code
ld $a0, valor($zero)
jal FACTORIAL
sd $v0, result($zero)
halt

#|||||FACTORIAL|||||
FACTORIAL: daddi $v0,$v0,1      #V0=1

LOOP:
slti $t0,$a0,2                  #Si A0 < 2
bnez $t0, RETORNAR              #RETORNAR

dmulu $v0,$v0,$a0               #N*(N-1)
daddi $a0,$a0,-1                #N-1
j LOOP
RETORNAR:
jr $ra
#|||||FACTORIAL|||||

#(1) La configuración inicial de la arquitectura del WinMIPS64 establece que el procesador posee un bus de direcciones de 10 bits
#para la memoria de datos. Por lo tanto, la mayor dirección dentro de la memoria de datos será de 210 = 1024 = 40016.
#a) *Implemente la subrutina factorial definida en forma recursiva. Tenga presente que el factorial de un número
#entero n se calcula como el producto de los números enteros entre 1 y n inclusive:
#factorial(n) = n! = n x (n-1) x (n-2) x … x 3 x 2 x 1
#b) ¿Es posible escribir la subrutina factorial sin utilizar una pila? Justifique.

#B) Si, es posible y es la resolucion que se planteo en el inciso A.