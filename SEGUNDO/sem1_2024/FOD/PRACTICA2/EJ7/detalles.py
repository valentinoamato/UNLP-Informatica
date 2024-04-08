#Genera los 10 archivos detalle
import os
from random import randint

path = os.path.dirname(os.path.realpath(__file__))

for i in range(10):
    with open(f'{path}/detalles/detalle{i+1}.txt', 'w') as det:

        for j in range(10):
            for k in range(randint(0,2)):
                casos_activos =  randint(5,60)
                casos_nuevos =  randint(1,int(casos_activos*(4/5)))
                recuperados =  randint(1,int(casos_activos*(3/5)))
                fallecidos =  randint(1,int(casos_activos*(1/5)))
                det.write(f"{j+1} {k+1} {casos_activos} {casos_nuevos} {recuperados} {fallecidos}\n")
    