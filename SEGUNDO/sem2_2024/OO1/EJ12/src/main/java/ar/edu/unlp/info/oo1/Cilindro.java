package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Pieza;
import java.lang.Math;

public class Cilindro extends Pieza {
    private int radio;
    private int altura;

    public Cilindro(String material, String color, int radio, int altura) {
        super(material, color);
        this.radio = radio;
        this.altura = altura;
    }

    public double getVolumen() {
        return (Math.pow(this.radio, 2) * Math.PI * this.altura);
    }

    public double getSuperficie() {
        return (2 * Math.PI * this.radio * this.altura) + (2 * Math.PI * Math.pow(this.radio, 2));
    }
}
