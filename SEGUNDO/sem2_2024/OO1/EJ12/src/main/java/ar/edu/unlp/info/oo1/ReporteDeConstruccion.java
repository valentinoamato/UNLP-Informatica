package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Pieza;
import java.util.List;
import java.util.LinkedList;

public class ReporteDeConstruccion {
    private List<Pieza> piezas;

    public ReporteDeConstruccion() {
        this.piezas = new LinkedList<Pieza>();
    }

    public void agregarPieza(Pieza pieza) {
        this.piezas.add(pieza);
    }

    public double getVolumenDeMaterial(String material) {
        return this.piezas.stream().filter(pieza -> pieza.getMaterial() == material).mapToDouble(pieza -> pieza.getVolumen()).sum();
    }

    public double getSuperficieDeColor(String color) {
        return this.piezas.stream().filter(pieza -> pieza.getColor() == color).mapToDouble(pieza -> pieza.getSuperficie()).sum();
    }
}
