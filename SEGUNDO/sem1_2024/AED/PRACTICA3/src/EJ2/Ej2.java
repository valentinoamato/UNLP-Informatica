package EJ2;

import java.util.LinkedList;
import java.util.List;

import EJ3.GeneralTree;

public class Ej2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GeneralTree<Integer> tree = GeneralTree.randomTree(12);
		List<Integer> list = new LinkedList<Integer>();
		tree.imprimirNiveles();
		System.out.println("Numeros impares mayores que 20: ");
		
		list = RecorridosAG.numerosImparesMayoresQuePreOrden(tree, 20);
		System.out.println("PREORDEN:");
		System.out.println(list.toString());
		
		list = RecorridosAG.numerosImparesMayoresQuePostOrden(tree, 20);
		System.out.println("POSTORDEN:");
		System.out.println(list.toString());

		list = RecorridosAG.numerosImparesMayoresQueInOrden(tree, 20);
		System.out.println("INORDEN:");
		System.out.println(list.toString());
		
		list = RecorridosAG.numerosImparesMayoresQuePorNiveles(tree, 20);
		System.out.println("PORNIVELES:");
		System.out.println(list.toString());
	}

}
