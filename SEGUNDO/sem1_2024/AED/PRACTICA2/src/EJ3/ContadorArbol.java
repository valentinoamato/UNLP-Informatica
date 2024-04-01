package EJ3;

import EJ2.BinaryTree;

public class ContadorArbol {
	private BinaryTree<Integer> tree;

	
	public ContadorArbol(BinaryTree<Integer> tree) {
		this.tree = tree;
	}
	
	public BinaryTree<Integer> getTree() {
		return tree;
	}

	public void setTree(BinaryTree<Integer> tree) {
		this.tree = tree;
	}
	
	private boolean isEven(int num) {
		return num % 2 == 0;
	}
	
	private BinaryTree<Integer> numerosParesInOrden(BinaryTree<Integer> tree){
    	BinaryTree<Integer> evens = new BinaryTree<Integer>();
    	if (tree.hasLeftChild()) {
    		evens.add(numerosParesInOrden(tree.getLeftChild()));
    	} 
    	if (isEven(tree.getData())) {
    		evens.add(tree.getData());
    	} 
    	if (tree.hasRightChild()) {
    		evens.add(numerosParesInOrden(tree.getRightChild()));
    	} 
    	if (evens.getData()==null) {
    		return null;
    	} else {
 	   		return evens;
    	}
	}
	
    public BinaryTree<Integer> numerosParesInOrden(){
 	   	return numerosParesInOrden(this.getTree());
    }

	private BinaryTree<Integer> numerosParesPostOrden(BinaryTree<Integer> tree){
    	BinaryTree<Integer> evens = new BinaryTree<Integer>();
    	if (tree.hasLeftChild()) {
    		evens.add(numerosParesPostOrden(tree.getLeftChild()));
    	} 
    	if (tree.hasRightChild()) {
    		evens.add(numerosParesPostOrden(tree.getRightChild()));
    	} 
    	if (isEven(tree.getData())) {
    		evens.add(tree.getData());
    	} 
    	if (evens.getData()==null) {
    		return null;
    	} else {
 	   		return evens;
    	}
	}
	
    public BinaryTree<Integer> numerosParesPostOrden(){
 	   	return numerosParesPostOrden(this.getTree());
    }
	
}
