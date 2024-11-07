package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CilindroTest {
    protected Cilindro cilindro1;
    protected Cilindro cilindro2;

    @BeforeEach
    void setUp() {
        this.cilindro1 = new Cilindro("Acero", "Rojo", 3, 4);
        this.cilindro2 = new Cilindro("Madera", "Verde", 4, 5);
    }

    @Test
    void testGetVolumen() {
        assertEquals(this.cilindro1.getVolumen(), 113.1, 0.1);
        assertEquals(this.cilindro2.getVolumen(), 251.3, 0.1);
    }

    @Test
    void testGetSuperficie() {
        assertEquals(this.cilindro1.getSuperficie(), 132.0, 0.1);
        assertEquals(this.cilindro2.getSuperficie(), 226.2, 0.1);
    }
}
