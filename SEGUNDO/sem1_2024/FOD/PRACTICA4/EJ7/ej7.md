## Arbol Inicial:
                        2: 0 (220) 1 (390) 4 (455) 5 (541) 3

    0: (10)(150) 1: (225)(241)(331)(360) 4: (400)(407) 5: (508)(533) 3: (690)(823)

### +320:
Lectura N2, lectura N1

Overflow N1, divido y promuevo 320

Lectura N2

Overflow N2, divido y promuevo 390

Escritura N2, escritura N7

                                    7: 2 (390) 8: 

                    2: 0 (220) 1 (320) 6   8: 4 (455) 5 (541) 3

    0: (10)(150) 1: (225)(241)  6: (331)(360) 4: (400)(407) 5: (508)(533) 3: (690)(823)

### -390
Lectura N7

Underflow N7

Lectura N8, lectura N4, Escritura N4

Underflow N4, Concatenacion N4-N5

Lectura N5, Escritura N5, Escritura N8, Escritura N4

Underflow N8, Concatenacion N2-N8

Lectura N8, Escritura N8, Escritura N7, Escritura N2

Escritura N7


                        2: 0 (220) 1 (320) 6 (400) 4 (541) 3

    0: (10)(150) 1: (225)(241)  6: (331)(360) 4: (407)(455)(508)(533) 3: (690)(823)

### -400
Lectura N2, Lectura N4, Escritura N4, Escritura N2


                        2: 0 (220) 1 (320) 6 (407) 4 (541) 3

    0: (10)(150) 1: (225)(241)  6: (331)(360) 4: (455)(508)(533) 3: (690)(823)

### -533
Lectura N2, Lectura N4, Escritura N4


                        2: 0 (220) 1 (320) 6 (407) 4 (541) 3

    0: (10)(150) 1: (225)(241)  6: (331)(360) 4: (455)(508) 3: (690)(823)