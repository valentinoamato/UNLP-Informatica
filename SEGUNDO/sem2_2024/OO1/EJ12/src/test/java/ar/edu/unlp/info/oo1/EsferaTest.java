package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class EsferaTest {
    protected Esfera esfera1;
    protected Esfera esfera2;

    @BeforeEach
    void setUp() {
        this.esfera1 = new Esfera("Acero", "Rojo", 3);
        this.esfera2 = new Esfera("Madera", "Verde", 4);
    }

    @Test
    void testGetVolumen() {
        assertEquals(this.esfera1.getVolumen(), 113.1, 0.1);
        assertEquals(this.esfera2.getVolumen(), 268.0, 0.1);
    }

    @Test
    void testGetSuperficie() {
        assertEquals(this.esfera1.getSuperficie(), 113.1, 0.1);
        assertEquals(this.esfera2.getSuperficie(), 201.0, 0.1);
    }
}
