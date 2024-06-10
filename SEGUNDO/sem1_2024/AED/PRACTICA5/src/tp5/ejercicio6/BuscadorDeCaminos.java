package tp5.ejercicio6;

import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class BuscadorDeCaminos {
    private Graph<String> bosque;

    public BuscadorDeCaminos(Graph<String> bosque) {
        this.bosque = bosque;
    }

    private void recorridosMasSeguros(Vertex<String> vertice,boolean[] visitados,List<String> lista,List<List<String>> listas) {
        lista.add(vertice.getData());
        visitados[vertice.getPosition()] = true;
        if (vertice.getData()=="Casa Abuelita") {
            listas.add(new LinkedList<String>(lista));
        } else {
            int size = lista.size();
            for (Edge<String> edge: bosque.getEdges(vertice)) {
                Vertex<String> v = edge.getTarget();
                if ((!visitados[v.getPosition()]) && (edge.getWeight()<=5)) {
                    recorridosMasSeguros(v, visitados, lista, listas);
                    lista = lista.subList(0, size);
                }
            }
            
        }
        visitados[vertice.getPosition()] = false;
    }

    public List<List<String>> recorridosMasSeguros() {
        List<List<String>> listas = new LinkedList<List<String>>();
        List<String> lista = new LinkedList<>();
        Vertex<String> vertice = bosque.search("Casa Caperucita");
        if (vertice!=null) {
            recorridosMasSeguros(vertice,new boolean[bosque.getSize()],lista,listas);
        }
        return listas;
    }
}
