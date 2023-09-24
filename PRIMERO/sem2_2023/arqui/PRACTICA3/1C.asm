;c) * Escribir un programa que permite encender y apagar las luces mediante las llaves. El programa no
;deberá terminar nunca, y continuamente revisar el estado de las llaves, y actualizar de forma
;consecuente el estado de las luces. La actualización se realiza simplemente prendiendo la luz i si la llave
;i correspondiente está encendida (valor 1), y apagándola en caso contrario. Por ejemplo, si solo la
;primera llave está encendida, entonces solo la primera luz se debe quedar encendida.
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H

ORG 2000H
;CONFIGURACION DE PA COMO ENTRADA
MOV AL, 0FFH
OUT CA, AL
;CONFIGURACION DE PB COMO SALIDA
MOV AL, 0
OUT CB, AL
;MAIN LOOP
LOOP:
IN AL,PA
OUT PB,AL
JMP LOOP
HLT
END
