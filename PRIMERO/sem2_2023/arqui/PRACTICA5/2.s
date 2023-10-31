#2) *Es posible convertir valores enteros almacenados en alguno de los registros r1-r31 a su representación equivalente
#en punto flotante y viceversa. Describa la funcionalidad de las instrucciones mtc1, cvt.l.d, cvt.d.l y mfc1.

##2) Si, es posible
#mtc1 rf, fd :  Copia los 64 bits del registro entero rf al registro fd de punto flotante
#mfc1 rd, ff :  Copia los 64 bits del registro ff de punto flotante al registro rd entero
#cvt.d.l fd, ff : Convierte a punto flotante el valor entero copiado al registro ff, dejándolo en fd
#cvt.l.d fd, ff : Convierte a entero el valor en punto flotante contenido en ff, dejándolo en fd