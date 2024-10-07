package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Figura;

public class Cuerpo3D {
    private Figura caraBasal;
    private double altura;

    public void setAltura(double altura) {
        this.altura = altura;
    }

    public double getAltura() {
        return this.altura;
    }

    public void setCaraBasal(Figura caraBasal) {
        this.caraBasal = caraBasal;
    }

    public Figura getCaraBasal() {
        return this.caraBasal;
    }

    public double getVolumen() {
        return this.caraBasal.getArea() * this.altura;
    }

    public double getSuperficieExterior() {
        return 2.0 * this.caraBasal.getArea() + this.caraBasal.getPerimetro() * this.altura;
    }
}
