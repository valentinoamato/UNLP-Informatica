#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<pthread.h>
#include<semaphore.h>

// Vector size
#define N 100000000
// N Threads
#define T 8
// Granularity
#define G T*3


void* mul(void *arg);

//Para calcular tiempo
double dwalltime(){
        double sec;
        struct timeval tv;

        gettimeofday(&tv,NULL);
        sec = tv.tv_sec + tv.tv_usec/1000000.0;
        return sec;
}

//Variables compartidas
double *A,*B,*C;
int current = 0; // Proximo indice C a asignar
int stop = 0; // Fin

sem_t sem;

int main(int argc,char*argv[]){
    long long int i;
    int check=1;
    double timetick;

    int  ids[T];
    pthread_attr_t attr;
    pthread_t threads[T];

    sem_init(&sem, 0, 1);

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

    /* Crea los hilos */
    for (i = 0; i < T; i++) {
        ids[i] = i;
        pthread_create(&threads[i], NULL, mul, &ids[i]);
    }

    for (i = 0; i < T; i++) {
        pthread_join(threads[i], NULL);
    }


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

    sem_destroy(&sem);

    free(A);
    free(B);
    free(C);
    return(0);
}

void* mul(void *arg) {
    int id = *(int*)arg;
    long long int i;
    int slice = N / G;
    int from;
    int to;

    // Si stop se modifica y entro igual no pasa nada
    // No es busy waiting
    while (stop == 0) {
        sem_wait(&sem); // Espero a poder chequear current
        if (current >= (N-1)) {
            stop = 1;
            sem_post(&sem);
        } else {
            from = current;
            current = to = current + slice;
            sem_post(&sem);

            if (to > N)
                to = N;
            for(i=from;i<to;i++)
                A[i] = B[i] + C[i];
        }
    }

    pthread_exit(NULL);
}

