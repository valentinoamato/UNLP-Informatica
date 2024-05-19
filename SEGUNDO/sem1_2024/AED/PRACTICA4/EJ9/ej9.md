>## A - Exprese la función del tiempo de ejecución de cada uno de los siguientes algoritmos, resuélvala y calcule el orden.
### 1-rec1():
T(n) = ((2^n)-1)*cte1

T(n) = O(2^n)

### 2-rec2():
T(n) = n*cte1

T(n) = O(n)

### 3-rec3():
No funciona para ningun n (suponiendo que su funcion sea resolver una potencia de base 2), sea n un numero natural y mayor a 1, si n es par retorna 0, si n es impar retorna 1.

T(n) = (2^(n/2+1)-1)*cte1

T(n) = O(2^n)

### 4-potencia_iter():
T(n) = (n-1)cte1, n>1

T(n) = O(n)

### 5-potencia_rec()
T(n) = (log2(n)+1)cte1, n>0

T(n) = O(log2(n))

>## B - Compare el tiempo de ejecución del método ‘rec2’ con el del método ‘rec1’.

Ok

>## C - Implemente un algoritmo más eficiente que el del método ‘rec3’. (es decir, que el T(n) sea menor).
Dado que la unica utilidad de rec3() es devolver un 0 o un 1 dependiendo
de si n es par o inpar respectivamente:

```
	static public int rec3_optimizado(int n) {
		return n%2==0? 0 : 1;
	}
```
