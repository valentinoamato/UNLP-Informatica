package EJ7;

import EJ2.BinaryTree;

public class Ej7 {

	public static void main(String[] args) {
		//Construyo el arbol del ejemplo
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>(2);
		BinaryTree<Integer> a = new BinaryTree<Integer>(6);
		BinaryTree<Integer> b = new BinaryTree<Integer>(55);
		BinaryTree<Integer> c = new BinaryTree<Integer>(11);
		a.addLeftChild(b);
		a.addRightChild(c);
		c = new BinaryTree<Integer>(-3);
		b = new BinaryTree<Integer>(23);
		b.addLeftChild(c);
		c = new BinaryTree<Integer>(7);
		c.addLeftChild(b);
		c.addRightChild(a);
		arbolito.addLeftChild(c);
		a = new BinaryTree<Integer>(19);
		b = new BinaryTree<Integer>(4);
		c = new BinaryTree<Integer>(18);
		b.addLeftChild(c);
		a.addRightChild(b);
		c = new BinaryTree<Integer>(-5);
		c.addLeftChild(a);
		arbolito.addRightChild(c);
		
		ParcialArboles arbol = new ParcialArboles(arbolito);
		arbol.getTree().imprimirPorNiveles();
		System.out.println("7? "+arbol.isLeftTree(7));
		System.out.println("2? "+arbol.isLeftTree(2));
		System.out.println("-5? "+arbol.isLeftTree(-5));
		System.out.println("19? "+arbol.isLeftTree(19));
		System.out.println("-3? "+arbol.isLeftTree(-3));

	}

}
