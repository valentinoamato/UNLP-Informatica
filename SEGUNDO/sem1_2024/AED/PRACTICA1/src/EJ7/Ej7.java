package EJ7;

import java.util.*;

public class Ej7 {

	public static void main(String[] args) {
		System.out.println("esCapicua: ");
		System.out.println(Clase.esCapicua(new ArrayList<Integer>(Arrays.asList(4,3,2,1,2,3,4,5))));
		System.out.println(Clase.esCapicua(new ArrayList<Integer>(Arrays.asList(4,3,2,1,1,2,3,4))));
		System.out.println(Clase.esCapicua(new ArrayList<Integer>(Arrays.asList(4,3,2,1,0,1,2,3,4))));
		
		System.out.println("\ncalcularSucesion:");
		List<Integer> list = new LinkedList(Clase.calcularSucesion(6));
		for (int n: list) {
			System.out.print(" "+n);
		}
		
		System.out.println("\n\ninvertirArrayList:");
		ArrayList<Integer> list2 = new ArrayList<Integer>(Arrays.asList(1,2,3,4,5,6,7,8,9,10));
		Clase.invertirArray(list2);
		System.out.println(list2.toString());

		System.out.println("\nsumarLinkedList:");
		LinkedList<Integer> list3 = new LinkedList<Integer>(Arrays.asList(1,2,3,4,5,6,7,8,9,10));
		System.out.println(Clase.sumarLinkedList(list3));
		
		System.out.println("\ncombinarOrdenado:");
		ArrayList<Integer> list4 = new ArrayList<Integer>(Arrays.asList(1,3,5,7,9));
		ArrayList<Integer> list5 = new ArrayList<Integer>(Arrays.asList(2,4,6,8,10));
		System.out.println(Clase.combinarOrdenado(list4, list5).toString());
		
		
	}
	
	/*
	 Respuestas:
	 	b. No habria diferencia en la implementacion.
	 	   Esto es asi ya que ambas estructuras comparten la interfaz definida en su clase padre, List.
	 	c. Si, recorrer con un Iterator y recorrer mediante un indice en una estructura de control.
	 	d.e La nueva lista tiene los mismos elementos (referencias a objetos) que la primera. 
	 		Al modificar uno de estos elementos, los cambios se dan en ambas listas.
	 		Al modificar la primer lista en particular (Ej: agregar un elemento), los cambios no se replican en la segunda lista.
	 	d.f Existen al menos 3 formas. No encontre ninguna diferencia significante.
	 */

}
