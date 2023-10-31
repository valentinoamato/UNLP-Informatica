.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

.code
l.d f1, n1(r0)
l.d f2, n2(r0)
add.d f3, f2, f1
mul.d f1,f2,f1
mul.d f4, f2, f1
s.d f3, res1(r0)
s.d f4, res2(r0)
halt

#d) Modificar el programa agregando la instrucción mul.d f1, f2, f1 entre las instrucciones add.d y mul.d.
#Repetir la ejecución y observar los resultados. ¿Por qué aparece un atasco tipo WAR
#
#D) Aparece un atasco de tipo WAR porque la instruccion agregada escribe f1, y la instruccion anterior lo lee.