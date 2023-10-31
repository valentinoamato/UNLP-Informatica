#3) *Escribir un programa que calcule la superficie de un triángulo rectángulo de base 5,85 cm y altura 13,47 cm.
.data
BASE: .double 5.85
ALTURA: .double 13.47
RESULTADO: .double 0.0
DOS: .double 2.0

.code
l.d f0, BASE($0)
l.d f1, ALTURA($0)
l.d f2, DOS($0)
mul.d f3,f0,f1
div.d f3,f3,f2
s.d f3,RESULTADO($0)
HALT