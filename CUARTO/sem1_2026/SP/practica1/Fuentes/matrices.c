#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define ORDENXFILAS 0
#define ORDENXCOLUMNAS 1

//Retorna el valor de la matriz en la posicion fila y columna segun el orden que este ordenada
#define getValor(matriz, fila, columna, n, orden) \
    ( ((orden) == ORDENXFILAS) ? \
      (matriz)[(fila)*(n) + (columna)] : \
      (matriz)[(fila) + (columna)*(n)] )


//Establece el valor de la matriz en la posicion fila y columna segun el orden que este ordenada
#define setValor(matriz, fila, columna, n, orden, valor) \
    do { \
        if ((orden) == ORDENXFILAS) \
            (matriz)[(fila)*(n) + (columna)] = (valor); \
        else \
            (matriz)[(fila) + (columna)*(n)] = (valor); \
    } while (0)

//Para calcular tiempo
double dwalltime();


//Retorna el valor de la matriz en la posicion fila y columna segun el orden que este ordenada
//double getValor(double *matriz,int fila,int columna, int n, int orden);

//Establece el valor de la matriz en la posicion fila y columna segun el orden que este ordenada
//void setValor(double *matriz, int fila,int columna, int n, int orden, double valor);


int main(int argc,char*argv[]){
	double *a,*b,*c;
	int i,j,k, n;
	int check=1, print;
	double timetick;

 //controla los argumentos al programa
	if ((argc != 3) || ((n = atoi(argv[1])) <= 0) || ((print = atoi(argv[2])) < 0) || (print > 1)) {
		printf("\nUsar: %s n print\n  n: Dimension de la matriz (nxn X nxn)\n  print: 1 imprime matrices | 0 no imprime matrices (nxn X nxn)\n", argv[0]);
		exit(1);
	}

	//aloca memoria para las matrices
	a=(double*)malloc(sizeof(double)*n*n);
	b=(double*)malloc(sizeof(double)*n*n);
	c=(double*)malloc(sizeof(double)*n*n);

	for(i=0;i<n;i++)
		for(j=0;j<n;j++) {
	// Inicializa la matriz a y b de forma tal que la celda (i,j) tiene valor i
			setValor(a,i,j,n,ORDENXFILAS,i);
	// Inicializa la matriz b de forma tal que la celda (i,j) tiene valor j
			setValor(b,i,j,n,ORDENXCOLUMNAS,j);
        }

	if (print == 1) {
		// Imprime matriz a en forma lógica
		printf("Matriz A\n");
		for(i=0;i<n;i++) {
			for(j=0;j<n;j++) 
				printf("%f\t",getValor(a,i,j,n,ORDENXFILAS));
			printf("\n");
		}
		printf("\n");
		// Imprime matriz a en forma física (como está en la memoria)
		for(i=0;i<n*n;i++) 
			printf("%f\t",a[i]);
		printf("\n\n");
		printf("Matriz B\n");
		// Imprime matriz b en forma lógica
		for(i=0;i<n;i++) {
			for(j=0;j<n;j++) 
				printf("%f\t",getValor(b,i,j,n,ORDENXCOLUMNAS));
			printf("\n");
		}
		printf("\n");
		// Imprime matriz b en forma física (como está en la memoria)
		for(i=0;i<n*n;i++) 
			printf("%f\t",b[i]);
		printf("\n\n");

	}

	//Realiza la multiplicacion
	timetick = dwalltime();

        double c_acum;
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			setValor(c,i,j,n, ORDENXFILAS,0);
                        c_acum = 0;
			for(k=0;k<n;k++){
                                c_acum+=getValor(a,i,k,n,ORDENXFILAS)*getValor(b,k,j,n,ORDENXCOLUMNAS);
			}
			setValor(c,i,j,n,ORDENXFILAS, c_acum);
		}
	}   

	printf("Multiplicacion de matrices de %dx%d. Tiempo en segundos %f\n",n,n, dwalltime() - timetick);

	//Verifica el resultado. Con la inicialización realizada, la celda (i,j) de c debería tener valor i*j*n
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			check=check&&(getValor(c,i,j,n,ORDENXFILAS)==(i*j*n));
		}
	}   

	if(check)
		printf("Multiplicacion de matrices resultado correcto\n");
	else
		printf("Multiplicacion de matrices resultado erroneo\n");
	

	 free(a);
	 free(b);
	 free(c);
	 return(0);
}



//Para calcular tiempo
double dwalltime(){
        double sec;
        struct timeval tv;

        gettimeofday(&tv,NULL);
        sec = tv.tv_sec + tv.tv_usec/1000000.0;
        return sec;
}

/*
//Retorna el valor de la matriz en la posicion fila y columna segun el orden que este ordenada
double getValor(double *matriz,int fila,int columna, int n, int orden){
	if(orden==ORDENXFILAS)
		return(matriz[fila*n+columna]);
	else
		return(matriz[fila+columna*n]);
 }

//Establece el valor de la matriz en la posicion fila y columna segun el orden que este ordenada
void setValor(double *matriz,int fila,int columna, int n, int orden,double valor){
	if(orden==ORDENXFILAS)
		matriz[fila*n+columna]=valor;
	else
		matriz[fila+columna*n]=valor;
}
*/
