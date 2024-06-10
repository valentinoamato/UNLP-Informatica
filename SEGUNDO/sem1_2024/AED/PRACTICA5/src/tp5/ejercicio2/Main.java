package tp5.ejercicio2;

import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;
import tp5.ejercicio1.adjList.AdjListGraph;

public class Main {

	public static void main(String[] args) {
		Graph<String> grafito = new AdjListGraph<String>();
		Vertex<String> d = grafito.createVertex("D");
		Vertex<String> b = grafito.createVertex("B");
		Vertex<String> c = grafito.createVertex("C");
		Vertex<String> r = grafito.createVertex("R");
		Vertex<String> h = grafito.createVertex("H");
		Vertex<String> a = grafito.createVertex("A");
		Vertex<String> t = grafito.createVertex("T");
		grafito.connect(d, c);
		grafito.connect(d, b);
		grafito.connect(c, r);
		grafito.connect(b, h);
		grafito.connect(r, h);
		grafito.connect(h, d);
		grafito.connect(h, t);
		grafito.connect(h, a);
		//O(V+E)
		System.out.println(Recorridos.dfs(grafito));
		//O(V+E)
		System.out.println(Recorridos.bfs(grafito));
	}

}
