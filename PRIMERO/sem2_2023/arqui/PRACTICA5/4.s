#4) El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo.
#Se calcula a partir del peso (expresado en kilogramos, por ejemplo: 75,7 kg) y la estatura (expresada en metros,
#por ejemplo 1,73 m), usando la fórmula:
#IMC = peso / (estatura)2
#De acuerdo al valor calculado con este índice, puede clasificarse el estado nutricional de una persona en:
#Infrapeso (IMC < 18,5), Normal (18,5 ≤ IMC < 25), Sobrepeso (25 ≤ IMC < 30) y Obeso (IMC ≥ 30).
#Escriba un programa que dado el peso y la estatura de una persona calcule su IMC y lo guarde en la dirección
#etiquetada IMC. También deberá guardar en la dirección etiquetada estado un valor según la siguiente tabla:
#  IMC   Clasificación Valor guardado
#< 18,5   Infrapeso         1
#< 25     Normal            2
#< 30     Sobrepeso         3
#≥ 30     Obeso             4

.data
PESO: .double 95.7
ESTATURA: .double 1.73
IMC: .double 0.0
ESTADO: .word 0
INFRAPESO: .double 18.5
NORMAL: .double 25
SOBREPESO: .double 30


.code
l.d f0,PESO($0)
l.d f1,ESTATURA($0)
l.d f5,INFRAPESO($0)
l.d f6,NORMAL($0)
l.d f7,SOBREPESO($0)
mul.d f1,f1,f1
div.d f2,f0,f1
s.d f2,IMC($0)

c.lt.d f2,f5
bc1f SIG1
daddi $s0,$0,1
j FIN

SIG1:
c.lt.d f2,f6
bc1f SIG2
daddi $s0,$0,2
j FIN

SIG2:
c.lt.d f2,f7
bc1f SIG3
daddi $s0,$0,3
j FIN

SIG3:
daddi $s0,$0,4

FIN:
sd $s0,ESTADO($0)
halt