package ar.edu.unlp.info.oo1;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class CuentaCorrienteTest {
    private CuentaCorriente cuentaCorriente1;
    private CuentaCorriente cuentaCorriente2;

    @BeforeEach
    void setUp() throws Exception {
        this.cuentaCorriente1 = new CuentaCorriente();
        this.cuentaCorriente2 = new CuentaCorriente();
    }

    @Test
    void testConstructor() {
        assertEquals(this.cuentaCorriente1.getSaldo(),  0.0);
        assertEquals(this.cuentaCorriente1.getDescubierto(),  0.0);
    }

    @Test
    void testSetDescubierto() {
        this.cuentaCorriente1.setDescubierto(1000.0);
        assertEquals(this.cuentaCorriente1.getDescubierto(),  1000.0);
    }

    @Test
    void testDepositar() {
        this.cuentaCorriente1.depositar(1000.0);
        assertEquals(this.cuentaCorriente1.getSaldo(),  1000.0);
    }

    @Test
    void testExtraer() {
        assertFalse(this.cuentaCorriente1.extraer(1000.0));
        this.cuentaCorriente1.depositar(1000.0);
        assertTrue(this.cuentaCorriente1.extraer(1000.0));
        assertEquals(this.cuentaCorriente1.getSaldo(),  0.0);

        assertFalse(this.cuentaCorriente1.extraer(1000.0));
        this.cuentaCorriente1.depositar(500.0);
        this.cuentaCorriente1.setDescubierto(-500.0);
        assertTrue(this.cuentaCorriente1.extraer(1000.0));
        assertEquals(this.cuentaCorriente1.getSaldo(),  -500.0);
    }

    @Test
    void testTransferirACuenta() {
        assertFalse(this.cuentaCorriente1.transferirACuenta(1000.0, this.cuentaCorriente2));
        this.cuentaCorriente1.depositar(1000.0);
        assertTrue(this.cuentaCorriente1.transferirACuenta(1000.0, this.cuentaCorriente2));
        assertEquals(this.cuentaCorriente1.getSaldo(),  0.0);
        assertEquals(this.cuentaCorriente2.getSaldo(),  1000.0);

        assertFalse(this.cuentaCorriente1.transferirACuenta(1000.0, this.cuentaCorriente2));
        this.cuentaCorriente1.depositar(500.0);
        this.cuentaCorriente1.setDescubierto(-500.0);
        assertTrue(this.cuentaCorriente1.transferirACuenta(1000.0, this.cuentaCorriente2));
        assertEquals(this.cuentaCorriente1.getSaldo(),  -500.0);
        assertEquals(this.cuentaCorriente2.getSaldo(),  2000.0);
    }
}
