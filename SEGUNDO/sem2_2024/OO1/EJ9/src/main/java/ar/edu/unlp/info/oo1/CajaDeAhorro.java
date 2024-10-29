package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Cuenta;

public class CajaDeAhorro extends Cuenta {

    public CajaDeAhorro() {
        super();
    }

    protected void extraerSinControlar(double monto) {
        this.setSaldo(this.getSaldo() - (monto * 1.02));
    }

    protected boolean puedeExtraer(double monto) {
        return this.getSaldo() >= (monto* 1.02);
    }
}

