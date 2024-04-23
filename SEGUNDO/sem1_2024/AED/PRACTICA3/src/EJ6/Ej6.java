package EJ6;

import EJ3.GeneralTree;

public class Ej6 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GeneralTree<Integer> miArbolito = GeneralTree.randomTree(20);
		miArbolito.imprimirNiveles();
		RedDeAguaPotable redDeAguaPotable = new RedDeAguaPotable(miArbolito);
		System.out.println("El caudal minimo es: "+redDeAguaPotable.minimo());
	}

}
