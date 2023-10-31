#8) *Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y
#retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1

.data
CADENA1: .asciiz "HOLA COMO ESTAS CARLOS"
CADENA2: .asciiz "HOLA COMO ESTAS MATEO"
POS: .word 0

.code
daddi $a0, $0, CADENA1
daddi $a1, $0, CADENA2
jal COMPARAR
sd $v0, POS($0)
halt

COMPARAR: dadd $v0,$0,$0    #$v0=0
LOOP:
lbu $t0,0($a0)              #$t0=CADENA1[$a0]
lbu $t1,0($a1)              #$t1=CADENA2[$a1]
bne $t0,$t1, RETORNAR
beqz $t0, IGUALES
daddi $v0,$v0,1             #$v0+1
daddi $a0,$a0,1             #$a0+1
daddi $a1,$a1,1             #$a1+1
j LOOP

IGUALES:
daddi $v0,$0,-1
RETORNAR:
jr $ra