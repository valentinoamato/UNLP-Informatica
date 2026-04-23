#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define N 1000000000

//Para calcular tiempo
double dwalltime(){
        double sec;
        struct timeval tv;

        gettimeofday(&tv,NULL);
        sec = tv.tv_sec + tv.tv_usec/1000000.0;
        return sec;
}

int main(int argc,char*argv[]){
    int *V, x;
    int ocurrencias = 0;
    long long int i;
    double timetick;

    if (argc != 2) {
        fprintf(stderr, "Nao Nao Amigao, voce tem que usar ./piipipi x\n");
        exit(1);
    }

    //Aloca memoria para los vectores
    V=(int*)malloc(sizeof(int)*N);

    //Inicializa el vector
    for(i=0;i<N;i++)
          V[i] = i % 6;

    //Realiza la multiplicacion
    timetick = dwalltime();

    for(i=0;i<N;i++) {
        if (V[i] == x)
            ocurrencias++;
    }

    double time = dwalltime() - timetick;

    printf("N = %d, Ocurrencias = %d. Tiempo en segundos %f\n",N, ocurrencias,time);

    free(V);
    return(0);
}

