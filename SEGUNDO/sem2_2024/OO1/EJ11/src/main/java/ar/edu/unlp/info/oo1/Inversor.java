package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Inversion;
import java.util.List;
import java.util.LinkedList;

public class Inversor {
    private String nombre;
    private List<Inversion> inversiones;

    public Inversor(String nombre) {
        this.nombre = nombre;
        this.inversiones = new LinkedList<Inversion>();
    }

    public String getNombre() {
        return this.nombre;
    }

    public void agregarInversion(Inversion inversion) {
        this.inversiones.add(inversion);
    }

    public double valorActual() {
        return this.inversiones.stream().mapToDouble(inversion -> inversion.valorActual()).sum();
    }
}
