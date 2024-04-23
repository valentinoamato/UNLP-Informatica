package EJ11;

import EJ3.GeneralTree;

public class Ej11 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int intentos = 300000;
		GeneralTree<Integer> miArbolito = null;
		boolean found = false;
		while ((intentos>0) && (found==false)) {
			miArbolito = GeneralTree.randomTree(15);
			found = miArbolito.esCreciente();
			intentos--;
		}
		miArbolito.imprimirNivelesConSeparadores();
		if (found) {
			System.out.println("Mi arbolito es creciente");
		} else {
			System.out.println("No se pudo encontrar un arbolito creciente");
		}

	}

}
