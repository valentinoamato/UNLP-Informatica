package EJ8;

import EJ2.BinaryTree;

public class ParcialArboles {
	public static boolean esPrefijo(BinaryTree<Integer> arbol1,BinaryTree<Integer> arbol2) {
		if (arbol1.getData()!=arbol2.getData()) {
			return false;
		}
		boolean result = true;
		if (arbol1.hasLeftChild()) {
			if (arbol2.hasLeftChild()) {
				result = result && esPrefijo(arbol1.getLeftChild(), arbol2.getLeftChild());
			} else {
				return false;
			}
		}
		if (arbol1.hasRightChild()) {
			if (arbol2.hasRightChild()) {
				result = result && esPrefijo(arbol1.getRightChild(), arbol2.getRightChild());
			} else {
				return false;
			}
		}
		return result;
	}
}
