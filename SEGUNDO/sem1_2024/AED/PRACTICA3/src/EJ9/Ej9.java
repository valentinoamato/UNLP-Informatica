package EJ9;

import EJ3.GeneralTree;

public class Ej9 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int intentos = 100000000;
		GeneralTree<Integer> miArbolito = null;
		boolean found = false;
		while ((intentos>0) && (found==false)) {
			miArbolito = GeneralTree.randomTree(10);
			found = ParcialArboles.booleanEsDeSeleccion(miArbolito);
			intentos--;
		}
		miArbolito.imprimirNiveles();
		if (found) {
			System.out.println("Mi arbolito es de seleccion");
		} else {
			System.out.println("No se pudo encontrar un arbol de seleccion");
		}

	}

}
