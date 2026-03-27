/* Blocked matrix multiplication example */
/* Fernando G. Tinetti                   */

#include<stdio.h>
#include<stdlib.h>   /* malloc() */
#include <sys/time.h>


#define BS 16 

/* Init square matrix with a specific value */
void initvalmat(double *mat, int n, double val, int transpose); 
 
/* Multiply square matrices, blocked version */
void matmulblks(double *a, double *b, double *c, int n);

/* Multiply (block)submatrices */
void blkmul(double *ablk, double *bblk, double *cblk, int n);

/* Time in seconds from some point in the past */
double dwalltime();



/************** MAIN *************/
int main(int argc, char *argv[])
{
  double *a, *b, *c;
  int n, i, j;

  double timetick;

  /* Check command line parameters */
  if ( (argc != 2) || ((n = atoi(argv[1])) <= 0) || ((n % BS) != 0))
  {
    printf("\nError en los parámetros. Usage: ./%s N (N debe ser multiplo de BS)\n", argv[0]);
    exit(1);
  }

  /* Getting memory */  
  a = (double *) malloc(n*n*sizeof(double));
  b = (double *) malloc(n*n*sizeof(double));
  c = (double *) malloc(n*n*sizeof(double));

  /* Init matrix operands */
  initvalmat(a, n, 1.0, 0);
  initvalmat(b, n, 1.0, 1);

 // printf("Multiplying %d x %d matrices\n", n, n);
  
  timetick = dwalltime();
  
  matmulblks(a, b, c, n);
  
  double workTime = dwalltime() - timetick;

  /* Check results (just in case...) */
  for (i = 0; i < n; i++)
  {
    for (j = 0; j < n; j++)
    {
      if (c[i*n + j] != n)
      {
        printf("Error at %d, %d, value: %f\n", i, j, c[i*n + j]);
      }
    }
  }

  printf("MMBLK-SEC-CONST;%d;%d;%lf;%lf\n",n,BS,workTime,((double)2*n*n*n)/(workTime*1000000000));

  return 0;
}

/*****************************************************************/

/* Init square matrix with a specific value */
void initvalmat(double *mat, int n, double val, int transpose)
{
  int i, j;      /* Indexes */

	if (transpose == 0) {
	  for (i = 0; i < n; i++)
	  {
		for (j = 0; j < n; j++)
		{
		  mat[i*n + j] = val;
		}
	  }
	} else {
	  for (i = 0; i < n; i++)
	  {
		for (j = 0; j < n; j++)
		{
		  mat[j*n + i] = val;
		}
	  }
	}
}

/*****************************************************************/

/* Multiply square matrices, blocked version */
void matmulblks(double *a, double *b, double *c, int n)
{
  int i, j, k;    /* Guess what... */

  /* Init matrix c, just in case */  
  initvalmat(c, n, 0.0, 0);
  
  for (i = 0; i < n; i += BS)
  {
    for (j = 0; j < n; j += BS)
    {

      for  (k = 0; k < n; k += BS)
      {
        blkmul(&a[i*n + k], &b[j*n + k], &c[i*n + j], n);
      }
    }
  }
}

/*****************************************************************/

/* Multiply (block)submatrices */
void blkmul(double *ablk, double *bblk, double *cblk, int n)
{
  int i, j, k;    /* Guess what... again... */

  for (i = 0; i < BS; i++)
  {
    for (j = 0; j < BS; j++)
    {
      for  (k = 0; k < BS; k++)
      {
        cblk[i*n + j] += ablk[i*n + k] * bblk[j*n + k];
      }
    }
  }
}
    
/*****************************************************************/


double dwalltime()
{
	double sec;
	struct timeval tv;

	gettimeofday(&tv,NULL);
	sec = tv.tv_sec + tv.tv_usec/1000000.0;
	return sec;
}
