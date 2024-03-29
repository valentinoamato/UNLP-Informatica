package EJ9;

import java.util.*;

public class Ej9 {

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.print("Ingrese un string: ");
		boolean result = Balance.isBalanced(scanner.next());
		if (result) {
			System.out.println("El string ingresado esta balanceado.");
		} else {
			System.out.println("El string ingresado no esta balanceado");
		}
	}
}
