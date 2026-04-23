#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <pthread.h>

double dwalltime();

// Tamaño de lado de las matrices
#define N 2048
//Threads
#define T 8

//Variables compartidas
double *a, *b, *c, *bt;


pthread_barrier_t barrier;

void* mul(void *arg);

void printm(double *m) {
    int i, j;
    for (i=0;i<N;i++) {
        printf("(");
        for (j=0;j<N;j++) {
            printf("%.2f", m[i*N + j]);
            if (j<(N-1))
                printf(", ");
        }
        printf(")\n");
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
    if (((N * N) % T) != 0) {
        fprintf(stderr, "No: N must be multiple of T.");
        exit(1);
    }
    double  acum, timetick, prom;
    int i, j, k;

    // Alocación de memoria para matrices
    a = (double*) malloc(sizeof(double) * N * N);
    b = (double*) malloc(sizeof(double) * N * N);
    bt = (double*) malloc(sizeof(double) * N * N);
    c = (double*) malloc(sizeof(double) * N * N);

    int  ids[T];
    pthread_t threads[T];

    pthread_barrier_init(&barrier, NULL, T);

    /*
     Inicializa:
     matriz a con celda (i,j) = i
     matriz b con celda (i,j) = j
    */
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i*N + j] = i;
            b[i*N + j] = j;
        }
    }


    timetick = dwalltime();

    /* Crea los hilos */
    for (i = 0; i < T; i++) {
        ids[i] = i;
        pthread_create(&threads[i], NULL, mul, &ids[i]);
    }

    for (i = 0; i < T; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("Operación realizada con matrices de %dx%d. Tiempo en segundos: %f\n", N, N, dwalltime() - timetick);

    // Imprimir el promedio de la matriz resultado
    // Permite estimar con cierta probabilidad si el resultado es correcto
    prom=0;
    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            prom+=c[i*N+j]/(N*N);
        }
    }
    printf("Prom R = %f\n", prom);

    // Si el programa recibe "1" como argumento imprimimos la matriz r
    if ((argc == 2) && (atoi(argv[1]) == 1)) {
        printf("\nResultado:\n");
        printm(c);
    }

    pthread_barrier_destroy(&barrier);
    free(a);
    free(b);
    free(bt);
    free(c);
    exit(0);
}

void* mul(void *arg) {
    int id = *(int*)arg;
    int chunk = (N * N) / T;
    int start = id * chunk;
    int end = start + chunk;
    int i, j, k, l;
    double acum;

    // Carga de Bt
    for (l = start; l < end; l++) {
        j = l % N;
        i = l / N;
        bt[j*N + i] = b[l];
    }

    //Espero a que bt este cargada
    pthread_barrier_wait(&barrier);

    //Multiplicacion
    for (l = start; l < end; l++) {
        acum = 0.0;
        j = l % N;
        i = l / N;
        for(k=0;k<N;k++){
            acum+=a[i*N + k] * bt[j*N + k];
        }
        c[l] = acum;
    }

    pthread_exit(NULL);
}

double dwalltime() {
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}

