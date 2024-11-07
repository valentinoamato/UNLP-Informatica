package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class InversionEnAccionesTest {
    protected InversionEnAcciones inversionEnAcciones1;
    protected InversionEnAcciones inversionEnAcciones2;

    @BeforeEach
    void setUp() {
        this.inversionEnAcciones1 = new InversionEnAcciones("Apple", 5, 10.0);
        this.inversionEnAcciones2 = new InversionEnAcciones("Mercado Libre", 10, 6.0);
    }

    @Test
    void testConstructor() {
        assertEquals(this.inversionEnAcciones1.getNombre(), "Apple");
        assertEquals(this.inversionEnAcciones1.getCantidad(), 5);
        assertEquals(this.inversionEnAcciones1.getValorUnitario(), 10.0);
    }

    @Test
    void testValorActual() {
        assertEquals(this.inversionEnAcciones1.valorActual(), 50.0);
        assertEquals(this.inversionEnAcciones2.valorActual(), 60.0);
    }
}
