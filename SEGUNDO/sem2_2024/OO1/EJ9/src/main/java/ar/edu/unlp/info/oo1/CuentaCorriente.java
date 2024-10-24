package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Cuenta;

public class CuentaCorriente extends Cuenta {
    private double descubierto;

    public CuentaCorriente() {
        super();
        this.descubierto = 0;
    }

    protected void extraerSinControlar(double monto) {
        this.setSaldo(this.getSaldo() - monto);
    }

    protected boolean puedeExtraer(double monto) {
        return (this.getSaldo() - monto) >= this.descubierto;
    }

    public double getDescubierto() {
        return this.descubierto;
    }

    public void setDescubierto(double descubierto) {
        this.descubierto = descubierto;
    }
}
