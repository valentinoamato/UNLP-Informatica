package tp5.ejercicio5;

import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Banco {
    private static void algoritmo(Graph<Persona> grafo,boolean[] visitados,Vertex<Persona> persona,List<Jubilado> jubilados,int actual, int maxima) {
        if (jubilados.size()==40) {
            return;
        }
        if (persona.getData() instanceof Jubilado) {
            Jubilado jubilado = (Jubilado) persona.getData();
            if ((!jubilado.isJubilacionRecibida()) && (!jubilados.contains(jubilado))) {
                jubilados.add(jubilado);
            }
        }
        visitados[persona.getPosition()] = true;
        if (actual<maxima) {
            for (Edge<Persona> edge:grafo.getEdges(persona)) {
                Vertex<Persona> p = edge.getTarget();
                if (!visitados[p.getPosition()]) {
                    algoritmo(grafo, visitados, p, jubilados, (actual+1), maxima);
                }
            }
            
        }
        visitados[persona.getPosition()] = false;

    }

    public static List<Jubilado> algoritmo(Graph<Persona> personas,Empleado empleado,int distancia) {
        List<Jubilado> jubilados = new LinkedList<>();
        Vertex<Persona> persona = personas.search(empleado);
        if (persona!=null) {
            algoritmo(personas, new boolean[personas.getSize()], persona, jubilados, 0, distancia);
        }
        return jubilados;
    }

    public static void imprimirJubilados(List<Jubilado> jubilados) {
        System.out.println();
        System.out.print("[");
        Jubilado j = jubilados.removeLast();
        for (Jubilado jubilado:jubilados) {
            System.out.print(jubilado.getNombre()+", ");
        }
        System.out.print(j.getNombre()+"]");
    }
}
