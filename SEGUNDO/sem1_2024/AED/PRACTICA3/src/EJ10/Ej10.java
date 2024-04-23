package EJ10;

import java.util.List;

import EJ3.GeneralTree;

public class Ej10 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GeneralTree<Integer> miArbolito = ParcialArboles.randomTree(20);
		miArbolito.imprimirNivelesConSeparadores();
		System.out.println("El camino filtrado de valor maximo es: ");
		List<Integer> miLista = ParcialArboles.resolver(miArbolito);		
		System.out.println(miLista.toString());


	}

}
