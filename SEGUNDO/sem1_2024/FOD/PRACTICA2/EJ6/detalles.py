#Genera los 5 archivos detalle
import os
from random import randint

path = os.path.dirname(os.path.realpath(__file__))

for i in range(5):
    with open(f'{path}/detalles/detalle{i+1}.txt', 'w') as det:

        for j in range(15):
            for k in range(randint(0,3)):
                det.write(f"{j+1} {randint(1,7)} {randint(1,10)}\n")
    