#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

double dwalltime();

// Tamaño de lado de las matrices
#define N 2048

    int main(int argc, char *argv[]) {
    double *a, *b, *c, *bt;
    double  acum, timetick, prom;
    int i, j, k;

    // Alocación de memoria para matrices
    a = (double*) malloc(sizeof(double) * N * N);
    b = (double*) malloc(sizeof(double) * N * N);
    bt = (double*) malloc(sizeof(double) * N * N);
    c = (double*) malloc(sizeof(double) * N * N);

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

    // Carga de Bt
    for (i = 0; i < N; i++) {
        int i_n = i*N;
        for (j = 0; j < N; j++) {
            bt[j*N + i] = b[i_n + j];
        }
    }

    for(i=0;i<N;i++){
        for(j=0;j<N;j++){
            acum = 0.0;
            for(k=0;k<N;k++){
                acum+=a[i*N + k] * bt[j*N + k];
            }
            c[i*N + j] = acum;
        }
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
        for (i=0;i<N;i++) {
            printf("(");
            for (j=0;j<N;j++) {
                printf("%.2f", c[i*N + j]);
                if (j<(N-1))
                    printf(", ");
            }
            printf(")\n");
        }
    }

    free(a);
    free(b);
    free(bt);
    free(c);
    exit(0);
}

double dwalltime() {
    double sec;
    struct timeval tv;

    gettimeofday(&tv, NULL);
    sec = tv.tv_sec + tv.tv_usec / 1000000.0;
    return sec;
}
