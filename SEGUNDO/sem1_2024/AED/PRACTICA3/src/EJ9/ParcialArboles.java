package EJ9;

import EJ3.GeneralTree;

public class ParcialArboles {
	
	public static boolean booleanEsDeSeleccion(GeneralTree<Integer> tree) {
		boolean seleccion = true;
		if ((!tree.isEmpty()) && (tree.hasChildren())) {
			int min = 999999;
			
			for (GeneralTree<Integer> child:tree.getChildren()) {
				seleccion = booleanEsDeSeleccion(child);
				
				if (seleccion) { 
					if (child.getData()<min) {
						min = child.getData();
					}
					
				} else {
					break;
				}
		}
			if (tree.getData()!=min) {
				seleccion=false;
			}
		}
		return seleccion;
}
}
