package tp5.ejercicio7;

import java.util.ArrayList;
import java.util.Arrays;
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
    public List<String> dijkstra(String ciudad1, String ciudad2) {
        List<String> path = new ArrayList<>();
        int n = mapa.getSize();
        int[] distances = new int[n];
        Arrays.fill(distances, Integer.MAX_VALUE);
        Vertex<String> source = mapa.search(ciudad1);
        Vertex<String> destiny = mapa.search(ciudad2);
        if ((source==null) || (destiny==null)) {
            return path;
        }
        distances[source.getPosition()] = 0;

        boolean[] visited = new boolean[n];
        int[] predecessors = new int[n];
        Arrays.fill(predecessors, -1);

        for (int i = 0; i < n - 1; i++) {
            int u = selectMinVertex(distances, visited);
            if ((u == -1) || (u == destiny.getPosition())) 
                break; // If no vertex is left to process
            visited[u] = true;

            for (Edge<String> edge : mapa.getEdges(mapa.getVertex(u))) {
                int destinationPos = edge.getTarget().getPosition(); 
                if ((!visited[destinationPos]) && (distances[u] + edge.getWeight() < distances[destinationPos])) {
                    distances[destinationPos] = distances[u] + edge.getWeight();
                    predecessors[destinationPos] = u;
                }
            }
        }

        // Reconstruct the path
        for (int at = destiny.getPosition(); at != -1; at = predecessors[at]) {
            path.addFirst(mapa.getVertex(at).getData());
        }
        return path;
    }

    private static int selectMinVertex(int[] distances, boolean[] visited) {
        int minDistance = Integer.MAX_VALUE;
        int minVertex = -1;
        for (int i = 0; i < distances.length; i++) {
            if ((!visited[i]) && (distances[i] < minDistance)) {
                minDistance = distances[i];
                minVertex = i;
            }
        }
        return minVertex;
    }

    //B
    public List<String> floydWarshall(String ciudad1, String ciudad2) {
        List<String> path = new ArrayList<>();
        int n = mapa.getSize();

        // Initialize distance and next matrices
        int[][] dist = new int[n][n];
        int[][] next = new int[n][n];

        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
            Arrays.fill(next[i], -1);
        }

        for (int i = 0; i < n; i++) {
            dist[i][i] = 0;
        }

        for (Vertex<String> vertex : mapa.getVertices()) {
            int u = vertex.getPosition();
            for (Edge<String> edge : mapa.getEdges(vertex)) {
                int v = edge.getTarget().getPosition();
                dist[u][v] = edge.getWeight();
                next[u][v] = v;
            }
        }

        // Floyd-Warshall algorithm
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (dist[i][k] != Integer.MAX_VALUE && dist[k][j] != Integer.MAX_VALUE &&
                            dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                        next[i][j] = next[i][k];
                    }
                }
            }
        }

        // Reconstruct the path
        Vertex<String> source = mapa.search(ciudad1);
        Vertex<String> destiny = mapa.search(ciudad2);
        if (source == null || destiny == null) {
            return path; // Return empty path if either city is not found
        }

        int u = source.getPosition();
        int v = destiny.getPosition();

        if (dist[u][v] == Integer.MAX_VALUE) {
            return path; // No path found
        }

        while (u != v) {
            path.add(mapa.getVertex(u).getData());
            u = next[u][v];
            if (u == -1) {
                return new ArrayList<>(); // No path found
            }
        }
        path.add(mapa.getVertex(v).getData());
        return path;
    }
}
