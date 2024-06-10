package tp5.ejercicio2;

import java.util.ArrayList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Recorridos {
    private static <T> void dfs(Vertex<T> vertice,Graph<T> grafo, boolean[] visitados,List<T> lista) {
        lista.add(vertice.getData());
        visitados[vertice.getPosition()] = true;
        for (Edge<T> arista: grafo.getEdges(vertice)) {
            Vertex<T> v = arista.getTarget();
            if (!visitados[v.getPosition()]) {
                dfs(v,grafo,visitados,lista);
            }
        }
    }
    
    public static <T> List<T> dfs(Graph<T> grafo) {
        boolean[] visitados = new boolean[grafo.getSize()]; //Todos los elementos se inicializan en false
        List<T> lista = new ArrayList<T>(); 
        for (int i=0;i<grafo.getSize();i++) {
            if (!visitados[i]) {
                dfs(grafo.getVertex(i), grafo ,visitados,lista);
            }
        }
        return lista;
    }

    public static <T> List<T> bfs(Graph<T> grafo) {
        boolean[] visitados = new boolean[grafo.getSize()];
        List<T> lista = new ArrayList<T>();
        ArrayList<Vertex<T>> cola = new ArrayList<>();
        cola.add(grafo.getVertex(0));
        visitados[0] = true;
        while (!cola.isEmpty()) {
            Vertex<T> vertice = cola.removeFirst();
            lista.add(vertice.getData());
            for (Edge<T> arista: grafo.getEdges(vertice)) {
                Vertex<T> v = arista.getTarget();
                int pos = v.getPosition();
                if (!visitados[pos]) {
                    visitados[pos] = true;
                    cola.add(v);
                }
            }

        }
        return lista;
    }
}
