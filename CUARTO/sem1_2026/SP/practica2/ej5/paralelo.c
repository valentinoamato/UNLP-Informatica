#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<pthread.h>
#include<semaphore.h>

//Tamaño del vector
#define N 100000000
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

double *V, x;
double prom = 0.0;
double min = __DBL_MAX__;
double max = __DBL_MAX__ * -1.0;

sem_t sem;

int main(int argc,char*argv[]){
    long long int i;
    double timetick;

    int  ids[T];
    pthread_t threads[T];

    sem_init(&sem, 0, 1);

    //Aloca memoria para los vectores
    V=(double*)malloc(sizeof(double)*N);

    //Inicializa el vector
    for(i=0;i<N;i++)
          V[i] = i;

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

    printf("N = %d, Min = %f, Max = %f, Prom = %f. Tiempo en segundos %f\n",N, min, max, prom,time);

    sem_destroy(&sem);

    free(V);
    return(0);
}

void* laburar(void *arg) {
    int id = *(int*)arg;
    long double sum = 0.0;
    double lmin, lmax;

    long long int i;
    int slice = N / T;
    int from = id * slice;
    int to = from + slice;

    lmin = lmax = V[from];
    sum += V[from];

    for(i=from+1;i<to;i++) {
        if (V[i] > lmax) {
            lmax = V[i];
        } else if (V[i] < lmin) {
            lmin = V[i];
        }
        sum+=V[i];
    }

    sem_wait(&sem);
    if (lmax > max) {
        max = lmax;
    }
    if (lmin < min) {
        min = lmin;
    }
    prom+=sum/N;
    sem_post(&sem);

    pthread_exit(NULL);
}
