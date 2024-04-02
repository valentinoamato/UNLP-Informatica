package EJ6;

import EJ2.BinaryTree;
import EJ2.Queue;

public class Transformacion {
	private BinaryTree<Integer> tree;
	
	public BinaryTree<Integer> getTree() {
		return tree;
	}
	
	public Transformacion(BinaryTree<Integer> tree) {
		this.tree = tree;
	}
	
	private int suma(BinaryTree<Integer> tree) {
		int suma = 0;
		if (tree.isLeaf()) {
			suma = tree.getData();
			tree.setData(0);
			return suma;
		}
		if (tree.hasLeftChild()) {
			suma+=suma(tree.getLeftChild());
		}
		if (tree.hasRightChild()) {
			suma+=suma(tree.getRightChild());
		}
		int aux = tree.getData();
		tree.setData(suma);
		return suma+aux;
	}
	
	public BinaryTree<Integer> suma() {
		suma(this.getTree());
		return this.getTree();
	}
}
