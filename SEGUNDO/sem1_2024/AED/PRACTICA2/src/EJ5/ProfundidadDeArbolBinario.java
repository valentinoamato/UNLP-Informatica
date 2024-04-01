package EJ5;

import EJ2.BinaryTree;
import EJ2.Queue;

public class ProfundidadDeArbolBinario {
	private BinaryTree<Integer> tree;
	
	public BinaryTree<Integer> getTree() {
		return tree;
	}
	
	public ProfundidadDeArbolBinario(BinaryTree<Integer> tree) {
		this.tree = tree;
	}
	
	public int sumaElementosProfundidad(int nivel) {
		Queue<BinaryTree<Integer>> queue = new Queue<BinaryTree<Integer>>();
		Queue<Integer> levels  = new Queue<Integer>();
		int suma = 0;
		queue.enqueue(this.getTree());
		levels.enqueue(0);
		while (!queue.isEmpty()) {
			BinaryTree<Integer> e = queue.dequeue();
			int l = levels.dequeue();
			if (l==nivel) {				
				suma+=e.getData();
			}	
			if ((e.hasLeftChild()) && (l<nivel)) {
				levels.enqueue(l+1);
				queue.enqueue(e.getLeftChild());
			}
			if ((e.hasRightChild()) && (l<nivel)) {
				levels.enqueue(l+1);
				queue.enqueue(e.getRightChild());
			}
		}
		return suma;
		
	}
}
