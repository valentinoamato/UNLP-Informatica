package EJ7;

import EJ2.BinaryTree;

public class ParcialArboles {
	private BinaryTree<Integer> tree;
	
	public ParcialArboles(BinaryTree<Integer> tree) {
		this.tree = tree;
	}
	
	public BinaryTree<Integer> getTree(){
		return this.tree;
	}
	
	public static int onlySonNodes(BinaryTree<Integer> tree) {
		int count = 0;
		if (tree.hasLeftChild()) {
			count+=onlySonNodes(tree.getLeftChild());
		}
		if (tree.hasRightChild()) {
			count+=onlySonNodes(tree.getRightChild());
		}
		if (tree.hasLeftChild() ^ tree.hasRightChild()) {
			count++;
		}
		return count;
	}
	
	public static boolean isLeftTree(BinaryTree<Integer> tree) {
		int left = -1;
		int right = -1;
		if (tree.hasLeftChild()) {
			left = onlySonNodes(tree.getLeftChild());
		}
		if (tree.hasRightChild()) {
			right = onlySonNodes(tree.getRightChild());
		}
		return left>right;
	}
	
	public BinaryTree<Integer> search(BinaryTree<Integer> tree,int n){

		if (tree.getData()==n) {
			return tree;
		} 
		
		BinaryTree<Integer> ret = null;
		if (tree.hasLeftChild()) {
			ret = search(tree.getLeftChild(), n);
		}
		if ((tree.hasRightChild()) && (ret==null)) {
			ret = search(tree.getRightChild(), n);
		}
		return ret;
		
		
	}
	
	public boolean isLeftTree(int num) {
		BinaryTree<Integer> tree = search(this.getTree(), num);
		if (tree==null) {
			return false;
		} else {
			return isLeftTree(tree);
		}
	}
}
