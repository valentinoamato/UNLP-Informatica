package EJ9;

import EJ2.BinaryTree;

public class ParcialArboles {
	
	private static void sumAndDif(BinaryTree<Integer> tree, BinaryTree<SumAndDif> sad,int sum,int parent) {
		SumAndDif sumAndDif = new SumAndDif(sum+tree.getData(), tree.getData()-parent);
		sad.setData(sumAndDif);
		
		if (tree.hasLeftChild()) {
			sad.addLeftChild(new BinaryTree<SumAndDif>());
			sumAndDif(tree.getLeftChild(),sad.getLeftChild(),sum+tree.getData(),tree.getData());
		}
		
		if (tree.hasRightChild()) {
			sad.addRightChild(new BinaryTree<SumAndDif>());
			sumAndDif(tree.getRightChild(),sad.getRightChild(),sum+tree.getData(),tree.getData());
		}
		
	}
	
	public static BinaryTree<SumAndDif> sumAndDif(BinaryTree<Integer> arbol){
		BinaryTree<SumAndDif> sad = new BinaryTree<SumAndDif>();
		sumAndDif(arbol,sad,0,0);
		return sad;
	}
}
