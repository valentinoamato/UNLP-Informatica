package EJ3;

import EJ2.BinaryTree;

public class Ej3 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		for (int i=1;i<=10;i++) {
			arbolito.add(i);
		}
		arbolito.imprimirPorNiveles();
		
		System.out.println("paresInOrden:");
		ContadorArbol contadorArbol = new ContadorArbol(arbolito);
		contadorArbol.numerosParesInOrden().imprimirPorNiveles();
		
		System.out.println("paresPostOrden:");
		contadorArbol.numerosParesPostOrden().imprimirPorNiveles();

	}

}
