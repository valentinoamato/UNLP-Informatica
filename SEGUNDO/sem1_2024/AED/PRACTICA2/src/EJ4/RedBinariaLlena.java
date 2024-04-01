package EJ4;

import EJ2.BinaryTree;

public class RedBinariaLlena {
	private BinaryTree<Integer> tree;
	
	public RedBinariaLlena(BinaryTree<Integer> tree) {
		this.tree = tree;
	}
	
	public void imprimir() {
		tree.imprimirPorNiveles();
	}
	
	private int retardoReenvio(BinaryTree<Integer> tree) {
		if (tree.isLeaf()) {
			return tree.getData();
		}
		int l = 0;
		int r = 0;
		if (tree.hasLeftChild()) {
			l = retardoReenvio(tree.getLeftChild());
		}
		if (tree.hasRightChild()) {
			r = retardoReenvio(tree.getRightChild());
		}
		if (l>r) {
			return tree.getData()+l;
		} else {
			return tree.getData()+r;
		}
	}
	
	public int retardoReenvio() {
		return retardoReenvio(this.tree);
	}
}
