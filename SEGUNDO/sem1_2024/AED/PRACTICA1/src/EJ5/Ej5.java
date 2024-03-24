package EJ5;

public class Ej5 {

	public static void main(String[] args) {
		//A
		System.out.println(Calcular.moduloa(new int []{1,4,7,2,10,5,3,6}).toString());
		
		//B
		Dato dato = new Dato(0, 0, 0);
		Calcular.modulob(new int[] {6,3,9,1,-23,10,1,2}, dato);
		System.out.println(dato.toString());
		
		//C
		System.out.println(Calcular.getVarc()); //null
		Calcular.moduloc(new int[] {-4,-3,-2,-1,1,2,3,4});
		System.out.println(Calcular.getVarc().toString());
		
	}

}
