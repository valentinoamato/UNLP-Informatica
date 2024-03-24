package EJ2;
import java.util.Scanner;

public class Ej2 {

	public static void main(String[] args) {
		int[] multiplos;
		System.out.print("Ingrese 'n':");
		Scanner scanner  = new Scanner(System.in);
		multiplos=Clase.multiplos(scanner.nextInt());
		System.out.println("El arreglo generado es:");
		for (int n:multiplos) {
			System.out.println(n);
		}
		
	}

}
