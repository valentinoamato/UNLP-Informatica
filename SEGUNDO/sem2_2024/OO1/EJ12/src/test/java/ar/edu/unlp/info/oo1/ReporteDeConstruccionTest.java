package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class ReporteDeConstruccionTest {
    private ReporteDeConstruccion reporteDeConstruccion;
    private Pieza prismaRectangular1;
    private Pieza prismaRectangular2;
    private Pieza cilindro1;
    private Pieza cilindro2;
    private Pieza esfera1;
    private Pieza esfera2;

    @BeforeEach
    void setUp() {
        this.reporteDeConstruccion = new ReporteDeConstruccion();
        this.prismaRectangular1 = new PrismaRectangular("Acero", "Rojo", 3, 4, 5);
        this.prismaRectangular2 = new PrismaRectangular("Madera", "Verde", 4, 5 ,6);
        this.esfera1 = new Esfera("Acero", "Rojo", 3);
        this.esfera2 = new Esfera("Madera", "Verde", 4);
        this.cilindro1 = new Cilindro("Acero", "Rojo", 3, 4);
        this.cilindro2 = new Cilindro("Madera", "Verde", 4, 5);
        this.reporteDeConstruccion.agregarPieza(this.prismaRectangular1);
        this.reporteDeConstruccion.agregarPieza(this.prismaRectangular2);
        this.reporteDeConstruccion.agregarPieza(this.cilindro1);
        this.reporteDeConstruccion.agregarPieza(this.cilindro2);
        this.reporteDeConstruccion.agregarPieza(this.esfera1);
        this.reporteDeConstruccion.agregarPieza(this.esfera2);
    }

    @Test
    void testGetVolumenDeMaterial() {
        assertEquals(this.reporteDeConstruccion.getVolumenDeMaterial("Acero"), 114.0 + 113.1 + 60.0, 1);
        assertEquals(this.reporteDeConstruccion.getVolumenDeMaterial("Madera"), 251.3 + 268.0 + 120.0, 1);
    }

    @Test
    void testGetSuperficie() {
        assertEquals(this.reporteDeConstruccion.getSuperficieDeColor("Rojo"), 132.0 + 113.1 + 94.0, 1);
        assertEquals(this.reporteDeConstruccion.getSuperficieDeColor("Verde"), 226.2 + 201.0 + 148.0, 1);
    }
}
