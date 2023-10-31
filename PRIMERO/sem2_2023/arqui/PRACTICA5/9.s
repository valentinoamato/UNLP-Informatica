#9) *Escriba la subrutina ES_VOCAL que determina si un caracter es vocal o no, ya sea mayúscula o minúscula. La
#rutina debe recibir el caracter y debe retornar el valor 1 si es una vocal ó 0 en caso contrario

.data
CHAR: .ascii "T"
RES: .word 0

.code
lbu $a0,CHAR($0)
jal ES_VOCAL
sd $v0,RES($0)
halt

ES_VOCAL: daddi $t0,$0,0x60
slt $t0,$a0,$t0                 #SET 1 IF CHAR = MAYUS
beqz $t0,ES_MINUS

daddi $a0,$a0,0x20              #Si CHAR es MINUS le sumo 20H para que la comparacion funcione

ES_MINUS:
#CHAR = Aa?
daddi $t0,$0,0x61
beq $a0,$t0,VOCAL

#CHAR = Ee?
daddi $t0,$0,0x65
beq $a0,$t0,VOCAL

#CHAR = Ii?
daddi $t0,$0,0x69
beq $a0,$t0,VOCAL

#CHAR = Oo?
daddi $t0,$0,0x6F
beq $a0,$t0,VOCAL

#CHAR = Uu?
daddi $t0,$0,0x75
beq $a0,$t0,VOCAL

daddi $v0,$0,0
j NO_VOCAL

VOCAL:
daddi $v0,$0,1

NO_VOCAL: jr $ra
