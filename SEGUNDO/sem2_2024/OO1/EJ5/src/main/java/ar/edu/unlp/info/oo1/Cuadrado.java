package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Figura;

public class Cuadrado implements Figura {
    private double lado;

    public double getLado() {
        return this.lado;
    }

    public void setLado(double lado) {
        this.lado = lado;
    }

    public double getArea() {
        return this.lado * this.lado;
    }

    public double getPerimetro() {
        return this.lado * 4.0;
    }
}
