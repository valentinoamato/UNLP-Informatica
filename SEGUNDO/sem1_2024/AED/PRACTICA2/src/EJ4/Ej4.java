package EJ4;

import EJ2.BinaryTree;

public class Ej4 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		for (int i = 0;i<10;i++) {
			arbolito.add(i);
		}
		
		RedBinariaLlena redBinariaLlena = new RedBinariaLlena(arbolito);
		redBinariaLlena.imprimir();
		System.out.println("Retraso maximo: "+redBinariaLlena.retardoReenvio());

	}

}
