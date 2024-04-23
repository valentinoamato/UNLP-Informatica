package EJ3;

import java.util.List;

public class Ej3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		GeneralTree<Integer> tree = GeneralTree.randomTree(10);
		tree.imprimirNiveles();
		System.out.println("altura: "+tree.altura());
		for (int i=20;i<80;i++) {
			int nivel = tree.nivel(i);
			if (nivel!=-1) {				
				System.out.println("nivel de "+i+": "+nivel);
				for (int j=20; j<80;j++) {
					if ((j!=i) && (tree.esAncestro(i,j))) {
						System.out.println(i+" es ancestro de "+j);
						break;
					}
					
				}
				break;
			}
		}
		System.out.println("ancho: "+tree.ancho());
		List<Integer> recorrido = tree.caminoAHolaMasLejana();
		System.out.println("El recorrido a la hoja mas lejana es: ");
		System.out.println(recorrido.toString());
		
		
	}

}
