package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Inversion;
import java.time.LocalDate;
import java.time.Period;
import java.lang.Math;

public class PlazoFijo implements Inversion {
    private LocalDate fechaDeConstitucion;
    private double montoDepositado;
    private double porcentajeDeInteresDiario;

    public PlazoFijo(LocalDate fechaDeConstitucion, double montoDepositado, double porcentajeDeInteresDiario) {
        this.fechaDeConstitucion = fechaDeConstitucion;
        this.montoDepositado = montoDepositado;
        this.porcentajeDeInteresDiario = porcentajeDeInteresDiario;
    }

    public LocalDate getFechaDeConstitucion() {
        return this.fechaDeConstitucion;
    }

    public double getMontoDepositado() {
        return this.montoDepositado;
    }

    public double getPorcentajeDeInteresDiario() {
        return this.porcentajeDeInteresDiario;
    }

    public double valorActual() {
        return this.montoDepositado * Math.pow((this.porcentajeDeInteresDiario / 100.0 + 1), (this.fechaDeConstitucion.until(LocalDate.now()).getDays()));
    }
}

