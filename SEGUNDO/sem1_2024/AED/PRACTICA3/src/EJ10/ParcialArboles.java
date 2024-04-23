package EJ10;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

import EJ3.GeneralTree;
import EJ3.Queue;

public class ParcialArboles {
	
	public static GeneralTree<Integer> randomTree(int elements) {
		if (elements>0) {
			Random rand = new Random();
			GeneralTree<Integer> tree = new GeneralTree<Integer>();
			tree.setData(rand.nextInt(2));
			for (int i = 2;i<=elements;i++) {
				GeneralTree<Integer> aux = tree;
				boolean done = false;
				while (!done) {
					if (aux.isEmpty()) {
						aux.setData(rand.nextInt(2));
						done = true;
					} else {
						int size = aux.getChildren().size();
						int choice = rand.nextInt(size+1)+1;
						if ((size==0) || (choice == size+1)) {
							GeneralTree<Integer> child  = new GeneralTree<Integer>();
							child.setData(rand.nextInt(2));
							aux.addChild(child);
							done = true;
						} else {
							aux = aux.getChildren(choice-1);
					}
				}
			}
		}
			return tree;
		} else {
			return null;
		}
	}
	
	public static List<Integer> resolver(GeneralTree<Integer> tree) {
		Queue<GeneralTree<Integer>> queue = new Queue<GeneralTree<Integer>>();
		Queue<Integer> levelQueue =  new Queue<Integer>();
		Queue<Integer> indices = new Queue<Integer>();
		queue.enqueue(tree);
		levelQueue.enqueue(0);
		List<Dato> listas = new ArrayList<Dato>();
		GeneralTree<Integer> aux;
		int levelAux;
		
		while (!queue.isEmpty()) {
			aux = queue.dequeue();
			levelAux = levelQueue.dequeue();

			Dato dato = new Dato();
			dato.valor = aux.getData()*levelAux;
			
			dato.lista = new ArrayList<Integer>();
			if (!indices.isEmpty()) {
				Dato datoPadre = listas.get(indices.dequeue());
				dato.lista.addAll(datoPadre.lista);
				dato.valor += datoPadre.valor;
			}
			dato.lista.add(aux.getData());
			dato.lista = dato.lista;
			listas.add(dato);

			for (GeneralTree<Integer> child: aux.getChildren()) {
				queue.enqueue(child);
				levelQueue.enqueue(levelAux+1);
				indices.enqueue(listas.size()-1);
			}
		}
		int indice = -1;
		int valor = -9999;
		int i;
		for (i = 0; i<listas.size();i++) {
			if (listas.get(i).valor>valor) {
				valor=listas.get(i).valor;
				indice = i;
			}
		}
		if (indice!=-1) {
			return listas.get(indice).lista;
		} else {
			return null;
		}
	}
	
}
