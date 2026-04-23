#include<stdio.h>
#include<stdlib.h>
#include<float.h>
#include<pthread.h>
#include<sys/time.h>

#define MAX_THREADS 100

int T=MAX_THREADS ;


void * hello_word (void * ptr) ;

int main(int argc,char*argv[]){

 int i,j,k, ret;
 double timetick;
      int  ids[MAX_THREADS];
    pthread_attr_t attr;
    pthread_t threads[MAX_THREADS];
	 int *status;

 //Controla los argumentos al programa
 if ((argc != 2) || ((T = atoi(argv[1])) <= 0) )
  {
    printf("\nUsar: %s T\n  T: cantidad de hilos\n", argv[0]);
    exit(1);
  }

 	pthread_attr_init(&attr); 

    /* Crea los hilos */
    for (i = 0; i < T; i++) {
	    ids[i] = i;
        pthread_create(&threads[i], &attr, hello_word, &ids[i]);
    }

    /* Espera a que los hilos terminen */
    for (i = 0; i < T; i++) {
        pthread_join(threads[i], (void*) &status);
		printf("\n Hilo %d retornó %d",i,(*status));
	}

 return(0);
}


void * hello_word (void * ptr) {
	
	int * p, id;
    p = (int *) ptr;
    id = *p;

	printf("\nHola mundo! Soy el hilo %d.",id);
	
    pthread_exit((void*)ptr);
}