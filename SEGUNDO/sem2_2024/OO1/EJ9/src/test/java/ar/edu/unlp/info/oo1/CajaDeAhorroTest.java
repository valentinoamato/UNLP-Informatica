package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CajaDeAhorroTest {
    private CajaDeAhorro cajaDeAhorro1;
    private CajaDeAhorro cajaDeAhorro2;

    @BeforeEach
    void setUp() throws Exception {
        this.cajaDeAhorro1 = new CajaDeAhorro();
        this.cajaDeAhorro2 = new CajaDeAhorro();
    }

    @Test
    void testConstructor() {
        assertEquals(this.cajaDeAhorro1.getSaldo(),  0.0);
    }

    @Test
    void testDepositar() {
        cajaDeAhorro1.depositar(1000.0);
        assertEquals(this.cajaDeAhorro1.getSaldo(),  1000.0);
    }

    @Test
    void testExtraer() {
        assertFalse(this.cajaDeAhorro1.extraer(1000.0));
        cajaDeAhorro1.depositar(1020.0);
        assertTrue(this.cajaDeAhorro1.extraer(1000.0));
        assertEquals(this.cajaDeAhorro1.getSaldo(),  0.0);
    }

    @Test
    void testTransferirACuenta() {
        assertFalse(this.cajaDeAhorro1.transferirACuenta(1000.0, this.cajaDeAhorro2));
        cajaDeAhorro1.depositar(1020.0);
        assertTrue(this.cajaDeAhorro1.transferirACuenta(1000.0, this.cajaDeAhorro2));
        assertEquals(this.cajaDeAhorro1.getSaldo(),  0.0);
        assertEquals(this.cajaDeAhorro2.getSaldo(),  1000.0);
    }
}
