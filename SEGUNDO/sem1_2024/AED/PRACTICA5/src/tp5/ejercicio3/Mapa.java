package tp5.ejercicio3;

import java.util.*;
import java.util.LinkedList;
import java.util.List;

import tp5.ejercicio1.Edge;
import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;

public class Mapa {
    Graph<String> mapa;


    public Mapa(Graph<String> mapa) {
        this.mapa = mapa;
    }

    //A
    private boolean devolverCamino(Vertex<String> vertice, String destino, boolean[] visitados,List<String> lista) {
        lista.add(vertice.getData());
        visitados[vertice.getPosition()] = true;

        if (vertice.getData()==destino) {
            return true;
        }

        for (Edge<String> arista: mapa.getEdges(vertice)) {
            Vertex<String> v = arista.getTarget();
            if (!visitados[v.getPosition()]) {
                if (devolverCamino(v,destino,visitados,lista)) {
                    return true;
                }
            }
        }

        lista.removeLast();
        return false;
    }
    
    public List<String> devolverCamino(String ciudad1, String ciudad2) {
        boolean[] visitados = new boolean[mapa.getSize()]; 
        List<String> lista = new ArrayList<String>(); 
        devolverCamino(mapa.search(ciudad1),ciudad2,visitados,lista);
        return lista;
    }

    //B
    private boolean devolverCaminoExceptuando(Vertex<String> vertice, String destino,List<String> excepciones, boolean[] visitados,List<String> lista) {
        lista.add(vertice.getData());
        visitados[vertice.getPosition()] = true;

        if (vertice.getData()==destino) {
            return true;
        }

        for (Edge<String> arista: mapa.getEdges(vertice)) {
            Vertex<String> v = arista.getTarget();
            if ((!visitados[v.getPosition()]) && (!excepciones.contains(v.getData()))) {
                if (devolverCaminoExceptuando(v,destino,excepciones,visitados,lista)) {
                    return true;
                }
            }
        }

        lista.removeLast();
        return false;
    }
    
    public List<String> devolverCaminoExceptuando(String ciudad1, String ciudad2, List<String> excepciones) {
        boolean[] visitados = new boolean[mapa.getSize()]; 
        List<String> lista = new ArrayList<String>(); 
        if ((!excepciones.contains(ciudad1) && (!excepciones.contains(ciudad2))))
            devolverCaminoExceptuando(mapa.search(ciudad1),ciudad2,excepciones,visitados,lista);
        return lista;
    }

    //C
    private void caminoMasCorto(Vertex<String> ciudad,String ciudad2,boolean[] visitados,Recorrido aux, Recorrido min) {
        aux.ciudades.add(ciudad.getData());
        visitados[ciudad.getPosition()] = true;
        if (ciudad.getData()==ciudad2) {
            if (aux.peso<min.peso) {
                min.ciudades = new LinkedList<>(aux.ciudades);
                min.peso = aux.peso;
            }
        }
        int auxLBak = aux.ciudades.size(); //backup de la longitud
        int auxWBak = aux.peso;             //backup del peso
        for (Edge<String> edge: mapa.getEdges(ciudad)) {
            Vertex<String> v = edge.getTarget();
            if (!visitados[v.getPosition()]) {
                aux.peso+=edge.getWeight();
                caminoMasCorto(v, ciudad2, visitados, aux, min);
                aux.ciudades = aux.ciudades.subList(0,auxLBak);
                aux.peso = auxWBak;
            }
        }
        visitados[ciudad.getPosition()] = false;
    }

    public List<String> caminoMasCorto(String ciudad1, String ciudad2) {
        List<String> lista = new LinkedList<String>();
        List<String> auxList = new LinkedList<String>();
        boolean[] visitados = new boolean[mapa.getSize()];
        Vertex<String> v1 = mapa.search(ciudad1);
        Recorrido min = new Recorrido(lista,Integer.MAX_VALUE);
        Recorrido aux = new Recorrido(auxList,0);
        if ((v1!=null) && (mapa.search(ciudad2)!=null)) 
            caminoMasCorto(v1, ciudad2, visitados, aux, min);
        return min.ciudades;
    }

    //D
    private boolean caminoSinCargarCombustible(Vertex<String> ciudad1, String ciudad2, boolean[] visitados, int tanqueAuto, List<String> recorrido) {
        recorrido.add(ciudad1.getData());
        visitados[ciudad1.getPosition()] = true;

        if (ciudad1.getData() == ciudad2)
            return true;
        
        for (Edge<String> edge: mapa.getEdges(ciudad1)) {
            Vertex<String> v = edge.getTarget();
            if ((!visitados[v.getPosition()]) && (edge.getWeight()<tanqueAuto)) {
                if (caminoSinCargarCombustible(v, ciudad2, visitados, (tanqueAuto-edge.getWeight()), recorrido)) {
                    return true;
                }
            }
        }
        visitados[ciudad1.getPosition()] = false;
        recorrido.removeLast();
        return false;
    }

    public List<String> caminoSinCargarCombustible(String ciudad1, String ciudad2, int tanqueAuto) {
        List<String> lista = new LinkedList<>();
        Vertex<String> v1 = mapa.search(ciudad1);
        boolean[] visitados = new boolean[mapa.getSize()];
        if ((v1 != null) && (mapa.search(ciudad2) != null))
            caminoSinCargarCombustible(v1, ciudad2, visitados, tanqueAuto, lista); 
        return lista;
    }

    //E
    private void caminoConMenorCargaDeCombustible(Vertex<String> ciudad,String ciudad2,boolean[] visitados,Cargas aux, Cargas min,int combustible) {
        aux.camino.add(ciudad.getData());
        visitados[ciudad.getPosition()] = true;
        if (ciudad.getData()==ciudad2) {
            if (aux.cargas<min.cargas) {
                min.camino = new LinkedList<>(aux.camino);
                min.cargas = aux.cargas;
            }
        }
        int auxLBak = aux.camino.size(); //backup de la longitud
        int auxCBak = aux.cargas;             //backup de las cargas
        int auxWBak = aux.peso;             //backup de las cargas
        for (Edge<String> edge: mapa.getEdges(ciudad)) {
            Vertex<String> v = edge.getTarget();
            if (!visitados[v.getPosition()]) {
                if (edge.getWeight()>aux.peso) {
                    aux.peso = combustible;
                    aux.cargas+=1;
                }
                aux.peso-=edge.getWeight();
                if (aux.peso>=0) {
                    caminoConMenorCargaDeCombustible(v, ciudad2, visitados, aux, min, combustible);
                    aux.camino = aux.camino.subList(0,auxLBak);
                }
                aux.peso = auxWBak;
                aux.cargas = auxCBak;
            }
        }
        visitados[ciudad.getPosition()] = false;
    }

    public List<String> caminoConMenorCargaDeCombustible(String ciudad1, String ciudad2,int tanque) {
        List<String> lista = new LinkedList<String>();
        List<String> auxList = new LinkedList<String>();
        boolean[] visitados = new boolean[mapa.getSize()];
        Vertex<String> v1 = mapa.search(ciudad1);
        Cargas min = new Cargas(lista,Integer.MAX_VALUE,tanque);
        Cargas aux = new Cargas(auxList,0,tanque);
        if ((v1!=null) && (mapa.search(ciudad2)!=null)) 
            caminoConMenorCargaDeCombustible(v1, ciudad2, visitados, aux, min,tanque);
        return min.camino;
    }
}
