package EJ9;

import EJ2.BinaryTree;

public class Ej9 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		for (int i = 0;i<10;i++) {
			arbolito.add(i);
		}
		
		System.out.println("arbolito: ");
		arbolito.imprimirPorNiveles();
		
		System.out.println("sumAndDif: ");
		ParcialArboles.sumAndDif(arbolito).imprimirPorNiveles();
	}

}
