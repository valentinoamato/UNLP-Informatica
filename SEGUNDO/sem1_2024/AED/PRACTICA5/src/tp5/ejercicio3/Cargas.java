package tp5.ejercicio3;

import java.util.List;

public class Cargas {
    public List<String> camino;
    public int cargas;
    public int peso;
    
    
    public Cargas(List<String> camino, int cargas, int combustible) {
        this.camino = camino;
        this.cargas = cargas;
        this.peso = combustible;
    }
}
