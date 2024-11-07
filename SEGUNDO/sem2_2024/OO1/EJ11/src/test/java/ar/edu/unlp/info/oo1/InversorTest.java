package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class InversorTest {
    protected PlazoFijo plazoFijo1;
    protected PlazoFijo plazoFijo2;
    protected InversionEnAcciones inversionEnAcciones1;
    protected InversionEnAcciones inversionEnAcciones2;
    protected LocalDate diezDiasAtras;
    protected Inversor inversor;

    @BeforeEach
    void setUp() {
        this.diezDiasAtras = LocalDate.now().minusDays(10);
        this.plazoFijo1 = new PlazoFijo(diezDiasAtras, 2.0, 100.0);
        this.plazoFijo2 = new PlazoFijo(diezDiasAtras, 6.0, 6.0);
        this.inversionEnAcciones1 = new InversionEnAcciones("Nvidia", 6, 12.0);
        this.inversionEnAcciones2 = new InversionEnAcciones("Amazon", 4, 3.0);
        this.inversor = new Inversor("Pedro");
        this.inversor.agregarInversion(plazoFijo1);
        this.inversor.agregarInversion(plazoFijo2);
        this.inversor.agregarInversion(inversionEnAcciones1);
        this.inversor.agregarInversion(inversionEnAcciones2);
    }

    @Test
    void testValorActual() {
        assertEquals(this.inversor.valorActual(), 2142.74508618, 0.00001);
    }
}

