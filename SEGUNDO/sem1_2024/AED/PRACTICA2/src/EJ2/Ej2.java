package EJ2;

public class Ej2 {

	public static void main(String[] args) {
		BinaryTree<Integer> arbolito = new BinaryTree<Integer>();
		
		arbolito.add(2);
		arbolito.add(3);
		arbolito.add(8);
		arbolito.add(16);
		arbolito.add(9);
		
		System.out.println("contarHojas: "+arbolito.contarHojas());
		System.out.println("entreNiveles arbolito");
		arbolito.entreNiveles(0, 3);
		
		System.out.println("entreNiveles espejito");
		BinaryTree<Integer> espejito = arbolito.espejo();
		espejito.entreNiveles(0, 3);

	}

}
