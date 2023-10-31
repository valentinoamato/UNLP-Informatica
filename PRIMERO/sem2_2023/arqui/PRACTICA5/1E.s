.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

.code
l.d f1, n1(r0)
l.d f2, n2(r0)
nop
add.d f3, f2, f1
mul.d f1,f2,f1
mul.d f4, f2, f1
s.d f3, res1(r0)
s.d f4, res2(r0)
halt

#e) Explicar por qué colocando un NOP antes de la suma, se soluciona el RAW de la instrucción ADD y como
#consecuencia se elimina el WAR
#
#E) El nop le da tiempo a la instruccion ld de escribir f2 antes de que el add.d lo necesite.
#   Como ahora la instruccion add.d no se retrasa, esta puede leer f1 antes de que exista riesgo de que mul.d lo modifique
#   Por lo que tambien se elimina el atasco WAR.