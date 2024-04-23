package EJ2;

import java.util.LinkedList;
import java.util.List;

import EJ3.GeneralTree;
import EJ3.Queue;

public class RecorridosAG {
	public static boolean esImpar(int n) {
		return n % 2  !=0;
	}
	
	private static void  preOrden (List<Integer> lista,GeneralTree<Integer> a, Integer n) {
		if (!a.isEmpty()) {
			if ((a.getData()>n) && (esImpar(a.getData()))) {
				lista.add(a.getData());
			}
			for (GeneralTree<Integer> child:a.getChildren()) {
				preOrden(lista, child, n);
			}
		}
	}
	
	public static List<Integer> numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		preOrden(list, a, n);
		return list;
	}

	private static void  postOrden (List<Integer> lista,GeneralTree<Integer> a, Integer n) {
		if (!a.isEmpty()) {
			for (GeneralTree<Integer> child:a.getChildren()) {
				postOrden(lista, child, n);
			}
			if ((a.getData()>n) && (esImpar(a.getData()))) {
				lista.add(a.getData());
			}
		}
	}
	
	public static List<Integer> numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		postOrden(list, a, n);
		return list;
	}
	
	private static void  InOrden (List<Integer> lista,GeneralTree<Integer> a, Integer n) {
		if (!a.isEmpty()) {
			int i = 0;
			for (GeneralTree<Integer> child:a.getChildren()) {
				i++;
				InOrden(lista, child, n);
				if ((i==1) && (a.getData()>n) && (esImpar(a.getData()))) {
					lista.add(a.getData());
				}
			}
			if ((i==0) && (a.getData()>n) && (esImpar(a.getData()))) {
				lista.add(a.getData());
			}
		}
	}
	
	public static List<Integer> numerosImparesMayoresQueInOrden(GeneralTree<Integer> a, Integer n) {
		List<Integer> list = new LinkedList<Integer>();
		InOrden(list, a, n);
		return list;
	}
	
	public static List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree<Integer> a, Integer n) {
		Queue<GeneralTree<Integer>> queue = new Queue<GeneralTree<Integer>>();
		LinkedList<Integer> list = new LinkedList<Integer>();
		queue.enqueue(a);
		GeneralTree<Integer> aux;		
		while (!queue.isEmpty()) {
			aux = queue.dequeue();
			if ((aux.getData()>n) && (esImpar(aux.getData()))) {
				list.add(aux.getData());
			}
			for (GeneralTree<Integer> child: aux.getChildren()) {
				queue.enqueue(child);
			}
		}
		return list;
	}
	
}
