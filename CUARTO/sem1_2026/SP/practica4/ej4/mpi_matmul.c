#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define COORDINATOR 0

int main(int argc, char* argv[]){
	int i, j, k, numProcs, rank, n, stripSize, check=1;
	double * a, * b, *c;
	MPI_Status status;
	double commTime, totalTime, tick[4];

	/* Lee parámetros de la línea de comando */
	if ((argc != 2) || ((n = atoi(argv[1])) <= 0) ) {
	    printf("\nUsar: %s size \n  size: Dimension de la matriz y el vector\n", argv[0]);
		exit(1);
	}

	MPI_Init(&argc,&argv);

	MPI_Comm_size(MPI_COMM_WORLD,&numProcs);
	MPI_Comm_rank(MPI_COMM_WORLD,&rank);

	if (n % numProcs != 0) {
		printf("El tamaño de la matriz debe ser multiplo del numero de procesos.\n");
		exit(1);
	}

	// calcular porcion de cada worker
	stripSize = n / numProcs;

	// Reservar memoria
	if (rank == COORDINATOR) {
		a = (double*) malloc(sizeof(double)*n*n);
		c = (double*) malloc(sizeof(double)*n*n);
	}
	else  {
		a = (double*) malloc(sizeof(double)*n*stripSize);
		c = (double*) malloc(sizeof(double)*n*stripSize);
	}
	
	b = (double*) malloc(sizeof(double)*n*n);


	// inicializar datos
	if (rank == COORDINATOR) {
		for (i=0; i<n ; i++)
			for (j=0; j<n ; j++)
				a[i*n+j] = 1;
		for (i=0; i<n ; i++)
			for (j=0; j<n ; j++)
				b[i*n+j] = 1;

	}

	MPI_Barrier(MPI_COMM_WORLD);

	tick[0] = MPI_Wtime();

	/* distribuir datos*/
        MPI_Scatter(
            a,                  /* send buffer on root */
            stripSize * n,      /* elements per process */
            MPI_DOUBLE,
            a,            /* receive buffer */
            stripSize * n,
            MPI_DOUBLE,
            COORDINATOR,
            MPI_COMM_WORLD
        );
        
        MPI_Bcast(
            b,
            n * n,
            MPI_DOUBLE,
            COORDINATOR,
            MPI_COMM_WORLD
        );

	tick[1] = MPI_Wtime();

	/* computar multiplicacion parcial */
	for (i=0; i<stripSize; i++) {
		for (j=0; j<n ;j++ ) {
			c[i*n+j]=0;
			for (k=0; k<n ;k++ ) { 
				c[i*n+j] += (a[i*n+k]*b[j*n+k]); 
			}
		}
	}
		
	tick[2] = MPI_Wtime();

	// recolectar resultados parciales
        MPI_Gather(c, n*stripSize, MPI_DOUBLE, c, n*stripSize, MPI_DOUBLE, COORDINATOR, MPI_COMM_WORLD);

	tick[3] = MPI_Wtime();

	MPI_Finalize();

	if (rank==COORDINATOR) {

		// Check results
		for(i=0;i<n;i++)
			for(j=0;j<n;j++)
				check=check&&(c[i*n+j]==n);

		if(check){
			printf("Multiplicacion de matrices resultado correcto\n");
		}else{
			printf("Multiplicacion de matrices resultado erroneo\n");
		}
		
		totalTime = tick[3] - tick[0];
		commTime = (tick[1] - tick[0]) + (tick[3] - tick[2]);		

		printf("Multiplicacion de matrices (N=%d)\tTiempo total=%lf\tTiempo comunicacion=%lf\n",n,totalTime,commTime);
	}
	
	free(a);
	free(b);
	free(c);

	return 0;
}
