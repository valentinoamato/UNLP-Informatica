package EJ8;

import EJ2.BinaryTree;

public class Ej8 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		for (int i = 0;i<10;i++) {
			arbolito.add(i);
		}
		
		BinaryTree<Integer> arbol1 = new BinaryTree<Integer>();
		for (int i = 0;i<10;i++) {
			arbol1.add(i);
		}
		
		BinaryTree<Integer> arbol2 = new BinaryTree<Integer>();
		for (int i = 0;i<5;i++) {
			arbol2.add(i);
		}
		
		BinaryTree<Integer> arbol3 = new BinaryTree<Integer>();
		for (int i = 0;i<15;i++) {
			arbol3.add(i);
		}
		
		BinaryTree<Integer> arbol4 = new BinaryTree<Integer>(0);
		arbol4.addLeftChild(new BinaryTree<Integer>(1));
		BinaryTree<Integer> a = arbol4.getLeftChild();
		a.addLeftChild(new BinaryTree<Integer>(3));
		a = a.getLeftChild();
		a.addLeftChild(new BinaryTree<Integer>(7));
		
		arbolito.imprimirPorNiveles();
		System.out.println("arbol1 in arbolito: "+ParcialArboles.esPrefijo(arbol1, arbolito));
		System.out.println("arbol1 in arbolito: "+ParcialArboles.esPrefijo(arbol2, arbolito));
		System.out.println("arbol1 in arbolito: "+ParcialArboles.esPrefijo(arbol3, arbolito));
		System.out.println("arbol1 in arbolito: "+ParcialArboles.esPrefijo(arbol4, arbolito));

	}

}
