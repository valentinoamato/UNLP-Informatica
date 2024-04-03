#Genera los 30 archivos detalle
import os
from random import randint

path = os.path.dirname(os.path.realpath(__file__))

for i in range(30):
    with open(f'{path}/detalles/detalle{i+1}.txt', 'w') as det:

        for j in range(20):
            for k in range(randint(0,2)):
                det.write(f"{j+1} {randint(1,2)}\n")
    