package EJ3;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

public class GeneralTree<T>{

	private T data;
	private List<GeneralTree<T>> children = new LinkedList<GeneralTree<T>>(); 

	public GeneralTree() {
		
	}
	
	public static GeneralTree<Integer> randomTree(int elements) {
		if (elements>0) {
			Random rand = new Random();
			GeneralTree<Integer> tree = new GeneralTree<Integer>();
			tree.setData(rand.nextInt(100)+1);
			for (int i = 2;i<=elements;i++) {
				GeneralTree<Integer> aux = tree;
				boolean done = false;
				while (!done) {
					if (aux.isEmpty()) {
						aux.setData(rand.nextInt(100)+1);
						done = true;
					} else {
						int size = aux.getChildren().size();
						int choice = rand.nextInt(size+1)+1;
						if ((size==0) || (choice == size+1)) {
							GeneralTree<Integer> child  = new GeneralTree<Integer>();
							child.setData(rand.nextInt(100)+1);
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
	
	public GeneralTree(T data) {
		this.data = data;
	}

	public GeneralTree(T data, List<GeneralTree<T>> children) {
		this(data);
		this.children = children;
	}	
	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public List<GeneralTree<T>> getChildren() {
		return this.children;
	}
	
	public GeneralTree<T> getChildren(int index) {
		if (index<this.children.size()) {
			
			return this.children.get(index);
		} else {
			return null;
		}
			
	}
	
	public void setChildren(List<GeneralTree<T>> children) {
		if (children != null)
			this.children = children;
	}
	
	public void addChild(GeneralTree<T> child) {
		this.getChildren().add(child);
	}


	public boolean isLeaf() {
		return !this.hasChildren();
	}
	
	public boolean hasChildren() {
		return !this.children.isEmpty();
	}
	
	public boolean isEmpty() {
		return this.data == null && !this.hasChildren();
	}

	public void removeChild(GeneralTree<T> child) {
		if (this.hasChildren())
			children.remove(child);
	}
	
	
	public int altura() {
		int h = 0;
		if (this.hasChildren()) {
			int max = 0;
			for (GeneralTree<T> child: this.children) {
				int aux = child.altura();
				if (aux>max) {
					max = aux;
				}
			}
			h = max+1;
			
		}
		return h;
	}
	
	private int nivel(T dato, int nivel) {
		if (this.getData()==dato) {
			return nivel;
		} else {
			for (GeneralTree<T> child:this.getChildren()) {
				int aux = child.nivel(dato,nivel+1);
				if  (aux!=-1) {
					return aux;
				}
			}
		}
		return -1;
	}
	
	public GeneralTree<T> buscar(T dato){
		if (this.getData()==dato) {
			return this;
		} else {
			for  (GeneralTree<T> child: this.getChildren()) {
				GeneralTree<T> ret =  child.buscar(dato);
				if (ret!=null) {
					return  ret;
				}
			}
		}
		return null;
	}
	
	public int nivel(T dato){
		return nivel(dato,0);
	  }

	public int ancho(){
		Queue<GeneralTree<T>> queue = new Queue<GeneralTree<T>>();
		Queue<Integer> levelQueue =  new Queue<Integer>();
		queue.enqueue(this);
		levelQueue.enqueue(0);
		GeneralTree<T> aux;
		int levelAux;
		int level = 0;
		int ancho = -1;
		int maxAncho = -1;
		
		while (!queue.isEmpty()) {
			ancho++;
			aux = queue.dequeue();
			levelAux = levelQueue.dequeue();
			if (level!=levelAux) {
				if (ancho>maxAncho) {
					maxAncho=ancho;
				}
				ancho=0;
				level=levelAux;
			}
			for (GeneralTree<T> child: aux.getChildren()) {
				queue.enqueue(child);
				levelQueue.enqueue(levelAux+1);
			}
		}
		if (ancho>maxAncho) {
			maxAncho=ancho;
		}
		return maxAncho;
	}
	
	public void imprimirNiveles() {
		Queue<GeneralTree<T>> queue = new Queue<GeneralTree<T>>();
		Queue<Integer> levelQueue =  new Queue<Integer>();
		queue.enqueue(this);
		levelQueue.enqueue(0);
		GeneralTree<T> aux;
		int levelAux;
		int level = -1;
		
		while (!queue.isEmpty()) {
			aux = queue.dequeue();
			levelAux = levelQueue.dequeue();
			if (level!=levelAux) {
				System.out.print("\nL-"+levelAux+": ");
				level=levelAux;
			}
			System.out.print(" "+aux.getData().toString());
			for (GeneralTree<T> child: aux.getChildren()) {
				queue.enqueue(child);
				levelQueue.enqueue(levelAux+1);
			}
		}
		System.out.println();
	}
	
	private boolean esAncestro(GeneralTree<T> arbol,T b) {
		boolean ancestro = false;
		if (!arbol.isEmpty()) {
			if (arbol.getData()==b) {
				ancestro=true;
			} else {
				for (GeneralTree<T> child:arbol.getChildren()) {
					if (esAncestro(child, b)) {
						ancestro=true;
						break;
					}
				}
			}
		}
		return ancestro;
	}
	
	public boolean esAncestro(T a, T b) {
		return esAncestro(buscar(a), b);
	}
	
	public List<T> caminoAHolaMasLejana() {
		List<T> lista = null;
		if (!this.isEmpty()) {
			int max = 0;
			List<T>  aux;
			if (this.hasChildren()) {				
				for (GeneralTree<T> child:this.getChildren()) {
					aux = child.caminoAHolaMasLejana();
					if (aux.size()>max) {
						lista = aux;
						max = aux.size();
					}
				}
			} else {
				lista = new LinkedList<T>();
			}
			lista.add(0, this.getData());
		}
		return lista;
	}
	
}











