package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Figura;
import java.lang.Math;

public class Circulo implements Figura {
    private double diametro;

    public double getDiametro() {
        return this.diametro;
    }

    public void setDiametro(double diametro) {
        this.diametro = diametro;
    }

    public double getRadio() {
        return this.diametro / 2.0;
    }

    public void setRadio(double radio) {
        this.diametro = radio * 2.0;
    }

    public double getPerimetro() {
        return this.diametro * Math.PI;
    }

    public double getArea() {
        return ((this.diametro * this.diametro) / 4.0) * Math.PI;
    }
}
