#11) Escribir una subrutina que reciba como argumento una tabla de números terminada en 0. La subrutina debe contar la
#cantidad de números que son impares en la tabla. Ésta condición se debe verificar usando la subrutina ES_IMPAR. La
#subrutina ES_IMPAR debe devolver 1 si el número es impar y 0 si no lo es

.data
TABLA: .word 1,2,3,4,54,66,77,100,321,543,0
IMPARES: .word 0

.code
daddi $sp,$0,0x400
daddi $a1,$0,TABLA
jal CONTAR_IMPARES
sd $v1,IMPARES($0)
halt

#|||||CONTAR IMPARES|||||
CONTAR_IMPARES: 

daddi $sp,$sp,-8                #PUSH RA
sd $ra,0($sp)

LOOP:
lbu $a0,0($a1)
beqz $a0,RETORNAR 

jal ES_IMPAR
dadd $v1,$v1,$v0
daddi $a1,$a1,8
j LOOP

RETORNAR:
ld $ra,0($sp)                   #POP RA
daddi $sp,$sp,8                

jr $ra
#|||||CONTAR IMPARES|||||

#|||||ES IMPAR|||||
ES_IMPAR: andi $v0,$a0,1
jr $ra
#|||||ES IMPAR|||||