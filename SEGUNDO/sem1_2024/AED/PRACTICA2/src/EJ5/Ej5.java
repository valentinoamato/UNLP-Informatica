package EJ5;

import EJ2.BinaryTree;

public class Ej5 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		for (int i = 0;i<10;i++) {
			arbolito.add(i);
		}
		
		ProfundidadDeArbolBinario pdab = new ProfundidadDeArbolBinario(arbolito);
		pdab.getTree().imprimirPorNiveles();
		System.out.println("Suma nivel 0: "+pdab.sumaElementosProfundidad(0));
		System.out.println("Suma nivel 0: "+pdab.sumaElementosProfundidad(1));
		System.out.println("Suma nivel 0: "+pdab.sumaElementosProfundidad(2));
		System.out.println("Suma nivel 0: "+pdab.sumaElementosProfundidad(3));
		System.out.println("Suma nivel 0: "+pdab.sumaElementosProfundidad(4));

	}

}
