package tp5.ejercicio5;

public class Jubilado extends Persona{
    private boolean jubilacionRecibida;

    public Jubilado(String nombre, boolean jubilacionRecibida) {
        super(nombre);
        this.jubilacionRecibida = jubilacionRecibida;
    }

    public boolean isJubilacionRecibida() {
        return jubilacionRecibida;
    }

    public void setJubilacionRecibida(boolean jubilacionRecibida) {
        this.jubilacionRecibida = jubilacionRecibida;
    }
}
