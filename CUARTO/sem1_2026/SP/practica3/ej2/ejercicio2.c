//Ejercicio 2
#include<stdio.h>
#include<stdlib.h>
#include<omp.h>
#include<math.h>


int main(int argc,char*argv[]){
 double x,scale, temp;
 int i;
 int N=atoi(argv[1]);
 int numThreads = atoi(argv[2]);
 omp_set_num_threads(numThreads);
 scale=2.78;
 x=0.0;


 for(i=1;i<=N;i++){
        #pragma omp parallel sections
        {
            #pragma omp section
            {
                temp = 2*x;
            }
            #pragma omp section 
            {
                x+=sqrt(i*scale);
            }

        }
	x+= temp;
 }

 printf("\n Resultado: %f \n",x);

 return(0);
}


