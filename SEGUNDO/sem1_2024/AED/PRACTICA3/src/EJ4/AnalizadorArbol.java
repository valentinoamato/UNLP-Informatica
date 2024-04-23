package EJ4;

import EJ3.GeneralTree;
import EJ3.Queue;

public class AnalizadorArbol {
	public static double devolverMaximoPromedio(GeneralTree<Integer> arbol){
		Queue<GeneralTree<Integer>> queue = new Queue<GeneralTree<Integer>>();
		Queue<Integer> levelQueue =  new Queue<Integer>();
		queue.enqueue(arbol);
		levelQueue.enqueue(0);
		GeneralTree<Integer> aux;
		int levelAux;
		int level = 0;
		int acumulador = 0;
		int cantidad = 0;
		double maxPromedio = 0;
		
		while (!queue.isEmpty()) {
			aux = queue.dequeue();
			levelAux = levelQueue.dequeue();
			if (level!=levelAux) {
				double promedio = (double) acumulador/cantidad;
				
				if (promedio>maxPromedio) {
					maxPromedio=promedio;
				} 
				acumulador=aux.getData();
				cantidad=1;
				level=levelAux;
				
					
				} else {
					cantidad++;
					acumulador+=aux.getData();
					
			}
			for (GeneralTree<Integer> child: aux.getChildren()) {
				queue.enqueue(child);
				levelQueue.enqueue(levelAux+1);
			}
		}
		double promedio = acumulador/cantidad;
		if (promedio>maxPromedio) {
			maxPromedio=promedio;
		}
		return maxPromedio;
	
}
}
