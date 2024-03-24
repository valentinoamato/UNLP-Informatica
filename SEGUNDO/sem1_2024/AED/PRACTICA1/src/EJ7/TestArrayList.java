package EJ7;
import java.util.*;

public class TestArrayList {

	public static void metodod() {
		List<Estudiante> list = new ArrayList();
		Estudiante e1 = new Estudiante("Pepe", 1);
		Estudiante e2 = new Estudiante("Carlos", 2);
		Estudiante e3 = new Estudiante("Mateo", 3);
		Estudiante e4 = new Estudiante("Camila", 13);
		list.add(e1);
		list.add(e2);
		list.add(e3);
		
		//A
		List<Estudiante> list2 = new ArrayList(list);
		
		//B
		//List<Estudiante> list2 = new ArrayList();
		//list2.addAll(list);
		
		//C
		//List<Estudiante> list2 = (List<Estudiante>)((ArrayList<Estudiante>)list).clone();
		
		//D
		//List<Estudiante> list2 = list;
		
		System.out.println(list.toString());
		System.out.println(list2.toString());
		
		e1.setNombre("Lalo");
		boolean found = false;
		for (Estudiante e: list) {
			if (e.equals(e4)) {
				found = true;
				break;
			}
		} 
		if (!found) {
			list.add(e4);
		}
		
		System.out.println(list.toString());
		System.out.println(list2.toString());
		
	}
	
	public static void main(String[] args) {
		List<Integer> list = new ArrayList();
		System.out.print("Ingrese los numeros a agregar (-1 para terminar):");
		int n;
		Scanner scanner = new Scanner(System.in);
		n =  scanner.nextInt();
		while (n!=-1) {
			list.add(n);
			n =  scanner.nextInt();
		}
		
		for (int e: list) {
			System.out.println(e);
		}
		
		metodod();

	}

}
