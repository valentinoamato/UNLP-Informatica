package EJ6;

import EJ2.BinaryTree;

public class Ej6 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		for (int i = 0;i<10;i++) {
			arbolito.add(i);
		}
		
		Transformacion trans = new Transformacion(arbolito);
		trans.getTree().imprimirPorNiveles();
		trans.suma();
		System.out.println("suma:");
		trans.getTree().imprimirPorNiveles();

	}

}
