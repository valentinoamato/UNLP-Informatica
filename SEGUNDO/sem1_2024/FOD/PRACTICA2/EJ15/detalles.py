#Genera los 10 archivos detalle
import os
from random import randint

path = os.path.dirname(os.path.realpath(__file__))

for i in range(100):
    with open(f'{path}/detalles/detalle{i+1}.txt', 'w') as det:

        for j in range(2):
            for k in range(randint(0,2)):
                det.write(f"2024 1 {j+1} {k+1} {randint(1,2)}\n")
        for j in range(2):
            for k in range(randint(0,2)):
                det.write(f"2024 1 {j+3} {k+3} {randint(1,2)}\n")
   