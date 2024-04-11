#Genera los 10 archivos detalle
import os
from random import randint

path = os.path.dirname(os.path.realpath(__file__))

for i in range(10):
    with open(f'{path}/detalles/detalle{i+1}.txt', 'w') as det:

        for j in range(5):
            for k in range(randint(0,3)):
                det.write(f"{j+1} {10+j}.0 2024 4 10\n")
    