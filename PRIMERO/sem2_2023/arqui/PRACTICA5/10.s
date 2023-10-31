#10) Usando la subrutina escrita en el ejercicio anterior, escriir la subrutina CONTAR_VOC, que recibe una cadena
#terminada en cero y devuelve la cantidad de vocales que tiene esa cadena

.data
CADENA: .asciiz "HOLA JUAN CARLOS COMO ESTAS AA"
RESULTADO: .word 0

.code
daddi $sp,$0,0x400
daddi $a0,$0,CADENA
jal CONTAR_VOC
sd $v1,RESULTADO($0)
halt



#|||||CONTAR VOC|||||
CONTAR_VOC: 
daddi $sp,$sp,-8                 #PUSH RA
sd $ra,0($sp)

dadd $t1,$0,$a0                 #T1=A0
dadd $v1,$0,$0                  #V1=0

LOOP:
lbu $a0,0($t1)                  #A0=CHAR[$t1]
beqz $a0,RETORNAR               #SI CHAR[] = 0

jal ES_VOCAL
dadd $v1,$v1,$v0                 #If vocal v1+1 
daddi $t1,$t1,1                  #T1+1
j LOOP
RETORNAR:
ld $ra,0($sp)                   #POP RA
daddi $sp,$sp,8
jr $ra                          #RET
#|||||CONTAR VOC|||||


#|||||ES VOCAL|||||
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
#|||||ES VOCAL|||||