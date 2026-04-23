#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define N 100000000

//Para calcular tiempo
double dwalltime(){
        double sec;
        struct timeval tv;

        gettimeofday(&tv,NULL);
        sec = tv.tv_sec + tv.tv_usec/1000000.0;
        return sec;
}

int main(int argc,char*argv[]){
    double *A,*B,*C;
    long long int i;
    int check=1;
    double timetick;

    //Aloca memoria para los vectores
    A=(double*)malloc(sizeof(double)*N);
    B=(double*)malloc(sizeof(double)*N);
    C=(double*)malloc(sizeof(double)*N);

    //Inicializa los vectores en 1, el resultado será una vector con todos sus valores en 2
    for(i=0;i<N;i++)
          B[i] = 1;
    for(i=0;i<N;i++)
          C[i] = 1;

    //Realiza la multiplicacion
    timetick = dwalltime();

    for(i=0;i<N;i++)
        A[i] = B[i] + C[i];

    double time = dwalltime() - timetick;

    printf("Suma de vectores de dimensión %d. Tiempo en segundos %f\n",N,time);

    //Verifica el resultado
    for(i=0;i<N;i++)
        check=check&&(A[i]==2);

    if(check){
        printf("Suma de vectores resultado correcto\n");
    } else {
        printf("Suma de vectores resultado erroneo\n");
    }

    free(A);
    free(B);
    free(C);
    return(0);
}
