.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

.code
l.d f1, n1(r0)
l.d f2, n2(r0)
add.d f3, f2, f1
mul.d f4, f2, f1
s.d f3, res1(r0)
s.d f4, res2(r0)
halt

#a) Tomar nota de la cantidad de ciclos, instrucciones y CPI luego de la ejecución del programa.
#b) ¿Cuántos atascos por dependencia de datos se generan? Observar en cada caso cuál es el dato en conflicto y las
#instrucciones involucradas.
#c) ¿Por qué se producen los atascos estructurales? Observar cuales son las instrucciones que los generan y en qué
#etapas del pipeline aparecen.
#
#A) Ciclos: 16, Instrucciones: 7, CPI: 2.286
#
#B) Se generan 4 atascos de tipo RAW ya que las operaciones SD deben esperar a que terminen las aritmeticas
#
#C) Los atascos estructurales se generan por que una instruccion B que se inicia despues que otra instruccion A, e intenta 
#   acceder a memoria antes que A. Por lo que se debe poner en pausar el acceso a memoria de B hasta que A haya terminado
#   el suyo.