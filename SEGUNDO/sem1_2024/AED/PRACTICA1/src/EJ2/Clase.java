package EJ2;

public class Clase {
	public static int[] multiplos(int n) {
		int[] arreglo = new int[n];
		int i;
		for (i=0;i<n;i++) {
			arreglo[i]=(i+1)*n;
		}
		return arreglo;
	}
}
