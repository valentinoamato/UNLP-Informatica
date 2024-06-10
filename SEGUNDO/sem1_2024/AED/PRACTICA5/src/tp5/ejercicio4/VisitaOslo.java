package tp5.ejercicio4;

import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class VisitaOslo {
    private static boolean paseoEnBici(Graph<String> grafo,Vertex<String> ciudad,String destino,List<String> camino,boolean[] visitados,int tiempo,List<String> lugaresRestringidos) {
        camino.add(ciudad.getData());
        visitados[ciudad.getPosition()] = true;

        if (ciudad.getData()==destino) {
            return true;
        }

        for (Edge<String> edge: grafo.getEdges(ciudad)) {
            Vertex<String> v = edge.getTarget();
            if ((!visitados[v.getPosition()]) && (!lugaresRestringidos.contains(v.getData())) && (edge.getWeight()<=tiempo)) {
                if (paseoEnBici(grafo, v, destino, camino, visitados, (tiempo+edge.getWeight()), lugaresRestringidos)) {
                    return true;
                }
            }
        }

        visitados[ciudad.getPosition()] = false;
        camino.removeLast();
        return false;
    }
    
    public static List<String> paseoEnBici(Graph<String> grafo,String destino,int maxTiempo,List<String> lugaresRestringidos) {
        List<String> lista = new LinkedList<>();
        if ((!lugaresRestringidos.contains("Ayuntamiento")) && (!lugaresRestringidos.contains(destino))) {
            Vertex<String> ayuntamiento = grafo.search("Ayuntamiento");
            if ((ayuntamiento!=null) && (grafo.search(destino)!=null)) {
                paseoEnBici(grafo, ayuntamiento, destino, lista, new boolean[grafo.getSize()], maxTiempo, lugaresRestringidos);
            }
        }
        return lista;
    }
}
