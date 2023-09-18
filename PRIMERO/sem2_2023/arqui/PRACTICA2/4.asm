;4) Lectura de datos desde el teclado.
;Escribir un programa que solicite el ingreso de un número (de un dígito) por teclado e inmediatamente lo muestre en la
;pantalla de comandos, haciendo uso de las interrupciones por software INT 6 e INT 7.
ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?
ORG 1500H
NUM DB ?
ORG 2000H
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
INT 7
MOV BX, OFFSET NUM
INT 6
MOV AL, 1
INT 7
MOV CL, NUM
INT 0
END


;Responder brevemente:

;a) Con referencia a la interrupción INT 7, ¿qué se almacena en los registros BX y AL?
;b) Con referencia a la interrupción INT 6, ¿qué se almacena en BX?
;c) En el programa anterior, ¿qué hace la segunda interrupción INT 7? ¿qué queda almacenado en el registro CL?


;A) En el registro BX se almacena la direccion donde se encuentran almacenados los caracteres a imprimir y en AL se guarda la cantidad de caracteres a imprimir
;B) En BX se almacena la direccion en donde se guardara el caracter ingresado por teclado
;C) La segunda interrupcion INT 7 imprime el caracter que se ingreso. En el registro CL queda almacenado el caracter ingresado.