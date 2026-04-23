#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<pthread.h>

//Tamaño del vector
#define N 1000000000
//Nro Threads
#define T 8

//Para calcular tiempo
double dwalltime(){
        double sec;
        struct timeval tv;

        gettimeofday(&tv,NULL);
        sec = tv.tv_sec + tv.tv_usec/1000000.0;
        return sec;
}


void* laburar(void *arg);

int *V, x;
int ocurrencias = 0;

pthread_mutex_t mutex;

int main(int argc,char*argv[]){
    long long int i;
    double timetick;

    if (argc != 2) {
        fprintf(stderr, "Nao Nao Amigao, voce tem que usar ./piipipi x\n");
        exit(1);
    }

    int  ids[T];
    pthread_t threads[T];
    pthread_mutex_init(&mutex, NULL);

    //Aloca memoria para los vectores
    V=(int*)malloc(sizeof(int)*N);

    //Inicializa el vector
    for(i=0;i<N;i++)
          V[i] = i % 6;

    //Realiza la multiplicacion
    timetick = dwalltime();


    /* Crea los hilos */
    for (i = 0; i < T; i++) {
        ids[i] = i;
        pthread_create(&threads[i], NULL, laburar, &ids[i]);
    }

    for (i = 0; i < T; i++) {
        pthread_join(threads[i], NULL);
    }

    double time = dwalltime() - timetick;

    printf("N = %d, Ocurrencias = %d. Tiempo en segundos %f\n",N, ocurrencias,time);

    pthread_mutex_destroy(&mutex);

    free(V);
    return(0);
}

void* laburar(void *arg) {
    int id = *(int*)arg;
    int count = 0;

    long long int i;
    int slice = N / T;
    int from = id * slice;
    int to = from + slice;

    for(i=from;i<to;i++) {
        if (V[i] == x)
            count++;
    }

    pthread_mutex_lock(&mutex);
    ocurrencias+=count;
    pthread_mutex_unlock(&mutex);

    pthread_exit(NULL);
}
