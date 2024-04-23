package EJ8;

import EJ3.GeneralTree;

public class Ej8 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int intentos = 1000;
		GeneralTree<Integer> miArbolito = null;
		Navidad navidad = new Navidad();
		boolean found = false;
		while ((intentos>0) && (found==false)) {
			miArbolito = GeneralTree.randomTree(10);
			navidad.setTree(miArbolito);
			found = navidad.esAbetoNavidenio();
			intentos--;
		}
		miArbolito.imprimirNiveles();
		if (found) {
			System.out.println("Mi arbolito es un abeto");
		} else {
			System.out.println("No se pudo encontrar un abeto");
		}

	}

}
