package EJ4;

import EJ3.GeneralTree;

public class Ej4 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GeneralTree<Integer> tree = GeneralTree.randomTree(12);
		tree.imprimirNiveles();
		System.out.println("El mayor promedio es: "+AnalizadorArbol.devolverMaximoPromedio(tree));
	}

}
