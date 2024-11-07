package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Pieza;
import java.lang.Math;

public class PrismaRectangular extends Pieza {
    private int ladoMayor;
    private int ladoMenor;
    private int altura;

    public PrismaRectangular(String material, String color, int ladoMayor, int ladoMenor, int altura) {
        super(material, color);
        this.ladoMayor = ladoMayor;
        this.ladoMenor = ladoMenor;
        this.altura = altura;
    }

    public double getVolumen() {
        return (this.ladoMayor * this.ladoMenor * this.altura);
    }

    public double getSuperficie() {
        return 2 * (this.ladoMayor * this.ladoMenor + this.ladoMayor * this.altura + this.ladoMenor * this.altura);
    }
}
