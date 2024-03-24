package EJ7;

import java.util.*;

public class Clase {
	
	public static boolean esCapicua(ArrayList<Integer> list) {
		boolean capicua = true;
		int i = 0;
		int j = list.size()-1;
		while ((i!=j) && (i<j)){
			if (list.get(i)!=list.get(j)) {
				capicua=false;
			}
			i++;
			j--;
		}
			
		return capicua;
	}
	
	public static List<Integer> calcularSucesion(int n) {
		List<Integer> list = new LinkedList();
		if (n % 2 == 0) {
			list = calcularSucesion(n/2);
		} else if (n!=1) {
			list = calcularSucesion(n*3+1);			
		}
		list.add(0, n);
		return list;
	}
	
	public static void invertirArray(ArrayList<Integer> list) {
		ArrayList<Integer> aux = new ArrayList();
		for (int i=(list.size()-1);i>=0;i--) {
			aux.add(list.get(i));
		}
		list.clear();
		list.addAll(aux);
	}
	
	public static int sumarLinkedList(LinkedList<Integer>  list) {
		if (list.isEmpty()) {
			return 0;
		} else {
			return list.remove() + sumarLinkedList(list);
		}
	}
	
	public static ArrayList<Integer> combinarOrdenado(ArrayList<Integer> lista1, ArrayList<Integer> lista2) {
		ArrayList<Integer> lista3 = new ArrayList<Integer>();
		while ((!lista1.isEmpty()) && (!lista2.isEmpty())) {
			if (lista1.get(0)<lista2.get(0)) {
				lista3.add(lista1.remove(0));
			} else {
				lista3.add(lista2.remove(0));
			}
		}
		if (lista1.isEmpty()) {
			lista3.addAll(lista2);
		} else {
			lista3.addAll(lista1);
		}
		return lista3;
	}
}








