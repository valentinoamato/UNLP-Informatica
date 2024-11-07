package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class PlazoFijoTest {
    protected PlazoFijo plazoFijo1;
    protected PlazoFijo plazoFijo2;
    protected LocalDate diezDiasAtras;

    @BeforeEach
    void setUp() {
        this.diezDiasAtras = LocalDate.now().minusDays(10);
        this.plazoFijo1 = new PlazoFijo(diezDiasAtras, 1.0, 100.0);
        this.plazoFijo2 = new PlazoFijo(diezDiasAtras, 5.0, 5.0);
    }

    @Test
    void testConstructor() {
        assertEquals(this.plazoFijo1.getFechaDeConstitucion(), this.diezDiasAtras);
        assertEquals(this.plazoFijo1.getMontoDepositado(), 1.0);
        assertEquals(this.plazoFijo1.getPorcentajeDeInteresDiario(), 100.0);
    }

    @Test
    void testValorActual() {
        assertEquals(this.plazoFijo1.valorActual(), 1024.0);
        assertEquals(this.plazoFijo2.valorActual(), 8.144473134, 0.0000001);
    }
}
