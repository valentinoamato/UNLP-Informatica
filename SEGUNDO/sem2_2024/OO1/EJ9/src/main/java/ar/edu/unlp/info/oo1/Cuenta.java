package ar.edu.unlp.info.oo1;

public abstract class Cuenta {
    private double saldo;

    public Cuenta() {
        this.saldo = 0;
    }

    public double getSaldo() {
        return this.saldo;
    }

    protected void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    public void depositar(double monto) {
        this.saldo += monto;
    }

    public boolean extraer(double monto) {
        if (this.puedeExtraer(monto)) {
            this.extraerSinControlar(monto);
            return true;
        } else {
            return false;
        }
    }

    public boolean transferirACuenta(double monto, Cuenta cuentaDestino) {
        if (this.extraer(monto)) {
            cuentaDestino.depositar(monto);
            return true;
        } else {
            return false;
        }
    }

    protected abstract void extraerSinControlar(double monto);

    protected abstract boolean puedeExtraer(double monto);
}
