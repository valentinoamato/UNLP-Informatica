package ar.edu.unlp.info.oo1;

import java.time.LocalDate;
import java.util.List;
import java.util.LinkedList;

public class Farola {
    private boolean on;
    private List<Farola> vecinos;

    /*
    * Crear una farola. Debe inicializarla como apagada
    */
    public Farola () {
        this.on = false;
        this.vecinos = new LinkedList<Farola>();
    }

    /*
    * Crea la relación de vecinos entre las farolas. La relación de vecinos entre las farolas es recíproca, es decir el receptor del mensaje será vecino de otraFarola, al igual que otraFarola también se convertirá en vecina del receptor del mensaje
    */
    public void pairWithNeighbor( Farola otraFarola ) {
        if (!this.vecinos.contains(otraFarola)) {
            this.vecinos.add(otraFarola);
            otraFarola.pairWithNeighbor(this);
        }
    }

    /*
    * Retorna sus farolas vecinas
    */
    public List<Farola> getNeighbors () {
        return this.vecinos;
    }

    /*
    * Si la farola no está encendida, la enciende y propaga la acción.
    */
    public void turnOn() {
        if (!this.on) {
            this.on = true;
            this.vecinos.stream().forEach(vecino -> vecino.turnOn());
        }
    }

    /*
    * Si la farola no está apagada, la apaga y propaga la acción.
    */
    public void turnOff() {
        if (this.on) {
            this.on = false;
            this.vecinos.stream().forEach(vecino -> vecino.turnOff());
        }
    }

    /*
    * Retorna true si la farola está encendida.
    */
    public boolean isOn() {
        return this.on;
    }

    /*
    * Retorna true si la farola está apagada.
    */
    public boolean isOff() {
        return !this.on;
    }
}
