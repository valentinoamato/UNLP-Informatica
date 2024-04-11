#Genera los 100 archivos detalle
import os
from random import randint

path = os.path.dirname(os.path.realpath(__file__))

for i in range(50):
    with open(f'{path}/detalles/nacimiento{i+1}.txt', 'w') as det:
        pass 
for i in range(50):
    with open(f'{path}/detalles/fallecimiento{i+1}.txt', 'w') as det:
        pass 


fallecidos = 0

for i in range(500): 

    with open(f'{path}/detalles/nacimiento{randint(1,50)}.txt', 'a') as det:
        det.write(f'{i+1}\n')

    if (randint(0,1)==1):
            fallecidos+=1
            with open(f'{path}/detalles/fallecimiento{randint(1,50)}.txt', 'a') as det:
                det.write(f'{i+1}\n')
print('fallecidos: ',fallecidos)

